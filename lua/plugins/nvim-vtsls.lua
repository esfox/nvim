return {
  "yioneko/nvim-vtsls",
  config = function()
    local vtsls = require("vtsls")

    vim.keymap.set("n", "<leader>fc", function()
      vtsls.commands["organize_imports"]()
      vim.cmd("silent EslintFixAll")
      -- vim.cmd("Format")
    end)

    -- vim.keymap.set("n", "<leader>ff", ":Format<CR>")
    vim.keymap.set("n", "<leader>fe", ":EslintFixAll<CR>")
    vim.keymap.set("n", "<leader>fi", function()
      vtsls.commands["add_missing_imports"]()
    end)
  end,
}
