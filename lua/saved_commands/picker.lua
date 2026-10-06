local storage = require("saved_commands.storage")
local template = require("saved_commands.template")

local M = {}

M.load_commands = storage.load_commands

--- Build searchable picker items from commands list
--- @param commands table[]
--- @return table[]
local function build_picker_items(commands)
  local items = {}

  -- Special top item to create a new command
  table.insert(items, {
    text = "+ Create New Command... (Add to saved commands)",
    display = "+ Create New Command...",
    is_create = true,
    cmd_data = {
      name = "+ Create New Command...",
      description = "Open form to create and save a new command snippet",
      command = "",
      tags = { "new" },
    },
    preview = {
      text = "# Create a new saved command\n# Press <CR> to open creation form",
      ft = "zsh",
    },
  })

  for _, cmd in ipairs(commands) do
    local kw_str = (cmd.keyword and cmd.keyword ~= "") and (" (" .. cmd.keyword .. ")") or ""
    local tags_str = (cmd.tags and #cmd.tags > 0) and (" [" .. table.concat(cmd.tags, ", ") .. "]") or ""
    local desc_str = cmd.description and cmd.description ~= "" and (" - " .. cmd.description) or ""
    local display_text = cmd.name .. kw_str .. tags_str .. desc_str

    -- Put keyword first in search_text so typing the keyword matches immediately
    local search_text = (cmd.keyword or "") .. " " .. display_text .. " " .. cmd.command

    table.insert(items, {
      text = search_text,
      display = cmd.name .. tags_str,
      keyword = cmd.keyword or "",
      cmd_data = cmd,
      preview = {
        text = cmd.command,
        ft = "zsh",
      },
    })
  end

  return items
end

--- Apply a selected command to either Command Editor or Terminal buffer
--- @param cmd_data table
--- @param is_in_modal boolean
local function apply_selected_command(cmd_data, is_in_modal)
  local layout = require("layout")
  local raw_cmd = cmd_data.command
  local has_params = template.has_placeholders(raw_cmd)

  if is_in_modal then
    -- Inside command editor modal: replace entire input and expand template
    if layout.modal_buf and vim.api.nvim_buf_is_valid(layout.modal_buf) then
      vim.api.nvim_set_current_win(layout.modal_win)
      if has_params then
        template.apply_template(layout.modal_buf, raw_cmd)
      else
        template.clear()
        vim.api.nvim_buf_set_lines(layout.modal_buf, 0, -1, false, vim.split(raw_cmd, "\n"))
        vim.cmd("startinsert!")
      end
    end
  else
    -- In terminal buffer
    if not has_params then
      -- Parameterless: append directly to cursor in terminal buffer without replacing prompt
      if layout.term_win and vim.api.nvim_win_is_valid(layout.term_win) then
        vim.api.nvim_set_current_win(layout.term_win)
      end
      if layout.term_chan then
        vim.api.nvim_chan_send(layout.term_chan, raw_cmd)
      end
      vim.cmd("startinsert")
    else
      -- Has parameters: open Command Editor modal and populate template
      layout.open_command_modal()
      vim.schedule(function()
        if layout.modal_buf and vim.api.nvim_buf_is_valid(layout.modal_buf) then
          template.apply_template(layout.modal_buf, raw_cmd)
        end
      end)
    end
  end
end

--- Open fuzzy finder for saved commands
function M.open_picker()
  local layout = require("layout")
  local commands = storage.load_commands()
  if #commands == 0 then
    vim.notify("No saved commands found in " .. storage.CONFIG_FILE, vim.log.levels.WARN)
    return
  end

  local is_in_modal = layout.modal_buf and vim.api.nvim_buf_is_valid(layout.modal_buf) and vim.api.nvim_get_current_buf() == layout.modal_buf
  local items = build_picker_items(commands)

  local ok_snacks, snacks = pcall(require, "snacks")
  if not ok_snacks or not snacks.picker then
    vim.notify("Snacks.picker not available", vim.log.levels.ERROR)
    return
  end

  snacks.picker({
    title = " Saved Commands ",
    layout = {
      layout = {
        position = "float",
        backdrop = false,
        width = 0.8,
        min_width = 70,
        height = 0.8,
        box = "vertical",
        {
          box = "vertical",
          border = "rounded",
          title = " Saved Commands ",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
        { win = "preview", title = " Preview ", height = 0.4, border = "rounded" },
      },
    },
    win = {
      input = {
        keys = {
          ["<c-e>"] = { "edit_command", mode = { "i", "n" }, desc = "Edit saved command" },
        },
      },
      list = {
        keys = {
          ["<c-e>"] = { "edit_command", mode = { "i", "n" }, desc = "Edit saved command" },
        },
      },
    },
    actions = {
      edit_command = function(picker, item)
        if not item or not item.cmd_data or item.is_create then
          return
        end
        picker:close()
        vim.schedule(function()
          require("saved_commands.form").open_create_form(item.cmd_data)
        end)
      end,
    },
    items = items,
    matcher = {
      on_match = function(matcher, item)
        local pat = vim.trim(matcher.pattern or "")
        if pat ~= "" and item.keyword and item.keyword ~= "" then
          local l_pat = string.lower(pat)
          local l_kw = string.lower(item.keyword)
          if l_kw == l_pat then
            -- Exact match on keyword: massive score boost to guarantee #1 rank
            item.score = (item.score or 1000) + 10000000
          elseif l_kw:find(l_pat, 1, true) == 1 then
            -- Prefix match on keyword: strong boost
            item.score = (item.score or 1000) + 5000000
          end
        end
      end,
    },
    format = function(item)
      local cmd_data = item.cmd_data
      local res = {}
      table.insert(res, { cmd_data.name, "Function" })
      if cmd_data.keyword and cmd_data.keyword ~= "" then
        table.insert(res, { " (" .. cmd_data.keyword .. ")", "Special" })
      end
      if cmd_data.tags and #cmd_data.tags > 0 then
        table.insert(res, { " [" .. table.concat(cmd_data.tags, ", ") .. "]", "Comment" })
      end
      if cmd_data.description and cmd_data.description ~= "" then
        table.insert(res, { "  " .. cmd_data.description, "Normal" })
      end
      return res
    end,
    preview = function(ctx)
      local item = ctx.item
      if item and item.cmd_data then
        ctx.preview:reset()
        local lines = {
          "# " .. item.cmd_data.name,
        }
        if item.cmd_data.keyword and item.cmd_data.keyword ~= "" then
          table.insert(lines, "# Keyword: " .. item.cmd_data.keyword)
        end
        if item.cmd_data.description and item.cmd_data.description ~= "" then
          table.insert(lines, "# " .. item.cmd_data.description)
        end
        if item.cmd_data.tags and #item.cmd_data.tags > 0 then
          table.insert(lines, "# Tags: " .. table.concat(item.cmd_data.tags, ", "))
        end
        table.insert(lines, "")
        local cmd_lines = vim.split(item.cmd_data.command, "\n")
        for _, cl in ipairs(cmd_lines) do
          table.insert(lines, cl)
        end

        ctx.preview:set_lines(lines)
        ctx.preview:highlight({ ft = "zsh" })
      end
    end,
    confirm = function(picker, item)
      picker:close()
      if not item or not item.cmd_data then
        return
      end

      if item.is_create then
        local initial_cmd = nil
        if is_in_modal and layout.modal_buf and vim.api.nvim_buf_is_valid(layout.modal_buf) then
          local lines = vim.api.nvim_buf_get_lines(layout.modal_buf, 0, -1, false)
          initial_cmd = vim.trim(table.concat(lines, "\n"))
        end
        vim.schedule(function()
          require("saved_commands.form").open_create_form(initial_cmd)
        end)
        return
      end

      apply_selected_command(item.cmd_data, is_in_modal)
    end,
  })
end

return M
