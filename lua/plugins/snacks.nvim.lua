---@type snacks.picker.layout.Config
local custom_dropdown_layout = {
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
      { win = "input", height = 1, border = "bottom" },
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
    { win = "list", border = "none" },
    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
  },
}

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
    input = { enabled = false },
    layout = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    picker = {
      enabled = true,
      matcher = {
        frecency = true,
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

        vim.keymap.set("n", "<leader>pg", function()
          Snacks.picker.grep({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>pd", function()
          Snacks.picker.diagnostics_buffer({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>pD", function()
          Snacks.picker.diagnostics({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>pu", function()
          Snacks.picker.undo({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "gR", function()
          Snacks.picker.lsp_references({ layout = custom_dropdown_layout })
        end)

        vim.keymap.set("n", "<leader>pc", function()
          Snacks.picker.git_log_file({
            confirm = "",
            layout = custom_dropdown_layout,
          })
        end)
      end,
    })
  end,
}
