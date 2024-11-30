return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({})

    vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics<cr>")
  end,
}
