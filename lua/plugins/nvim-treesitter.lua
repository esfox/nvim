return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- Install parsers
    require("nvim-treesitter").install({
      "c",
      "cpp",
      "c_sharp",
      "lua",
      "python",
      "tsx",
      "typescript",
      "javascript",
      "json",
      "markdown",
      "vim",
      "sql",
    })

    -- Setup textobjects
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        keymaps = {
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ar"] = "@assignment.rhs",
          ["al"] = "@assignment.lhs",
          ["ac"] = "@call.outer",
          ["ic"] = "@call.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
        },
      },
      move = {
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    })

    -- Enable treesitter highlighting for relevant filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c", "cpp", "c_sharp", "lua", "python", "tsx", "typescript",
        "javascript", "json", "markdown", "vim", "sql",
      },
      callback = function(args)
        vim.treesitter.start(args.buf)
      end,
    })

    -- Enable treesitter indent (except python)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c", "cpp", "c_sharp", "lua", "tsx", "typescript",
        "javascript", "json", "markdown", "vim", "sql",
      },
      callback = function(args)
        if vim.bo[args.buf].filetype ~= "python" then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>th", ":Inspect<CR>")


  end,
}
