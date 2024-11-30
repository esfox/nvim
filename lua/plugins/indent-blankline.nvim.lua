return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  lazy = false,
  priority = 900,
  config = function()
    local hooks = require("ibl.hooks")

    local highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
    }

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#384651", nocombine = true })
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#404e41", nocombine = true })
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#4c413d", nocombine = true })
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#535031", nocombine = true })
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#594b36", nocombine = true })
    end)

    require("ibl").setup({
      scope = {
        enabled = true,
      },
      indent = {
        char = "│",
        highlight = highlight,
      },
    })
  end,
}
