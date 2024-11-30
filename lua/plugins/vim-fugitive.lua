return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gb", function()
      vim.cmd("silent! Git blame")
    end)
  end,
}
