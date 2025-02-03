return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
  config = function()
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

    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "undo")
    pcall(require("telescope").load_extension, "git_signs")
    pcall(require("telescope").load_extension, "git_file_history")

    vim.keymap.set("", "<leader>b", ":Telescope buffers<CR>")
    vim.keymap.set("", "<leader>m", ":Telescope marks<CR>")

    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown()
      )
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- vim.keymap.set({ "", "i", "v" }, "<c-o>", function()
    --   local telescope = require("telescope")
    --   telescope.extensions.menufacture.find_files({
    --     previewer = false,
    --     menufacture = {
    --       mappings = {
    --         [{ "i", "n" }] = {
    --           ["<c-h>"] = telescope.extensions.menufacture.menu_actions.toggle_hidden.action,
    --           ["<c-i>"] = telescope.extensions.menufacture.menu_actions.toggle_no_ignore.action,
    --         },
    --         -- toggle_hidden = { [{ "i", "n" }] = "<c-h>" },
    --         -- toggle_no_ignore = { [{ "i", "n" }] = "<c-i>" },
    --       },
    --     },
    --   })
    -- end, { desc = "Search Files" })

    vim.keymap.set(
      { "n", "i", "v" },
      "<leader>;",
      require("telescope.builtin").commands,
      { desc = "Search Commands" }
    )

    vim.keymap.set(
      "n",
      "<leader>sw",
      require("telescope.builtin").grep_string,
      { desc = "[S]earch current [W]ord" }
    )

    vim.keymap.set(
      "n",
      "<leader>sh",
      require("telescope.builtin").help_tags,
      { desc = "[S]earch [H]elp" }
    )

    vim.keymap.set(
      "n",
      "<leader>sg",
      require("telescope").extensions.menufacture.live_grep,
      { desc = "[S]earch by [G]rep" }
    )

    vim.keymap.set(
      "n",
      "<leader>sd",
      require("telescope.builtin").diagnostics,
      { desc = "[S]earch [D]iagnostics" }
    )

    vim.keymap.set("n", "<leader>su", ":Telescope undo<cr>")
    -- vim.keymap.set("n", "gR", require("telescope.builtin").lsp_references)
    vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols)
    vim.keymap.set("n", "<leader>ts", require("telescope.builtin").treesitter)
    vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
  end,
}
