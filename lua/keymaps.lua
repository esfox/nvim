local helpers = require("helpers")

local keymaps = {}

function keymaps.general()
  vim.keymap.set({ "i", "c" }, "jk", "<Esc>")
  vim.keymap.set({ "i", "c" }, "JK", "<Esc>")
  vim.keymap.set({ "n", "v" }, "J", "30j")
  vim.keymap.set({ "n", "v" }, "K", "30k")
  vim.keymap.set({ "", "v" }, "H", "^")
  vim.keymap.set({ "", "v" }, "L", "$")
  vim.keymap.set("n", "U", "<c-r>")
  vim.keymap.set("n", "<leader><cr>", "<CR>")
  vim.keymap.set("n", "<c-cr>", "<Enter>:cclose<CR>")
  vim.keymap.set("n", "<Enter>", "o<Esc>")
  vim.keymap.set("i", "<c-bs>", "<c-w>")
  -- vim.keymap.set('n', 'p', 'pgvy')
  vim.keymap.set("v", "p", '"_dP')

  vim.keymap.set("v", "ii", "<Esc>i")
  vim.keymap.set("i", "vv", "<Esc>lv")
  vim.keymap.set("n", "<leader>v", "<c-v>")

  vim.keymap.set("n", "<c-v>", "p")
  vim.keymap.set("i", "<c-v>", "<Esc>pa")
  vim.keymap.set("c", "<c-v>", "<c-r>+")
  vim.keymap.set({ "", "i" }, "<c-a>", "<Esc>ggVG")
  vim.keymap.set("", "<c-s>", ":update<CR>")
  vim.keymap.set("i", "<c-s>", "<Esc>:update<CR>a")
  vim.keymap.set("", "<c-m-s>", ":NoAutocmdSave<CR>")
  vim.keymap.set("i", "<c-m-s>", "<Esc>:NoAutocmdSave<CR>a")
  vim.keymap.set({ "n", "i" }, "<c-left>", "<c-o>")
  vim.keymap.set({ "n", "i" }, "<c-right>", "<tab>")

  vim.keymap.set("n", "<c-h>", "<c-6>")
  vim.keymap.set("n", "<c-w>", ":bd<CR>")
  vim.keymap.set("n", "<leader>W", ":bufdo bd<CR>")

  -- window management
  vim.keymap.set("n", "<leader>wh", "<c-w>h")
  vim.keymap.set("n", "<leader>wj", "<c-w>j")
  vim.keymap.set("n", "<leader>wk", "<c-w>k")
  vim.keymap.set("n", "<leader>wl", "<c-w>l")

  vim.keymap.set("n", "<leader>wm", "<c-w>_")
  vim.keymap.set("n", "<leader>wH", "<c-w>H")
  vim.keymap.set("n", "<leader>wJ", "<c-w>J")
  vim.keymap.set("n", "<leader>wK", "<c-w>K")
  vim.keymap.set("n", "<leader>wL", "<c-w>L")
  vim.keymap.set("n", "<leader>wV", "<c-w><c-v>")
  vim.keymap.set("n", "<leader>wS", "<c-w><c-s>")
  vim.keymap.set("n", "<leader>q", ":q!<cr>")
  vim.keymap.set("n", "<leader>qa", ":qa<cr>")
  vim.keymap.set("n", "<leader>qA", ":qa!<cr>")
  vim.keymap.set("n", "<leader>qb", ":bd!<cr>")
  vim.keymap.set("n", "<leader>fp", function()
    local filepath = vim.fn.expand("%")
    print("Filepath: " .. filepath)
    vim.fn.getchar()
  end)

  vim.keymap.set("n", "<leader>fy", function()
    local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
    helpers.copy_to_sys_clipboard(relative_path)
  end)

  vim.keymap.set("n", "<leader>fY", function()
    local filename = vim.fn.expand("%:t")
    helpers.copy_to_sys_clipboard(filename)
  end)

  -- Disable default space behavior
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Diagnostic keymaps
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

  -- Comments
  vim.keymap.set("n", "<c-/>", function()
    vim.api.nvim_input("<Esc>gcc")
  end)
  vim.keymap.set("i", "<c-/>", function()
    vim.api.nvim_input("<Esc>gcci")
  end)
  vim.keymap.set("v", "<c-/>", function()
    vim.api.nvim_input("gcc")
  end)

  -- Support for Kitty, which binds <c-/> as F11
  vim.keymap.set("n", "<f11>", function()
    vim.api.nvim_input("<Esc>gcc")
  end)
  vim.keymap.set("i", "<f11>", function()
    vim.api.nvim_input("<Esc>gcci")
  end)
  vim.keymap.set("v", "<f11>", function()
    vim.api.nvim_input("gcc")
  end)
end

function keymaps.on_lsp_attach(buffer_number)
  -- Keymaps
  vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>")

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buffer_number })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer_number })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer_number })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = buffer_number })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer_number })
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = buffer_number })
  vim.keymap.set("n", "gH", vim.lsp.buf.signature_help, { buffer = buffer_number })
  vim.keymap.set("n", "ge", vim.diagnostic.open_float, { buffer = buffer_number })
  vim.keymap.set("n", "gr", function()
    vim.lsp.buf.rename()
    vim.wait(50)
    vim.api.nvim_input("jk")
  end, { buffer = buffer_number })

  -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = buffer_number })
  -- vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = buffer_number })
end

return keymaps
