return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    require("scrollbar.handlers.search").setup({
      override_lens = function() end,
    })
  end,
}
