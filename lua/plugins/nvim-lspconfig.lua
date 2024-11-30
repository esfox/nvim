return {
  -- lsp configuration & plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- automatically install lsps to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- useful status updates for lsp
    -- note: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim", opts = {}, tag = "legacy" },

    -- additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
}
