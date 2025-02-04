return {
  "yioneko/nvim-vtsls",
  config = function()
    local vtsls = require("vtsls")

    vim.keymap.set("n", "<leader>fc", function()
      vtsls.commands["organize_imports"]()
      vim.cmd("silent EslintFixAll")
      require("conform").format({ async = true, lsp_format = "fallback" })
    end)

    vim.keymap.set("n", "<leader>fe", ":EslintFixAll<CR>")
    vim.keymap.set("n", "<leader>fi", function()
      vtsls.commands["add_missing_imports"]()
    end)
  end,
}
