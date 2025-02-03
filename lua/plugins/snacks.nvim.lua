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
    layout = { enabled = true },
    notifier = { enabled = false },
    notify = { enabled = false },
    picker = { enabled = true },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    rename = { enabled = false },
    scope = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = true },
    win = { enabled = true },
    words = { enabled = false },
    zen = { enabled = false },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- commands, command_history, lines, cliphist (?), diagnostics, git_diff, grep, lsp, undo, search_history

        vim.keymap.set({ "n", "v" }, "<leader>p", function()
          Snacks.picker.undo()
        end)

        vim.keymap.set({ "n", "i", "v" }, "<c-p>", function()
          Snacks.picker.smart({
            reverse = true,
            layout = {
              preset = "select",
            },
            format = "file",
            filter = {
              cwd = true,
            },
            matcher = {
              cwd_bonus = true,
              frecency = true,
              sort_empty = true,
            },
            transform = "unique_file",
          })
        end)

        vim.keymap.set("n", "gR", function()
          Snacks.picker.lsp_references({
            reverse = true,
            layout = {
              preset = "dropdown",
            },
          })
        end)
      end,
    })
  end,
}
