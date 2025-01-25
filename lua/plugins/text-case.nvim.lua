return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")

    vim.keymap.set({ "n", "v" }, "gt", "<cmd>TextCaseOpenTelescope<CR>")
  end,
}
