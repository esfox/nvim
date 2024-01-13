-- return {}

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    window = {
      width = 55,
      mappings = {
        ["/"] = "noop",
        ["<c-x>"] = "noop",
        ["h"] = "close_node",
        ["l"] = "open",
        ["<leader>/"] = "filter_on_submit",
        ["<esc>"] = "clear_filter",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = {
          "node_modules",
        },
      },
      find_command = "fdfind",
      find_args = {
        fdfind = {
          "--exclude",
          ".git",
          "--exclude",
          "node_modules",
        },
      },
      components = {
        name = function(config, node, state)
          local name = node.name
          if node:get_depth() == 1 then
            name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end

          local highlights = require("neo-tree.ui.highlights")
          local highlight = config.highlight or highlights.FILE_NAME
          if node.type == "directory" then
            highlight = highlights.DIRECTORY_NAME
          end
          if node:get_depth() == 1 then
            highlight = highlights.ROOT_NAME
          else
            if config.use_git_status_colors == nil or config.use_git_status_colors then
              local git_status = state.components.git_status({}, node, state)
              if git_status and git_status.highlight then
                highlight = git_status.highlight
              end
            end
          end
          return {
            text = name,
            highlight = highlight,
          }
        end,
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.cmd([[ setlocal relativenumber ]])
        end,
      },
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
