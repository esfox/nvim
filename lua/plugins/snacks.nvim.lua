---@type snacks.picker.layout.Config
local custom_dropdown_layout = {
  layout = {
    position = "float",
    backdrop = false,
    row = 1,
    width = 0.85,
    min_width = 80,
    height = 0.8,
    border = "none",
    box = "vertical",
    { win = "preview", title = "{preview}", border = "single" },
    {
      box = "vertical",
      border = "single",
      title = "{title} {live} {flags}",
      title_pos = "center",
      { win = "input", height = 1, border = "bottom" },
      {
        win = "list",
        border = "none",
        wo = {
          winhighlight = "CursorLine:Visual",
          relativenumber = true,
        },
      },
    },
  },
}

---@type snacks.picker.layout.Config
local custom_no_input_layout = {
  reverse = true,
  layout = {
    backdrop = false,
    row = 1,
    width = 0.85,
    min_width = 80,
    height = 0.8,
    border = "none",
    box = "vertical",
    { win = "list", border = "single" },
    {
      box = "vertical",
      border = "single",
      title = "{title} {live} {flags}",
      title_pos = "center",
      { win = "preview", title = "{preview}", border = "none" },
    },
  },
}

---@type snacks.picker.layout.Config
local custom_select_layout = {
  preview = false,
  layout = {
    backdrop = false,
    width = 0.7,
    min_width = 80,
    height = 0.5,
    min_height = 3,
    box = "vertical",
    border = "single",
    title = "{title}",
    title_pos = "center",
    { win = "input", height = 1, border = "bottom" },
    {
      win = "list",
      border = "none",
      wo = {
        winhighlight = "CursorLine:Visual",
        relativenumber = true,
      },
    },
    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
  },
}

local function get_list_keymaps()
  local limit = 50
  local keymap = {
    ["<c-k>"] = { "focus_input", mode = { "i", "n" } },
    ["<c-i>"] = { "focus_preview", mode = { "i", "n" } },
    ["m"] = function()
      local hop = require("hop")
      hop.hint_lines({})
    end,
  }

  for i = 1, limit do
    keymap[i .. "j"] = function()
      vim.api.nvim_input(string.rep("j", i))
    end

    keymap[i .. "k"] = function()
      vim.api.nvim_input(string.rep("k", i))
    end
  end

  return keymap
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = false,
      animate = {
        enabled = false,
      },
    },
    animate = { enabled = false },
    bigfile = { enabled = false },
    bufdelete = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    dim = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    image = { enabled = true },
    input = { enabled = false },
    layout = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    picker = {
      enabled = true,
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            ["<c-k>"] = { "focus_list", mode = { "i", "n" } },
            ["<c-i>"] = { "focus_preview", mode = { "i", "n" } },
          },
        },
        list = {
          keys = get_list_keymaps(),
        },
        preview = {
          keys = {
            ["<c-k>"] = { "focus_list", mode = { "i", "n" } },
            ["<c-i>"] = { "focus_input", mode = { "i", "n" } },
          },
        },
      },
    },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    rename = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- commands, command_history, lines, cliphist (?), diagnostics, git_diff, grep, lsp, undo, search_history

        vim.keymap.set({ "n", "i", "v" }, "<c-p>", function()
          Snacks.picker.smart({
            layout = custom_select_layout,
            format = "file",
            hidden = true,
            filter = {
              cwd = true,
            },
            formatters = {
              file = {
                filename_first = true,
                truncate = 100,
              },
            },
            matcher = {
              cwd_bonus = true,
              frecency = true,
              sort_empty = true,
            },
            transform = "unique_file",
          })
        end)

        vim.keymap.set({ "n", "v" }, "<leader>/", function()
          get_list_keymaps()
          Snacks.picker.lines({
            jump = { match = false },
            layout = {
              preview = false,
            },
          })
        end)

        vim.keymap.set({ "n", "v" }, "<leader>;", function()
          Snacks.picker.commands({ layout = custom_select_layout })
        end)

        vim.keymap.set({ "n", "v" }, "<leader>:", function()
          Snacks.picker.command_history({ layout = custom_select_layout })
        end)

        vim.keymap.set("n", "<leader>lg", function()
          Snacks.picker.grep({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>ld", function()
          Snacks.picker.diagnostics_buffer({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>lD", function()
          Snacks.picker.diagnostics({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>lu", function()
          Snacks.picker.undo({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>ls", function()
          Snacks.picker.lsp_symbols({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>lS", function()
          Snacks.picker.lsp_workspace_symbols({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "gR", function()
          Snacks.picker.lsp_references({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>lc", function()
          Snacks.picker.git_log_file({
            focus = "list",
            confirm = "",
            layout = custom_no_input_layout,
          })
        end)

        vim.keymap.set("n", "<leader>sh", function()
          Snacks.picker.help({ layout = custom_dropdown_layout })
        end)
      end,
    })
  end,
}
