local keymaps = {}

function keymaps.general()
  -- ==========================================
  -- 1. INSERT / COMMAND MODE ('i', 'c')
  -- ==========================================
  -- Exit insert mode to Normal mode
  vim.keymap.set({ "i", "c" }, "jk", "<Esc>", { desc = "Exit to Normal Mode" })
  vim.keymap.set({ "i", "c" }, "JK", "<Esc>", { desc = "Exit to Normal Mode" })

  -- ==========================================
  -- 2. VISUAL MODE ('v')
  -- ==========================================
  -- Toggle between visual and visual-block mode
  vim.keymap.set("v", "[", function()
    local mode = vim.fn.mode()
    return mode == "\22" and "v" or "\22"
  end, { expr = true, desc = "Toggle visual-block mode" })

  -- Jumps & Motions in visual mode
  vim.keymap.set("v", "J", "30j")
  vim.keymap.set("v", "K", "30k")
  vim.keymap.set("v", "H", "^")
  vim.keymap.set("v", "L", "$")

  -- Quick back to typing mode from visual
  vim.keymap.set("v", "ii", "<Esc>i")

  -- Visual paste without clobbering register
  vim.keymap.set("v", "p", '"_dP')

  -- ==========================================
  -- 3. NORMAL MODE ('n')
  -- ==========================================
  -- Motions & Scroll
  vim.keymap.set("n", "J", "30j")
  vim.keymap.set("n", "K", "30k")
  vim.keymap.set("n", "H", "^")
  vim.keymap.set("n", "L", "$")
  vim.keymap.set("n", "<c-c>", "i")

  -- Enter visual block mode
  vim.keymap.set("n", "<leader>v", "<c-v>", { desc = "Enter visual block mode" })

  -- Redo
  vim.keymap.set("n", "U", "<c-r>")

  -- Paste from clipboard
  vim.keymap.set("n", "<c-v>", "p")

  -- Word wrap movement
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Disable default space behavior
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- ==========================================
  -- 4. PARAMETER TEXT OBJECTS ('ap', 'ip')
  -- ==========================================
  -- 'ap' selects around {{param}} (including {{ and }})
  -- 'ip' selects inside {{param}} (excluding {{ and }})
  local function select_param(inner)
    local cur_pos = vim.api.nvim_win_get_cursor(0)
    local row = cur_pos[1]
    local col = cur_pos[2] + 1 -- 1-indexed column
    local line = vim.api.nvim_get_current_line()

    -- Search for all {{...}} in current line
    local best_s, best_e = nil, nil
    local init = 1
    while true do
      local s, e = line:find("{{.-}}", init)
      if not s then
        break
      end
      if col >= s and col <= e then
        best_s, best_e = s, e
        break
      elseif col < s and not best_s then
        -- Cursor is before {{...}}, pick next closest on this line
        best_s, best_e = s, e
        break
      end
      init = e + 1
    end

    if not best_s then
      return
    end

    local start_col = best_s
    local end_col = best_e

    if inner then
      start_col = best_s + 2
      end_col = best_e - 2
      if start_col > end_col then
        return
      end
    end

    -- Set visual selection
    vim.api.nvim_win_set_cursor(0, { row, start_col - 1 })
    vim.cmd("normal! v")
    vim.api.nvim_win_set_cursor(0, { row, end_col - 1 })
  end

  vim.keymap.set({ "x", "o" }, "ap", function() select_param(false) end, { desc = "Around parameter {{...}}" })
  vim.keymap.set({ "x", "o" }, "ip", function() select_param(true) end, { desc = "Inside parameter {{...}}" })
end

function keymaps.layout()
  local layout = require("layout")

  -- ==========================================
  -- Floating Command Editor Trigger
  -- ==========================================
  -- <C-e> (and <M-e> / <A-e> / <C-Space> / <Nul>) opens the floating command editor
  vim.keymap.set({ "n", "t" }, "<C-e>", layout.open_command_modal, { desc = "Open floating command editor" })
  vim.keymap.set({ "n", "t" }, "<M-e>", layout.open_command_modal, { desc = "Open floating command editor" })
  vim.keymap.set({ "n", "t" }, "<A-e>", layout.open_command_modal, { desc = "Open floating command editor" })
  vim.keymap.set({ "n", "t" }, "<C-Space>", layout.open_command_modal, { desc = "Open floating command editor" })
  vim.keymap.set({ "n", "t" }, "<Nul>", layout.open_command_modal, { desc = "Open floating command editor" })

  -- ==========================================
  -- Terminal Mode Navigation
  -- ==========================================
  -- <C-k> toggles between Terminal mode ('t') and Normal mode ('n')
  vim.keymap.set("t", "<C-k>", layout.toggle_terminal_normal, { desc = "Terminal to Normal mode" })

  -- ==========================================
  -- Terminal Normal Mode Keymaps
  -- ==========================================
  if layout.term_buf and vim.api.nvim_buf_is_valid(layout.term_buf) then
    -- Typing keys enter terminal insert mode directly
    vim.keymap.set("n", "i", function() vim.cmd("startinsert") end, { buffer = layout.term_buf, desc = "Enter terminal mode" })
    vim.keymap.set("n", "a", function() vim.cmd("startinsert") end, { buffer = layout.term_buf, desc = "Enter terminal mode" })
    vim.keymap.set("n", "A", function() vim.cmd("startinsert") end, { buffer = layout.term_buf, desc = "Enter terminal mode" })
    vim.keymap.set("n", "I", function() vim.cmd("startinsert") end, { buffer = layout.term_buf, desc = "Enter terminal mode" })
    vim.keymap.set("n", "o", function() vim.cmd("startinsert") end, { buffer = layout.term_buf, desc = "Enter terminal mode" })
    vim.keymap.set("n", "O", function() vim.cmd("startinsert") end, { buffer = layout.term_buf, desc = "Enter terminal mode" })

    -- <C-k> and 'q' toggle back to Terminal mode
    vim.keymap.set({ "n", "v", "x" }, "<C-k>", layout.toggle_terminal_normal, { buffer = layout.term_buf, desc = "Normal to Terminal mode" })
    vim.keymap.set({ "n", "v", "x" }, "q", layout.toggle_terminal_normal, { buffer = layout.term_buf, desc = "Normal to Terminal mode" })

    -- <C-c> sends interrupt to terminal
    vim.keymap.set("n", "<C-c>", layout.handle_ctrl_c, { buffer = layout.term_buf, desc = "Kill terminal command (Ctrl-C)" })

    -- <CR> / <Enter> submits command from normal mode
    vim.keymap.set("n", "<CR>", layout.handle_enter, { buffer = layout.term_buf, desc = "Submit command to terminal" })
    vim.keymap.set("n", "<Enter>", layout.handle_enter, { buffer = layout.term_buf, desc = "Submit command to terminal" })

    -- <C-d> triggers quit confirmation
    vim.keymap.set({ "t", "n" }, "<C-d>", layout.handle_ctrl_d, { buffer = layout.term_buf, desc = "Ctrl-D exit confirmation" })

    -- <C-p> triggers saved commands picker
    vim.keymap.set({ "t", "n" }, "<C-p>", function()
      require("saved_commands.picker").open_picker()
    end, { buffer = layout.term_buf, desc = "Saved commands picker" })
  end
end

return keymaps
