return {
  "j-morano/buffer_manager.nvim",
  config = function()
    require("buffer_manager").setup({
      short_file_names = true,
    })

    -- buffer_manager
    local buffer_manager = require("buffer_manager.ui")
    vim.keymap.set({ "", "i" }, "<c-,>", function()
      buffer_manager.toggle_quick_menu()
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<c-b>", function()
      buffer_manager.toggle_quick_menu()
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<c-j>", function()
      buffer_manager.nav_file(1)
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<c-k>", function()
      buffer_manager.nav_file(2)
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<c-l>", function()
      buffer_manager.nav_file(3)
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<c-;>", function()
      buffer_manager.nav_file(4)
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<a-left>", function()
      buffer_manager.nav_prev()
    end, { silent = true })
    vim.keymap.set({ "", "i" }, "<a-right>", function()
      buffer_manager.nav_next()
    end, { silent = true })
  end,
}
