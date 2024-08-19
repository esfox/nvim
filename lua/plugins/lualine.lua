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
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_b = {
          {
            "filename",
            path = 4,
          },
        },
        lualine_c = {
          {
            function()
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_option(buf, "modified") then
                  return "Unsaved buffers" -- any message or icon
                end
              end
              return ""
            end,
          },
        },
        lualine_x = {
          "diagnostics",
          {
            "macro-recording",
            fmt = show_macro_recording,
          },
        },
        lualine_y = {
          function()
            local active_lsps = vim.lsp.get_active_clients()
            if next(active_lsps) == nil then
              return ""
            end

            local active_lsp_names = {}
            for _, value in ipairs(active_lsps) do
              table.insert(active_lsp_names, value.name)
            end
            return "[" .. table.concat(active_lsp_names, ", ") .. "]"
          end,
        },
        lualine_z = {},
      },
    })
  end,
}
