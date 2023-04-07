local helpers = require 'helpers'
local hop = require 'hop'

return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    local nvim_tree_api = require 'nvim-tree.api'

    local on_attach = function(buffer_number)
      nvim_tree_api.config.mappings.default_on_attach(buffer_number)

      vim.keymap.set('n', 'H', '0', { buffer = buffer_number, noremap = true })
      vim.keymap.set('n', 'J', '10j', { desc = 'Go down 10 lines', buffer = buffer_number, noremap = true })
      vim.keymap.set('n', 'K', '10k', { desc = 'Go up 10 lines', buffer = buffer_number, noremap = true })

      vim.keymap.set('n', 'm', hop.hint_lines,
      { desc = 'Hop', buffer = buffer_number, noremap = true, silent = true, nowait = true })

      vim.keymap.set('n', 'h', function()
        local node = nvim_tree_api.tree.get_node_under_cursor()
        if node == nil then
          return
        end

        if node.type == 'directory' and node.open then
          nvim_tree_api.node.open.edit()
        else
          nvim_tree_api.node.navigate.parent()
        end
      end, {
        desc = 'Close if the selected node is an opened folder and go to parent if it is closed',
        buffer = buffer_number,
        noremap = true,
        silent = true,
      })

      vim.keymap.set('n', 'l', nvim_tree_api.node.open.edit,
      { desc = 'Open', buffer = buffer_number, noremap = true, silent = true })

      vim.keymap.set('n', '<space>', nvim_tree_api.node.open.edit,
      { desc = 'Open', buffer = buffer_number, noremap = true, silent = true, nowait = true })
    end

    local options = {
      on_attach = on_attach,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
      },
      view = {
        width = helpers.is_laptop() and 45 or 60,
        number = true,
        relativenumber = true,
      },
      git = {
        ignore = false,
      },
      renderer = {
        icons = {
          glyphs = {
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '➜',
              untracked = '',
              deleted = '',
              ignored = '',
            },
          },
        },
        root_folder_label = function(path)
          return vim.fn.fnamemodify(path, ':t:r')
        end,
        highlight_git = true,
        highlight_modified = 'all',
      },
    }

    if helpers.is_laptop() then
      options.view.side = 'left'
      options.hijack_unnamed_buffer_when_opening = true

      vim.api.nvim_create_autocmd({ 'VimEnter' }, {
        callback = function()
          require('nvim-tree.api').tree.open()
        end,
      })
    else
      options.view.side = 'right'
      options.actions = {
        open_file = {
          quit_on_open = true,
        },
      }
    end

    require('nvim-tree').setup(options)
  end,
}
