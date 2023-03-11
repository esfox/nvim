return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- local configuration = vim.fn['sonokai#get_configuration']()
    -- local palette = vim.fn['sonokai#get_palette'](configuration.style, configuration.colors_override)
    -- local custom_sonokai = require 'lualine.themes.sonokai'
    -- custom_sonokai.normal.a.bg = palette.bg_green[1]
    -- custom_sonokai.insert.a.bg = palette.bg_blue[1]

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
        theme = 'vscode',
        -- theme = custom_sonokai,
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
}
