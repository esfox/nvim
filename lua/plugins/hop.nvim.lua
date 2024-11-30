return {
  "smoka7/hop.nvim",
  priority = 1,
  config = function()
    -- Hop
    local hop = require("hop")
    hop.setup()

    vim.keymap.set("", "m", function()
      hop.hint_words({})
    end, { remap = true })

    vim.keymap.set("", "M", function()
      hop.hint_char1({})
    end, { remap = true })
  end,
}
