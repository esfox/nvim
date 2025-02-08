local helpers = require("helpers")

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "float",
        popup = {
          size = {
            width = 110,
          },
        },
        width = 55,
        mappings = {
          ["/"] = "noop",
          ["<c-x>"] = "noop",
          ["<backspace>"] = "noop",
          ["h"] = "close_node",
          ["l"] = "open",
          ["<leader>/"] = "filter_on_submit",
          ["<esc>"] = "clear_filter",
          ["^"] = "navigate_up",
          ["gy"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = vim.fn.fnamemodify(filepath, ":.")
            helpers.copy_to_sys_clipboard(relative_path)
          end,
          ["gY"] = function(state)
            local node = state.tree:get_node()
            local filename = node.name
            helpers.copy_to_sys_clipboard(filename)
          end,
          -- ["l"] = "open_and_clear_filter",
          -- ["<cr>"] = "open_and_clear_filter",
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
            -- local state = require("neo-tree.sources.manager").get_state("filesystem")
            -- local cmds = require("neo-tree.sources.filesystem.commands")
            -- cmds.clear_filter(state)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      commands = {
        open_and_clear_filter = function(state)
          local node = state.tree:get_node()
          if node and node.type == "file" then
            local cmds = require("neo-tree.sources.filesystem.commands")
            cmds.open(state)
            -- cmds.clear_filter(state)
          end
        end,
      },
    })

    vim.keymap.set({ "", "i" }, "<c-e>", function()
      require("neo-tree.command").execute({ action = "focus", toggle = true })
    end)
    vim.keymap.set("n", "<leader>e", function()
      require("neo-tree.command").execute({
        action = "focus",
        toggle = true,
        reveal = true,
      })
    end)
  end,
}
