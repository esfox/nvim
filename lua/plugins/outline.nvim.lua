return {
  "hedyhli/outline.nvim",
  config = function()
    local outline = require("outline")
    outline.setup({
      outline_window = {
        width = 40,
        auto_close = true,
        auto_jump = true,
        center_on_jump = true,
        show_relative_numbers = true,
      },
      symbol_folding = {
        autofold_depth = false,
      },
      keymaps = {
        toggle_preview = "<noop>",
      },
    })

    -- Example mapping to toggle outline
    vim.keymap.set("n", "<c-t>", function()
      outline.toggle()
    end, { desc = "Toggle Outline" })
  end,
}
