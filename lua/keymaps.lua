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
  -- vim.keymap.set('n', 'p', 'pgvy')
  vim.keymap.set('v', 'p', '"_dP')

  vim.keymap.set('v', 'ii', '<Esc>i')
  vim.keymap.set('i', 'vv', '<Esc>lv')

  vim.keymap.set('n', '<c-v>', 'p')
  vim.keymap.set('i', '<c-v>', '<Esc>pa')
  vim.keymap.set({ '', 'i' }, '<c-a>', '<Esc>ggVG')
  vim.keymap.set('', '<c-s>', ':update<CR>')
  vim.keymap.set('i', '<c-s>', '<Esc>:update<CR>i')
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

  vim.keymap.set('n', '<leader>fb', function()
    vim.cmd('Format')
    vim.cmd('FormatWrite')
  end, { desc = '[F]ormat [B]uffer' })

  if vim.g.neovide then
    vim.keymap.set({ '', 'i' }, '<c-w>', ':bd<CR>')
  end
end

function keymaps.for_plugins()
  -- Nvim Tree
  vim.keymap.set({ '', 'i' }, '<c-b>', ':NvimTreeToggle<CR>')

  -- Bufferline
  vim.keymap.set({ 'n', 'i' }, '<a-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<a-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { silent = true })
  vim.keymap.set({ 'n', 'i' }, '<c-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { silent = true })
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

  -- Hop
  local hop = require 'hop'
  vim.keymap.set('', 'm', function()
    hop.hint_words()
  end, { remap = true })

  -- Comment
  local comment = require 'Comment.api'
  vim.keymap.set('n', 'gc', comment.call('toggle.linewise', 'g@'), { expr = true })
  vim.keymap.set({ 'n', 'i' }, '<c-/>', comment.toggle.linewise.current)
  vim.keymap.set({ 'n', 'i' }, '<c-?>', comment.toggle.blockwise.current)

  -- Renamer
  local renamer = require 'renamer'
  vim.keymap.set('n', 'gr', function()
    renamer.rename {}
    -- vim.cmd('stopinsert')
    vim.api.nvim_input 'jkvaw'
  end, { noremap = true, silent = true })

  -- Trouble
  vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>')

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

  vim.keymap.set({ 'n', 'i' }, '<c-;>', require('telescope.builtin').commands, { desc = 'Search Commands' })

  vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })

  vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })

  vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

  vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
end

function keymaps.for_lsp(buffer_number)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, description)
    if description then
      description = 'LSP: ' .. description
    end

    vim.keymap.set('n', keys, func, { buffer = buffer_number, desc = description })
  end

  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gH', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gR', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')

  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
end

function keymaps.for_cmp(cmp)
  return cmp.mapping.preset.insert {
    ['<C-f>'] = cmp.mapping.scroll_docs( -5),
    ['<C-d>'] = cmp.mapping.scroll_docs(5),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }
end

return keymaps
