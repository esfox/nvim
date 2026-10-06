return {
  "axkirillov/unified.nvim",
  config = function()
    require('unified').setup({
      file_tree = {
        filename_first = true, -- Show filename before directory path (Snacks backend only)
      },
    })
    vim.keymap.set('n', ']h', function() require('unified.navigation').next_hunk() end)
    vim.keymap.set('n', '[h', function() require('unified.navigation').previous_hunk() end)
  end
}
