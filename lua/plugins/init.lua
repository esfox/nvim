local keymaps = require("keymaps")

return {
  -- {
  --   'rafamadriz/neon',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'neon'
  --   end
  -- },

  {
    -- dir = vim.env.HOME .. '/.config/nvim/colorschemes/neon-modified',
    dir = vim.env.HOME .. "/.config/nvim/colorschemes/vscode-modified",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup()
      -- vim.cmd.colorscheme 'sozhemtor'
    end,
  },
  -- {
  --   "sainnhe/sonokai",
  --   lazy = false,
  --   priority = 999,
  --   config = function()
  --     vim.g.sonokai_colors_override = {
  --       fg = { "#dedede", "250" },
  --       bg0 = { "#303030", "235" },
  --       bg1 = { "#404040", "236" },
  --       bg3 = { "#505050", "237" },
  --       bg4 = { "#545454", "237" },
  --     }
  --     -- vim.cmd.colorscheme 'sonokai'
  --   end,
  -- },

  "tpope/vim-fugitive",
  "marcuscaisey/olddirs.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "davidosomething/format-ts-errors.nvim",
  "tpope/vim-sleuth",
  "molecule-man/telescope-menufacture",
  "b0o/schemastore.nvim",
  "yioneko/nvim-vtsls",
  -- {
  --   "nmac427/guess-indent.nvim",
  --   opts = {
  --     auto_cmd = true,               -- Set to false to disable automatic execution
  --     override_editorconfig = false, -- Set to true to override settings set by .editorconfig
  --     filetype_exclude = {           -- A list of filetypes for which the auto command gets disabled
  --       "netrw",
  --       "tutor",
  --     },
  --     buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
  --       "help",
  --       "nofile",
  --       "terminal",
  --       "prompt",
  --     },
  --   },
  -- },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
      cmdline = {
        format = {
          cmdline = {
            view = "cmdline",
            icon = ":",
          },
          search_down = { title = "" },
          search_up = { title = "" },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "single",
          },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        border = "single",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
      -- "nvim-neo-tree/neo-tree.nvim",
    },
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
    end,
  },
  "AndrewRadev/tagalong.vim",
  {
    "roobert/search-replace.nvim",
    opts = {},
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        pre_save_cmds = { "Neotree close" },
      })
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup({
        override_lens = function() end,
      })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        handle = {
          highlight = "ScrollbarHandle",
        },
        handlers = {
          diagnostic = false,
        },
        marks = {
          GitAdd = {
            text = "│",
          },
          GitChange = {
            text = "│",
          },
        },
      })
    end,
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        auto_attach = true,
      },
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false })
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        delay = 300,
      })
    end,
  },
  { "akinsho/git-conflict.nvim", opts = {} },
  -- {
  --   'APZelos/blamer.nvim',
  --   config = function()
  --     vim.cmd [[ highlight Blamer guifg=#505050 gui=bold ]]
  --     vim.g.blamer_enabled = 1
  --   end,
  -- },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
  { "brenoprata10/nvim-highlight-colors", opts = {} },
  { "kylechui/nvim-surround", opts = {} },
  { "windwp/nvim-autopairs", opts = {} },
  -- {
  --   "romgrk/barbar.nvim",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   opts = {
  --     animation = false,
  --     icons = {
  --       button = "",
  --     },
  --     -- hide = { visible = true, current = true, inactive = true },
  --   },
  --   config = function()
  --     -- For some reason, this hides the barbar.nvim bufferline, which is what is desired
  --     vim.o.showtabline = 0
  --   end,
  -- },
  {
    "j-morano/buffer_manager.nvim",
    opts = {
      short_file_names = true,
    },
  },
  {
    "Wansmer/treesj",
    opts = {
      max_join_length = 1000,
      use_default_keymaps = false,
    },
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    config = function()
      vim.g.VM_theme = "codedark"
    end,
  },
  -- {
  --   'shortcuts/no-neck-pain.nvim',
  --   -- enabled = false,
  --   opts = {
  --     width = 120,
  --     autocmds = {
  --       enableOnVimEnter = false,
  --     },
  --     colors = {
  --       blend = -0.1,
  --     },
  --   },
  -- },

  {
    "smoka7/hop.nvim",
    priority = 1,
    opts = {},
  },
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.g.codeium_idle_delay = 50
    end,
  },
  {
    -- lsp configuration & plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- automatically install lsps to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- useful status updates for lsp
      -- note: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {}, tag = "legacy" },

      -- additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = keymaps.for_gitsigns,
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  -- { 'folke/which-key.nvim', opts = {} },

  {
    "folke/trouble.nvim",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          javascript = { require("formatter.filetypes.javascript").prettierd },
          typescript = { require("formatter.filetypes.javascript").prettierd },
          typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
          javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
          json = { require("formatter.filetypes.json").prettierd },
          css = { require("formatter.filetypes.css").prettierd },
          scss = { require("formatter.filetypes.css").prettierd },
          html = { require("formatter.filetypes.html").prettierd },
          angular = { require("formatter.filetypes.html").prettierd },
          markdown = { require("formatter.filetypes.markdown").prettierd },
          yaml = { require("formatter.filetypes.yaml").prettierd },
          graphql = { require("formatter.filetypes.graphql").prettierd },
          lua = { require("formatter.filetypes.lua").stylua },
          vue = { require("formatter.filetypes.vue").prettier },
          astro = { require("formatter.filetypes.javascript").prettierd },
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
    priority = 900,
    config = function()
      local hooks = require("ibl.hooks")

      local highlight = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
      }

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#384651", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#404e41", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#4c413d", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#535031", nocombine = true })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#594b36", nocombine = true })
      end)

      require("ibl").setup({
        scope = {
          enabled = true,
        },
        indent = {
          char = "│",
          highlight = highlight,
        },
      })
    end,
  },
  {
    "radyz/telescope-gitsigns",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
    config = function()
      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "olddirs")
      pcall(require("telescope").load_extension, "undo")
      pcall(require("telescope").load_extension, "git_signs")

      -- vim.cmd [[highlight TelescopeNormal guibg=#2c2c2c]]
      -- vim.cmd [[highlight TelescopePreviewNormal guibg=#363636]]
      -- vim.cmd [[highlight TelescopeBorder guibg=#2c2c2c]]
      -- vim.cmd [[highlight TelescopePreviewBorder guibg=#363636]]
      -- vim.cmd [[highlight TelescopeTitle guibg=#a7df78 guifg=#202020]]

      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            mirror = true,
          },
          -- sorting_strategy = 'ascending',
          borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
          mappings = {
            i = {
              ["<c-v>"] = { "<c-r>+", type = "command" },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/playground",
}
