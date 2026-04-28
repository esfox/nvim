return {
  "stevearc/conform.nvim",
  config = function()
    local js_formatter_options = {
      "biome",
      "biome-organize-imports",
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

    require("conform").setup({
      -- format_after_save = {
      --   lsp_format = "fallback",
      -- },
      format_on_save = function()
        local lsp_format_opt = "never"
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        cs = { "csharpier" },
        sql = { "sleek" },
        javascript = js_formatter_options,
        typescript = js_formatter_options,
        javascriptreact = js_formatter_options,
        typescriptreact = js_formatter_options,
        json = js_formatter_options,
        css = js_formatter_options,
        scss = js_formatter_options,
        html = js_formatter_options,
        angular = js_formatter_options,
        markdown = js_formatter_options,
        yaml = js_formatter_options,
        graphql = js_formatter_options,
        vue = js_formatter_options,
        astro = js_formatter_options,
        svelte = js_formatter_options,
        ["*"] = { "injected" },
      },
      formatters = {
        biome = {
          require_cwd = true,
          options = {
            formatters = {
              markdown = {
                indentWidth = 4,
                formatter = {
                  indentWidth = 4,
                },
              },
            },
          },
        },
      },
      sleek = {
        command = "sleek",
        args = "--indent-spaces=2 --lines-between-queries=3",
      },
    })

    vim.keymap.set("n", "<leader>ff", function()
      -- require("conform").format({ async = true })
      require("conform").format({ async = true, lsp_format = "never" })
    end)
  end,
}
