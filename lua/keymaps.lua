local keymaps = {}

function keymaps.general()
  vim.keymap.set({ 'i', 'c' }, 'jk', '<Esc>')
  vim.keymap.set({ 'i', 'c' }, 'JK', '<Esc>')
  vim.keymap.set({ 'n', 'v' }, 'J', '10j')
  vim.keymap.set({ 'n', 'v' }, 'K', '10k')
  vim.keymap.set({ '', 'v' }, 'H', '^')
  vim.keymap.set({ '', 'v' }, 'L', '$')
  vim.keymap.set('n', 'U', '<c-r>')
  vim.keymap.set('n', '<c-enter>', '<Enter>:cclose<CR>')
  vim.keymap.set('n', '<Enter>', 'o<Esc>')
  vim.keymap.set('i', '<c-bs>', '<c-w>')
  vim.keymap.set('n', 'p', 'pgvy')
  vim.keymap.set('v', 'p', '"_dP')

  vim.keymap.set('v', 'ii', '<Esc>i')
  vim.keymap.set('i', 'vv', '<Esc>lv')

  vim.keymap.set('n', '<c-v>', 'p')
  vim.keymap.set('i', '<c-v>', '<Esc>pa')
  vim.keymap.set({ '', 'i' }, '<c-a>', '<Esc>ggVG')
  vim.keymap.set('', '<c-s>', ':update<CR>')
  vim.keymap.set('i', '<c-s>', "<Esc>:update<CR>i")
  vim.keymap.set({ 'n', 'i' }, '<c-j>', '<tab>')
  vim.keymap.set({ 'n', 'i' }, '<c-k>', '<c-o>')

  vim.keymap.set('n', '<leader>wh', '<c-w>h')
  vim.keymap.set('n', '<leader>wj', '<c-w>j')
  vim.keymap.set('n', '<leader>wk', '<c-w>k')
  vim.keymap.set('n', '<leader>wl', '<c-w>l')
  vim.keymap.set('n', '<leader>wm', '<c-w>_')

  vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

  if vim.g.neovide then
    vim.keymap.set({ '', 'i' }, '<c-w>', ':bd<CR>')
  end
end

function keymaps.for_pluggins()
  -- Nvim Tree
  vim.keymap.set({ '', 'i' }, '<c-b>', ':NvimTreeToggle<CR>')

  -- Bufferline
  vim.keymap.set({ 'n', 'i' }, '<a-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-right>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-left>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-s-left>', '<Cmd>BufferLineMovePrev<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-s-right>', '<Cmd>BufferLineMoveNext<CR>', { silent = true })

  -- NoNeckPain
  vim.keymap.set({ 'n', 'i' }, '<leader>vc', ':NoNeckPain<CR>')

  -- Telescope
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  vim.keymap.set({ 'n', 'i', 'v' }, '<c-p>', function()
    require('telescope.builtin').oldfiles { cwd_only = true }
  end, { desc = 'Find [p]reviously opened files' })

  vim.keymap.set({ '', 'i', 'v' }, '<c-o>', require('telescope').extensions.menufacture.find_files,
    { desc = 'Search Files' })

  vim.keymap.set({ '', 'i', 'v' }, '<c-r>', function()
    require('telescope').extensions.olddirs.picker {
      previewer = false,
      selected_dir_callback = function(dir)
        vim.cmd 'bufdo bd'
        vim.cmd.cd(dir)
      end,
      layout_config = {
        width = 0.4,
        height = 0.3,
      },
      path_display = function(_, path)
        local last_directory_pos = (path:reverse()):find '%/'
        return (path:sub(1 - last_directory_pos))
      end,
    }
  end)

  vim.keymap.set(
    { 'n', 'i' },
    '<c-;>',
    require('telescope.builtin').commands,
    { desc = 'Search Commands' }
  )

  vim.keymap.set(
    'n',
    '<leader>sw',
    require('telescope.builtin').grep_string,
    { desc = '[S]earch current [W]ord' }
  )

  vim.keymap.set(
    'n',
    '<leader>sh',
    require('telescope.builtin').help_tags,
    { desc = '[S]earch [H]elp' }
  )

  vim.keymap.set(
    'n',
    '<leader>sg',
    require('telescope.builtin').live_grep,
    { desc = '[S]earch by [G]rep' }
  )

  vim.keymap.set(
    'n',
    '<leader>sd',
    require('telescope.builtin').diagnostics,
    { desc = '[S]earch [D]iagnostics' }
  )
end

function for_lsp()
end

return keymaps
