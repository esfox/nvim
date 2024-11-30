return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("notify").setup({
      render = "minimal",
      timeout = 3000,
      top_down = false,
      stages = "static",
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { border = "single" })
      end,
    })

    require("noice").setup({
      lsp = {
        progress = {
          enabled = false,
        },
      },
      cmdline = {
        format = {
          cmdline = {
            view = "cmdline",
            icon = ":",
          },
          search_down = { title = "" },
          search_up = { title = "" },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "single",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>sn", ":Telescope notify<cr>")
  end,
}
