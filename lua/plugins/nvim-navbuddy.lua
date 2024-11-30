return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("nvim-navbuddy").setup({
      lsp = {
        auto_attach = true,
      },
    })

    vim.keymap.set("n", "<leader>ns", ":Navbuddy<CR>")
  end,
}
