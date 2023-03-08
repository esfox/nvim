local helpers = require('helpers')

return {
  'tpope/vim-fugitive',

  'github/copilot.vim',

  'marcuscaisey/olddirs.nvim',

  'JoosepAlviste/nvim-ts-context-commentstring',

  'tpope/vim-sleuth',

  'molecule-man/telescope-menufacture',

  {
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = 'nvim-lua/plenary.nvim',
    opts = {},
  },

  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure {
        delay = 300,
      }
    end,
  },

  { 'akinsho/git-conflict.nvim',          opts = {} },

  -- {
  --   'APZelos/blamer.nvim',
  --   config = function()
  --     vim.cmd [[ highlight Blamer guifg=#505050 gui=bold ]]
  --     vim.g.blamer_enabled = 1
  --   end,
  -- },

  {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    opts = {},
  },

  { 'brenoprata10/nvim-highlight-colors', opts = {} },
  { 'romgrk/barbar.nvim',                 dependencies = 'nvim-tree/nvim-web-devicons' },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        sync_root_with_cwd = true,
        hijack_unnamed_buffer_when_opening = true,
        open_on_setup = not helpers.is_pc(),
        update_focused_file = {
          enable = true,
        },
        view = {
          width = 40,
          side = helpers.is_pc() and 'right' or 'left',
          number = true,
          relativenumber = true,
        },
        git = {
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = helpers.is_pc(),
          },
        },
        renderer = {
          root_folder_label = function(path)
            return vim.fn.fnamemodify(path, ':t:r')
          end,
        },
      })
    end,
  },

  { 'kylechui/nvim-surround', opts = {} },

  { 'windwp/nvim-autopairs',  opts = {} },

  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  {
    'shortcuts/no-neck-pain.nvim',
    -- enabled = false,
    opts = {
      width = 120,
      autocmds = {
        enableOnVimEnter = false,
      },
      colors = {
        blend = -0.1,
      },
    },
  },

  {
    'phaazon/hop.nvim',
    priority = 1,
    config = function()
      local hop = require 'hop'
      hop.setup()
    end,
  },

  {
    -- lsp configuration & plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- automatically install lsps to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- useful status updates for lsp
      -- note: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'l3mon4d3/luasnip', 'saadparwaiz1/cmp_luasnip' },
  },

  { 'lewis6991/gitsigns.nvim', opts = {} },

  -- { 'folke/which-key.nvim', opts = {} },

  {
    'folke/trouble.nvim',
    opts = {},
  },

  {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup {
        filetype = {
          javascript = { require('formatter.filetypes.javascript').prettierd },
          typescript = { require('formatter.filetypes.javascript').prettierd },
          typescriptreact = { require('formatter.filetypes.typescriptreact').prettierd },
          javascriptreact = { require('formatter.filetypes.javascriptreact').prettierd },
          json = { require('formatter.filetypes.json').prettierd },
          css = { require('formatter.filetypes.css').prettierd },
          html = { require('formatter.filetypes.html').prettierd },
          markdown = { require('formatter.filetypes.markdown').prettierd },
          yaml = { require('formatter.filetypes.yaml').prettierd },
          graphql = { require('formatter.filetypes.graphql').prettierd },
          vue = { require('formatter.filetypes.vue').prettierd },
          lua = { require('formatter.filetypes.lua').stylua },
        },
      }
    end,
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_colors_override = {
        fg = { '#dedede', '250' },
        bg0 = { '#303030', '235' },
        bg1 = { '#404040', '236' },
        bg3 = { '#505050', '237' },
        bg4 = { '#545454', '237' },
      }
      vim.cmd.colorscheme 'sonokai'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local configuration = vim.fn['sonokai#get_configuration']()
      local palette = vim.fn['sonokai#get_palette'](configuration.style, configuration.colors_override)
      local custom_sonokai = require 'lualine.themes.sonokai'
      custom_sonokai.normal.a.bg = palette.bg_green[1]
      custom_sonokai.insert.a.bg = palette.bg_blue[1]

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == '' then
          return ''
        else
          return 'recording @' .. recording_register
        end
      end

      require('lualine').setup {
        options = {
          theme = custom_sonokai,
          icons_enabled = true,
          component_separators = '|',
          section_separators = { left = '', right = '|' },
        },
        sections = {
          lualine_b = {
            {
              'filename',
              path = 1,
            },
            {
              'macro-recording',
              fmt = show_macro_recording,
            },
          },
          lualine_c = {},
          lualine_x = { 'filetype' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#384651 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=#404e41 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=#4c413d gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=#535031 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#594b36 gui=nocombine]]

      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = true,
        space_char_blankline = ' ',
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
        },
      }
    end,
  },

  {
    'numtostr/comment.nvim',
    config = function()
      require('Comment').setup {
        sticky = true,
      }
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim', "debugloop/telescope-undo.nvim" },
    config = function()
      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'olddirs')
      pcall(require('telescope').load_extension, 'undo')

      -- require('telescope').setup {
      --   defaults = {
      --     mappings = {
      --       i = {
      --       },
      --     },
      --   },
      -- }
    end,
    -- opts = {
    --   defaults = {
    --     borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    --   }
    -- }
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },

  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/playground',
}
