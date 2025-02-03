return {
  "danielfalk/smart-open.nvim",
  branch = "0.2.x",
  config = function()
    local telescope = require("telescope")

    telescope.load_extension("smart_open")

    -- vim.keymap.set({ "n", "i", "v" }, "<c-p>", function()
    --   telescope.extensions.smart_open.smart_open({
    --     cwd_only = true,
    --   })
    -- end, { desc = "Find [p]reviously opened files" })
  end,
  dependencies = {
    "kkharji/sqlite.lua",
    -- Only required if using match_algorithm fzf
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
    { "nvim-telescope/telescope-fzy-native.nvim" },
  },
}
