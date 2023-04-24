return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "recording @" .. recording_register
      end
    end

    require("lualine").setup({
      options = {
        theme = "vscode",
        -- theme = custom_sonokai,
        icons_enabled = true,
        component_separators = "|",
        section_separators = { left = "", right = "|" },
      },
      sections = {
        lualine_b = {
          {
            "filename",
            path = 1,
          },
          {
            "macro-recording",
            fmt = show_macro_recording,
          },
        },
        lualine_c = {},
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
