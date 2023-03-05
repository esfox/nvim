--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Vim options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.guifont = { "JetBrains Mono Light", "h14" }
vim.opt.cmdheight = 0
vim.opt.colorcolumn = '100'
vim.opt.list = true

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.o.background = 'dark'

vim.opt.scrolloff = 10

-- Key mappings
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
vim.keymap.set('i', '<c-s>', '<Esc>:update<CR>i')
vim.keymap.set({ 'n', 'i' }, '<c-j>', '<tab>')
vim.keymap.set({ 'n', 'i' }, '<c-k>', '<c-o>')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.7
  vim.g.neovide_cursor_vfx_mode = "ripple"

  vim.keymap.set({ '', 'i' }, '<c-w>', ':bd<CR>')
end

if vim.g.vscode then
  vim.cmd [[
    nnoremap gr <Cmd>call VSCodeCall('editor.action.rename')<CR>
    nnoremap gR <Cmd>call VSCodeCall('editor.action.goToReferences')<CR>
    nnoremap gD <Cmd>call VSCodeCall('editor.action.goToTypeDefinition')<CR>
  ]]

  require('lazy').setup({
    { 'kylechui/nvim-surround', opts = {} },
    { 'windwp/nvim-autopairs',  opts = {} },
    'nvim-lua/plenary.nvim',
    {
      'phaazon/hop.nvim',
      config = function()
        local hop = require('hop')
        hop.setup()
        vim.keymap.set('', 'm', function()
          hop.hint_words()
        end, { remap = true })
      end
    },
  })
  return
end

-- this blamer.nvim setting need to be setup before loading the plugin
vim.g.blamer_date_format = '%b %e (%a)'

require('lazy').setup('plugins')

vim.keymap.set({ '', 'i' }, '<c-b>', ':NvimTreeToggle<CR>')
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
vim.keymap.set('n', '<leader>wh', '<c-w>h')
vim.keymap.set('n', '<leader>wj', '<c-w>j')
vim.keymap.set('n', '<leader>wk', '<c-w>k')
vim.keymap.set('n', '<leader>wl', '<c-w>l')
vim.keymap.set('n', '<leader>wm', '<c-w>_')
vim.keymap.set({ 'n', 'i' }, '<leader>vc', ':NoNeckPain<CR>')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'opener')
pcall(require('telescope').load_extension, 'olddirs')

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set(
  { 'n', 'i', 'v' },
  '<c-p>',
  function()
    require('telescope.builtin').oldfiles({ cwd_only = true })
  end,
  { desc = 'Find [p]reviously opened files' }
)
vim.keymap.set({ '', 'i', 'v' }, '<c-o>', require('telescope').extensions.menufacture.find_files,
  { desc = 'Search Files' })
vim.keymap.set({ '', 'i', 'v' }, '<c-r>', function()
  require('telescope').extensions.olddirs.picker({
    previewer = false,
    selected_dir_callback = function(dir)
      vim.cmd('bufdo bd');
      vim.cmd.cd(dir);
    end,
    layout_config = {
      width = 0.4,
      height = 0.3,
    },
    path_display = function(_, path)
      local last_directory_pos = (path:reverse()):find('%/')
      return (path:sub(1 - last_directory_pos))
    end
  })
end)

vim.keymap.set({ 'n', 'i' }, '<c-;>', require('telescope.builtin').commands, { desc = 'Search Commands' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>fb', function()
  vim.cmd('Format')
end, { desc = '[F]ormat [B]uffer' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'c_sharp', 'lua', 'python', 'tsx', 'typescript', 'javascript', 'markdown', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    -- keymaps = {
    --   init_selection = '<c-space>',
    --   node_incremental = '<c-space>',
    --   scope_incremental = '<c-s>',
    --   node_decremental = '<M-space>',
    -- },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },

  context_commentstring = {
    enable = true,
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gR', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gD', vim.lsp.buf.type_definition, 'Type [D]efinition')

  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false }),
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr, async = async })
      vim.cmd('silent! EslintFixAll')
    end,
    desc = "[lsp] format on save",
  })
end

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, { focusable = false }
-- )

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
