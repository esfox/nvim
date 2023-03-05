if vim.g.vscode then
  vim.cmd [[
    nnoremap gr <Cmd>call VSCodeCall('editor.action.rename')<CR>
    nnoremap gR <Cmd>call VSCodeCall('editor.action.goToReferences')<CR>
    nnoremap gD <Cmd>call VSCodeCall('editor.action.goToTypeDefinition')<CR>
  ]]

  require('lazy').setup {
    { 'kylechui/nvim-surround', opts = {} },
    { 'windwp/nvim-autopairs',  opts = {} },
    'nvim-lua/plenary.nvim',
    {
      'phaazon/hop.nvim',
      config = function()
        local hop = require 'hop'
        hop.setup()
        vim.keymap.set('', 'm', function()
          hop.hint_words()
        end, { remap = true })
      end,
    },
  }
  return
end
