return {}

-- return {
--   "nvim-tree/nvim-tree.lua",
--   config = function()
--     local on_attach = function(buffer_number)
--       local nvim_tree_api = require("nvim-tree.api")
--       nvim_tree_api.config.mappings.default_on_attach(buffer_number)
--       keymaps.for_nvim_tree(buffer_number)
--     end
--
--     local options = {
--       on_attach = on_attach,
--       sync_root_with_cwd = true,
--       hijack_unnamed_buffer_when_opening = false,
--       view = {
--         -- side = helpers.is_laptop() and 'left' or 'right',
--         side = "left",
--         width = helpers.is_laptop() and 45 or 55,
--         number = true,
--         relativenumber = true,
--         float = {
--           enable = true,
--           quit_on_focus_loss = false,
--           open_win_config = {
--             width = 100,
--             height = 55,
--           },
--         },
--       },
--       live_filter = {
--         always_show_folders = false,
--       },
--       git = {
--         ignore = false,
--       },
--       renderer = {
--         icons = {
--           glyphs = {
--             git = {
--               unstaged = "",
--               staged = "",
--               unmerged = "",
--               renamed = "➜",
--               untracked = "",
--               deleted = "",
--               ignored = "",
--             },
--           },
--         },
--         root_folder_label = function(path)
--           return vim.fn.fnamemodify(path, ":t")
--         end,
--         highlight_git = true,
--         highlight_modified = "all",
--       },
--       actions = {
--         open_file = {
--           quit_on_open = true,
--           -- quit_on_open = not helpers.is_wide(),
--         },
--       },
--     }
--
--     -- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     --   callback = function()
--     --     if helpers.is_wide() then
--     --       require("nvim-tree.api").tree.open()
--     --     end
--     --   end,
--     -- })
--
--     if not helpers.is_laptop() then
--       options.view.side = "left"
--       options.actions = {
--         open_file = {
--           quit_on_open = not helpers.is_wide(),
--         },
--       }
--     end
--
--     require("nvim-tree").setup(options)
--   end,
-- }
