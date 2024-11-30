return {
  "Wansmer/treesj",
  config = function()
    require("treesj").setup({
      max_join_length = 1000,
      use_default_keymaps = false,
    })

    vim.keymap.set("n", "<leader>js", ":TSJSplit<CR>")
    vim.keymap.set("n", "<leader>jj", ":TSJJoin<CR>")
  end,
}
