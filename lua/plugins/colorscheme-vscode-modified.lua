return {
  dir = vim.env.HOME .. "/.config/nvim/colorschemes/vscode-modified",
  lazy = false,
  priority = 1000,
  config = function()
    require("vscode").setup()
  end,
}
