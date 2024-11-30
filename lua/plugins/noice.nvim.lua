return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
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
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
