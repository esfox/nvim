return {
  "stevearc/conform.nvim",
  config = function()
    local js_formatter_options = {
      "biome",
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

    require("conform").setup({
      format_after_save = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        cs = { "csharpier" },
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
      },
      formatters = {
        biome = {
          require_cwd = true,
        },
      },
    })

    vim.keymap.set("n", "<leader>ff", function()
      require("conform").format({ async = true })
    end)
  end,
}
