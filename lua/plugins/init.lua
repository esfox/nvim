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

  "github/copilot.vim",

  "marcuscaisey/olddirs.nvim",

  "JoosepAlviste/nvim-ts-context-commentstring",

  "davidosomething/format-ts-errors.nvim",

  "tpope/vim-sleuth",

  "molecule-man/telescope-menufacture",

  {
    "windwp/nvim-ts-autotag",
    opts = {},
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
    "filipdutescu/renamer.nvim",
    branch = "master",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("renamer").setup({
        title = "",
      })
    end,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false })
    end,
  },

  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    config = function()
      require("tailwindcss-colors").setup()
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

  { "akinsho/git-conflict.nvim",          opts = {} },

  -- {
  --   'APZelos/blamer.nvim',
  --   config = function()
  --     vim.cmd [[ highlight Blamer guifg=#505050 gui=bold ]]
  --     vim.g.blamer_enabled = 1
  --   end,
  -- },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  { "brenoprata10/nvim-highlight-colors", opts = {} },
  { "kylechui/nvim-surround",             opts = {} },
  { "windwp/nvim-autopairs",              opts = {} },
  {
    "romgrk/barbar.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      animation = false,
      icons = {
        button = "",
      },
    },
  },

  {
    "Wansmer/treesj",
    opts = {
      max_join_length = 1000,
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
    "phaazon/hop.nvim",
    priority = 1,
    config = function()
      local hop = require("hop")
      hop.setup()
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
      { "j-hui/fidget.nvim", opts = {} },

      -- additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  { "lewis6991/gitsigns.nvim", opts = {} },

  -- { 'folke/which-key.nvim', opts = {} },

  {
    "folke/trouble.nvim",
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.coreclr = {
        type = "executable",
        command = "/home/ckftm/software/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            -- return vim.fn.DOTNET_DEBUG_DLL_PATH;
            return vim.fn.input({
              prompt = "Path to dll to debug: ",
            })
          end,
        },
      }
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },

  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = "/home/ckftm/.local/share/nvim/lazy/vscode-js-debug",
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })

      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
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
          html = { require("formatter.filetypes.html").prettierd },
          markdown = { require("formatter.filetypes.markdown").prettierd },
          yaml = { require("formatter.filetypes.yaml").prettierd },
          graphql = { require("formatter.filetypes.graphql").prettierd },
          vue = { require("formatter.filetypes.vue").prettierd },
          lua = { require("formatter.filetypes.lua").stylua },
        },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    priority = 900,
    config = function()
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#384651 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guifg=#404e41 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guifg=#4c413d gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guifg=#535031 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guifg=#594b36 gui=nocombine]])

      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
        space_char_blankline = " ",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
        },
      })
    end,
  },

  {
    "numtostr/comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        sticky = true,
      })
    end,
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

      -- vim.cmd [[highlight TelescopeNormal guibg=#2c2c2c]]
      -- vim.cmd [[highlight TelescopePreviewNormal guibg=#363636]]
      -- vim.cmd [[highlight TelescopeBorder guibg=#2c2c2c]]
      -- vim.cmd [[highlight TelescopePreviewBorder guibg=#363636]]
      -- vim.cmd [[highlight TelescopeTitle guibg=#a7df78 guifg=#202020]]

      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
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
