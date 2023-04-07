if vim.g.vscode then
  -- Install package manager
  --    https://github.com/folke/lazy.nvim
  --    `:help lazy.nvim.txt` for more info
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
  vim.cmd([[
    nnoremap gr <Cmd>call VSCodeCall('editor.action.rename')<CR>
    nnoremap gR <Cmd>call VSCodeCall('editor.action.goToReferences')<CR>
    nnoremap gD <Cmd>call VSCodeCall('editor.action.goToTypeDefinition')<CR>
  ]])

  require("lazy").setup({
    { "kylechui/nvim-surround", opts = {} },
    { "windwp/nvim-autopairs",  opts = {} },
    "nvim-lua/plenary.nvim",
    {
      "phaazon/hop.nvim",
      config = function()
        local hop = require("hop")
        hop.setup()
        vim.keymap.set("", "m", function()
          hop.hint_words()
        end, { remap = true })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      -- config = function()
      --   require('nvim-treesitter.configs').setup {
      --     -- Add languages to be installed here that you want installed for treesitter
      --     ensure_installed = { 'c', 'cpp', 'c_sharp', 'lua', 'python', 'tsx', 'typescript', 'javascript', 'markdown', 'help',
      --       'vim' },
      --
      --     -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      --     auto_install = false,
      --
      --     highlight = { enable = true },
      --     incremental_selection = {
      --       enable = true,
      --       -- keymaps = {
      --       --   init_selection = '<c-space>',
      --       --   node_incremental = '<c-space>',
      --       --   scope_incremental = '<c-s>',
      --       --   node_decremental = '<M-space>',
      --       -- },
      --     },
      --     textobjects = {
      --       select = {
      --         enable = true,
      --         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      --         keymaps = {
      --           -- You can use the capture groups defined in textobjects.scm
      --           ['ab'] = '@block.outer',
      --           ['ib'] = '@block.inner',
      --           ['ap'] = '@parameter.outer',
      --           ['ip'] = '@parameter.inner',
      --           ['af'] = '@function.outer',
      --           ['if'] = '@function.inner',
      --           ['ar'] = '@assignment.rhs',
      --           ['al'] = '@assignment.lhs',
      --           ['ac'] = '@call.outer',
      --           ['ic'] = '@call.inner',
      --         },
      --       },
      --       move = {
      --         enable = true,
      --         set_jumps = true, -- whether to set jumps in the jumplist
      --         goto_next_start = {
      --           [']m'] = '@function.outer',
      --           [']]'] = '@class.outer',
      --         },
      --         goto_next_end = {
      --           [']M'] = '@function.outer',
      --           [']['] = '@class.outer',
      --         },
      --         goto_previous_start = {
      --           ['[m'] = '@function.outer',
      --           ['[['] = '@class.outer',
      --         },
      --         goto_previous_end = {
      --           ['[M'] = '@function.outer',
      --           ['[]'] = '@class.outer',
      --         },
      --       },
      --       swap = {
      --         enable = true,
      --         swap_next = {
      --           ['<leader>a'] = '@parameter.inner',
      --         },
      --         swap_previous = {
      --           ['<leader>A'] = '@parameter.inner',
      --         },
      --       },
      --     },
      --
      --     context_commentstring = {
      --       enable = true,
      --     },
      --   }
      -- end
    },
  })
  return
end
