return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup()

    vim.diagnostic.config({ virtual_lines = false })

    vim.keymap.set("", "gE", function()
      require("lsp_lines").toggle()
      local to_enable_virtual_text = not vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = to_enable_virtual_text })
    end, { desc = "Toggle lsp_lines" })
  end,
}
