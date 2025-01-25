return {
  "zenbones-theme/zenbones.nvim",
  dependencies = "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.zenbones_darken_comments = 45
    -- vim.cmd.colorscheme('zenbones')

    vim.api.nvim_create_user_command("WriterMode", function(_)
      vim.cmd("set background=light")
      vim.cmd("colorscheme seoulbones")
      vim.cmd("set wrap")
      vim.cmd("set cc=")
      vim.cmd("highlight WriterMode gui=bold")
      vim.cmd("match WriterMode /./")
      vim.opt.guifont = { "JetBrains Mono NL SemiBold", ":h17" }
    end, { desc = "Set light colorscheme and word wrap" })
  end,
}
