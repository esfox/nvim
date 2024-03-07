if not vim.g.started_by_firenvim then
  return
end
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

require("lazy").setup({
  {
    dir = vim.env.HOME .. "/.config/nvim/colorschemes/vscode-modified",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode").setup()
      -- vim.cmd.colorscheme 'sozhemtor'
    end,
  },
  { "kylechui/nvim-surround", opts = {} },
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
})

vim.keymap.set("", "<c-cr>", ":wqa<cr>")
vim.keymap.set("i", "<c-cr>", "<esc>:wqa<cr>")
vim.keymap.set({ "", "i" }, "<c-w>", ":qa!<cr>")
vim.o.laststatus = 0
vim.o.wrap = true
vim.opt.guifont = { "JetBrains Mono NL Light", ":h10" }
vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      takeover = "never",
      selector = "",
      priority = 0,
    },
  },
}
