local helpers = require("helpers")

local options = {}

function options.general()
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.clipboard = "unnamedplus"
  vim.opt.guifont = { "JetBrains Mono NL Light", "h14" }
  vim.opt.cmdheight = 0
  vim.opt.colorcolumn = "100"
  vim.opt.list = true

  vim.o.shiftwidth = 2
  vim.o.tabstop = 2
  vim.o.expandtab = true

  -- Set highlight on search
  vim.o.hlsearch = false

  -- Enable mouse mode
  vim.o.mouse = "a"

  -- Enable break indent
  vim.o.breakindent = true

  -- Save undo history
  vim.o.undofile = true

  -- Case insensitive searching UNLESS /C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = "yes"

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeout = true
  vim.o.timeoutlen = 300

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = "menuone,noselect"

  -- NOTE: You should make sure your terminal supports this
  vim.o.termguicolors = true
  vim.o.background = "dark"

  vim.o.scrolloff = 5

  if vim.g.neovide then
    vim.g.neovide_scale_factor = helpers.is_laptop() and 0.75 or 0.7
    vim.g.neovide_cursor_vfx_mode = "ripple"
  end
end

function options.on_lsp_attach()
  vim.o.formatoptions = vim.o.formatoptions:gsub("cro", "")
end

return options
