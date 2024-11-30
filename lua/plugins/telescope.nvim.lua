return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
  config = function()
    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "olddirs")
    pcall(require("telescope").load_extension, "undo")
    pcall(require("telescope").load_extension, "git_signs")

    -- vim.cmd [[highlight TelescopeNormal guibg=#2c2c2c]]
    -- vim.cmd [[highlight TelescopePreviewNormal guibg=#363636]]
    -- vim.cmd [[highlight TelescopeBorder guibg=#2c2c2c]]
    -- vim.cmd [[highlight TelescopePreviewBorder guibg=#363636]]
    -- vim.cmd [[highlight TelescopeTitle guibg=#a7df78 guifg=#202020]]

    require("telescope").setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          mirror = true,
        },
        -- sorting_strategy = 'ascending',
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        mappings = {
          i = {
            ["<c-v>"] = { "<c-r>+", type = "command" },
          },
        },
      },
    })
  end,
}
