local keymaps = require("keymaps")

return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      on_attach = function()
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "<leader>gh", gs.preview_hunk)
      end,
    })
    -- require("scrollbar.handlers.gitsigns").setup()

    vim.keymap.set("n", "<leader>gs", ":Telescope git_signs<CR>")
  end,
}
