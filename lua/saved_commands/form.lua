local Popup = require("nui.popup")
local Layout = require("nui.layout")
local Input = require("nui.input")
local storage = require("saved_commands.storage")

local M = {}

M.save_command = storage.save_command

--- Helper to create standardized text input field
--- @param title string
--- @param default_val string
--- @param on_change fun(val: string)
--- @return nui_input
local function create_field_input(title, default_val, on_change)
  return Input({
    border = {
      style = "rounded",
      text = { top = " " .. title .. " ", top_align = "left" },
    },
    win_options = { winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" },
  }, {
    prompt = "  ",
    default_value = default_val or "",
    on_change = on_change,
  })
end

--- Open Form Modal for Creating or Editing a Saved Command
--- @param initial_data? table|string optional table of cmd_data or initial command string
function M.open_create_form(initial_data)
  local is_edit = type(initial_data) == "table" and initial_data.name ~= nil
  local original_name = is_edit and initial_data.name or nil

  local form_data = {
    name = (is_edit and initial_data.name) or "",
    keyword = (is_edit and initial_data.keyword) or "",
    description = (is_edit and initial_data.description) or "",
    command = (is_edit and initial_data.command) or (type(initial_data) == "string" and initial_data) or "",
    tags = (is_edit and initial_data.tags and table.concat(initial_data.tags, ", ")) or "",
  }

  -- 1. Name Input
  local name_input = create_field_input("Name (Required)", form_data.name, function(val)
    form_data.name = val
  end)

  -- 2. Keyword / Nickname Input
  local keyword_input = create_field_input("Keyword / Nickname (e.g. gcm, dke)", form_data.keyword, function(val)
    form_data.keyword = val
  end)

  -- 3. Description Input
  local desc_input = create_field_input("Description", form_data.description, function(val)
    form_data.description = val
  end)

  -- 4. Command Popup (Textarea supporting multi-line & syntax)
  local cmd_popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = "rounded",
      text = { top = " Command Template (e.g. {param:default}) ", top_align = "left" },
    },
    win_options = { winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" },
  })

  -- 5. Tags Input
  local tags_input = create_field_input("Tags (comma separated)", form_data.tags, function(val)
    form_data.tags = val
  end)

  -- 6. Footer / Controls Popup
  local footer_popup = Popup({
    enter = false,
    focusable = false,
    border = {
      style = "none",
    },
    win_options = { winhighlight = "Normal:Comment" },
  })

  local fields = {
    { comp = name_input, is_popup = false },
    { comp = keyword_input, is_popup = false },
    { comp = desc_input, is_popup = false },
    { comp = cmd_popup, is_popup = true },
    { comp = tags_input, is_popup = false },
  }

  local current_field_idx = 1
  local layout = nil

  local width = math.min(80, math.floor(vim.o.columns * 0.85))
  local height = math.min(25, math.floor(vim.o.lines * 0.8))

  layout = Layout(
    {
      position = "50%",
      size = {
        width = width,
        height = height,
      },
    },
    Layout.Box({
      Layout.Box(name_input, { size = 3 }),
      Layout.Box(keyword_input, { size = 3 }),
      Layout.Box(desc_input, { size = 3 }),
      Layout.Box(cmd_popup, { grow = 1 }),
      Layout.Box(tags_input, { size = 3 }),
      Layout.Box(footer_popup, { size = 1 }),
    }, { dir = "col" })
  )

  layout:mount()

  -- Initialize Command buffer
  local cmd_buf = cmd_popup.bufnr
  vim.bo[cmd_buf].buftype = "nofile"
  vim.bo[cmd_buf].bufhidden = "wipe"
  vim.bo[cmd_buf].filetype = "zsh"
  vim.bo[cmd_buf].modifiable = true
  if form_data.command and form_data.command ~= "" then
    vim.api.nvim_buf_set_lines(cmd_buf, 0, -1, false, vim.split(form_data.command, "\n"))
  else
    vim.api.nvim_buf_set_lines(cmd_buf, 0, -1, false, { "" })
  end

  -- Initialize Footer text
  local footer_buf = footer_popup.bufnr
  vim.bo[footer_buf].modifiable = true
  vim.api.nvim_buf_set_lines(footer_buf, 0, -1, false, {
    " <Tab>/<S-Tab>: Switch fields  |  <C-s>: Save  |  <Esc>: Cancel",
  })
  vim.bo[footer_buf].modifiable = false

  local function close_form()
    layout:unmount()
  end

  local function get_cmd_text()
    if vim.api.nvim_buf_is_valid(cmd_buf) then
      local lines = vim.api.nvim_buf_get_lines(cmd_buf, 0, -1, false)
      return vim.trim(table.concat(lines, "\n"))
    end
    return form_data.command
  end

  local function focus_field(idx)
    if idx < 1 then
      idx = #fields
    elseif idx > #fields then
      idx = 1
    end
    current_field_idx = idx

    local target = fields[idx]
    local target_win = target.comp.winid
    if target_win and vim.api.nvim_win_is_valid(target_win) then
      vim.api.nvim_set_current_win(target_win)
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(target_win) and vim.api.nvim_get_current_win() == target_win then
          vim.cmd("startinsert!")
        end
      end)
    end
  end

  local function submit_form()
    local name = vim.trim(form_data.name or "")
    local command_str = get_cmd_text()

    if name == "" then
      vim.notify("Command Name is required!", vim.log.levels.WARN)
      focus_field(1)
      return
    end

    if command_str == "" then
      vim.notify("Command Template is required!", vim.log.levels.WARN)
      focus_field(4)
      return
    end

    local tag_list = {}
    if form_data.tags and form_data.tags ~= "" then
      for t in form_data.tags:gmatch("[^,]+") do
        local cleaned = vim.trim(t)
        if cleaned ~= "" then
          table.insert(tag_list, cleaned)
        end
      end
    end

    local new_entry = {
      name = name,
      keyword = vim.trim(form_data.keyword or ""),
      description = vim.trim(form_data.description or ""),
      command = command_str,
      tags = tag_list,
    }

    local ok, err = storage.save_command(new_entry, original_name)
    if ok then
      vim.notify((is_edit and "Updated" or "Saved") .. " command: " .. name, vim.log.levels.INFO)
      close_form()
    else
      vim.notify("Failed to save: " .. tostring(err), vim.log.levels.ERROR)
    end
  end

  -- Keybindings across all fields
  local function bind_keys(comp, is_popup)
    local target_buf = comp.bufnr
    if not target_buf or not vim.api.nvim_buf_is_valid(target_buf) then
      return
    end

    -- Tab / S-Tab navigation
    vim.keymap.set({ "n", "i" }, "<Tab>", function()
      focus_field(current_field_idx + 1)
    end, { buffer = target_buf, silent = true })

    vim.keymap.set({ "n", "i" }, "<S-Tab>", function()
      focus_field(current_field_idx - 1)
    end, { buffer = target_buf, silent = true })

    -- Save (<C-s> or <C-CR>)
    vim.keymap.set({ "n", "i" }, "<C-s>", submit_form, { buffer = target_buf, silent = true })
    vim.keymap.set({ "n", "i" }, "<C-CR>", submit_form, { buffer = target_buf, silent = true })
    vim.keymap.set({ "n", "i" }, "<M-CR>", submit_form, { buffer = target_buf, silent = true })

    -- Cancel
    vim.keymap.set("n", "<Esc>", close_form, { buffer = target_buf, silent = true })
    vim.keymap.set("n", "q", close_form, { buffer = target_buf, silent = true })

    if not is_popup then
      -- Enter in single-line inputs jumps to next field
      vim.keymap.set({ "n", "i" }, "<CR>", function()
        if current_field_idx == #fields then
          submit_form()
        else
          focus_field(current_field_idx + 1)
        end
      end, { buffer = target_buf, silent = true })
    end
  end

  for _, f in ipairs(fields) do
    bind_keys(f.comp, f.is_popup)
  end

  -- Start focus in Name field (field 1)
  vim.schedule(function()
    focus_field(1)
  end)
end

return M
