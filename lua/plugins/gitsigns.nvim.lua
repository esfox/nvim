local keymaps = require("keymaps")

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = keymaps.for_gitsigns,
    })
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
