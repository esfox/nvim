local helpers = require('helpers')

return {
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
}
