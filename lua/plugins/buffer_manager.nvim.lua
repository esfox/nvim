return {
  "j-morano/buffer_manager.nvim",
  config = function()
    local plenary = require("plenary")

    require("buffer_manager").setup({
      width = 70,
      height = 10,
      format_function = function(filepath)
        local filename = vim.fs.basename(filepath)
        local relative_path = plenary.path:new(filepath):make_relative()
        local path_match = relative_path:match("(.*[/\\])")

        if path_match == nil then
          return relative_path
        end

        relative_path = path_match:sub(1, -2)
        return filename .. " ... " .. relative_path
      end,
    })

    -- buffer_manager
    local buffer_manager = require("buffer_manager.ui")
    vim.keymap.set({ "", "i" }, "<c-,>", function()
      buffer_manager.toggle_quick_menu()
    end, { silent = true })

    -- Support for Kitty, which binds <c-,> as F12
    vim.keymap.set({ "", "i" }, "<f12>", function()
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

    -- Support for Kitty, which binds <c-;> as F4
    vim.keymap.set({ "", "i" }, "<f4>", function()
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
