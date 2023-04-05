local helpers = require('helpers')

return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    local options = {
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
      },
      view = {
        width = 60,
        number = true,
        relativenumber = true,
      },
      git = {
        ignore = false,
      },
      renderer = {
        root_folder_label = function(path)
          return vim.fn.fnamemodify(path, ':t:r')
        end,
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
          quit_on_open = true
        }
      }
    end

    require('nvim-tree').setup(options)
  end,
}
