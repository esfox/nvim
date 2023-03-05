vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Key mappings
vim.keymap.set({ 'i', 'c' }, 'jk', '<Esc>')
vim.keymap.set({ 'i', 'c' }, 'JK', '<Esc>')
vim.keymap.set({ '', 'v' }, 'J', '10j')
vim.keymap.set({ '', 'v' }, 'K', '10k')
vim.keymap.set({ '', 'v' }, 'H', '^')
vim.keymap.set({ '', 'v' }, 'L', '$')
vim.keymap.set('n', 'U', '<c-r>')
vim.keymap.set('n', 'p', 'pgvy')
vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('v', 'ii', '<Esc>i')
vim.keymap.set('i', 'vv', '<Esc>lv')
vim.keymap.set({ '', 'i' }, '<c-a>', '<Esc>ggVG')

-- [[ Highlight on yank ]] See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

if vim.g.vscode then
  vim.cmd [[
    nnoremap gr <Cmd>call VSCodeCall('editor.action.rename')<CR>
    nnoremap gR <Cmd>call VSCodeCall('editor.action.goToReferences')<CR>
    nnoremap gD <Cmd>call VSCodeCall('editor.action.goToTypeDefinition')<CR>
  ]]

  require('lazy').setup({
    'nvim-lua/plenary.nvim',
    { 'kylechui/nvim-surround', opts = {} },
    { 'windwp/nvim-autopairs',  opts = {} },
    -- other nvim plugins
  })
  return
end
