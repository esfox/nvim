local options = {}

function options.general()
  -- Line Numbers (Disabled for now, revisit for input system)
  vim.opt.number = false
  vim.opt.relativenumber = false

  -- Clean Screen (Kill Editor Gutter / Lines)
  vim.wo.signcolumn = "no"
  vim.opt.colorcolumn = ""
  vim.opt.list = false
  vim.opt.cmdheight = 0
  vim.opt.showmode = false
  vim.opt.laststatus = 0 -- Hide bottom statusline
  vim.opt.ruler = false
  vim.opt.statusline = " " -- Erase ugly buffer names from split dividers
  vim.opt.fillchars = { stl = "─", stlnc = "─" } -- Clean horizontal line divider

  -- Mode Indicator via Cursor Shape & Highlight
  -- Normal/Visual = Colored Block, Terminal Mode = Blinking Beam
  vim.opt.guicursor = "n-v-c:block-CursorNormal,t:ver25-blinkon100-CursorTerm,i-ci-ve:ver25,r-cr:hor20,o:hor50"

  -- Highlight groups for cursor colors
  vim.api.nvim_set_hl(0, "CursorNormal", { fg = "#1a1b26", bg = "#ff9e64" }) -- Orange block in Normal
  vim.api.nvim_set_hl(0, "CursorTerm", { fg = "#1a1b26", bg = "#7aa2f7" })   -- Blue beam in Terminal

  -- Terminal Scroll & History
  vim.o.scrollback = 20000
  vim.o.scrolloff = 0 -- Keep prompt pinned to bottom cleanly

  -- Clipboard & History
  vim.opt.clipboard = "unnamedplus"
  vim.o.undofile = true
  vim.o.mouse = "a"

  -- Scrollback Search Power
  vim.o.hlsearch = false
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Shell & Window Title
  vim.o.shell = vim.env.SHELL or (vim.fn.executable("bash") == 1 and "bash" or "sh")
  vim.opt.title = true
  vim.opt.completeopt = { "menu", "menuone", "noinsert" }

  -- Nested editor routing (route vim/editor to nvim for flatten.nvim)
  local bin_path = vim.fn.stdpath("config") .. "/bin"
  if vim.fn.isdirectory(bin_path) == 1 and not (vim.env.PATH or ""):find(bin_path, 1, true) then
    vim.env.PATH = bin_path .. ":" .. (vim.env.PATH or "")
  end
  vim.env.EDITOR = "nvim"
  vim.env.VISUAL = "nvim"

  -- Visuals & Timing
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.opt.guifont = { "JetBrains Mono NL Light", ":h13" }
  vim.o.updatetime = 250
  vim.o.timeout = true
  vim.o.timeoutlen = 300
end

return options
