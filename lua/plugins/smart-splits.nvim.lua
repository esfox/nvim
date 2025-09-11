return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  dependencies = {
    "pogyomo/submode.nvim",
  },
  config = function()
    -- Resize
    local submode = require("submode")
    submode.create("WinResize", {
      mode = "n",
      enter = "<leader>W",
      leave = { "<Esc>", "q", "<C-c>" },
      hook = {
        on_enter = function()
          vim.notify("Use { h, j, k, l } to resize the window")
        end,
        on_leave = function()
          vim.notify("")
        end,
      },
      default = function(register)
        local smart_splits = require("smart-splits")
        register("h", function()
          smart_splits.resize_left()
        end, { desc = "Resize left" })
        register("j", function()
          smart_splits.resize_down()
        end, { desc = "Resize down" })
        register("k", function()
          smart_splits.resize_up()
        end, { desc = "Resize up" })
        register("l", function()
          smart_splits.resize_right()
        end, { desc = "Resize right" })
        register("H", function()
          smart_splits.swap_buf_left({ move_cursor = true })
        end)
        register("J", function()
          smart_splits.swap_buf_up({ move_cursor = true })
        end)
        register("K", function()
          smart_splits.swap_buf_down({ move_cursor = true })
        end)
        register("L", function()
          smart_splits.swap_buf_right({ move_cursor = true })
        end)
      end,
    })
  end,
}
