local options = require("options")
local keymaps = require("keymaps")
local commands = require("commands")

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

options.general()
keymaps.general()
commands.load_auto_commands()

-- grug-far uses pcall(vim.treesitter.get_parser) expecting an error on failure,
-- but 0.12 returns nil instead. Wrap to restore the throw behavior.
local _orig_get_parser = vim.treesitter.get_parser
vim.treesitter.get_parser = function(...)
  local parser = _orig_get_parser(...)
  if not parser then
    error("no parser for language")
  end
  return parser
end

require("lazy").setup("plugins")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
