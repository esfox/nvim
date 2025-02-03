return {
  "stevearc/conform.nvim",
  config = function()
    local prettier_options = {
      "prettierd",
      "prettier",
      stop_after_first = true,
    }

    require("conform").setup({
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        cs = { "csharpier" },
        javascript = prettier_options,
        typescript = prettier_options,
        javascriptreact = prettier_options,
        typescriptreact = prettier_options,
        json = prettier_options,
        css = prettier_options,
        scss = prettier_options,
        html = prettier_options,
        angular = prettier_options,
        markdown = prettier_options,
        yaml = prettier_options,
        graphql = prettier_options,
        vue = prettier_options,
        astro = prettier_options,
        svelte = prettier_options,
      },
    })

    vim.keymap.set("n", "<leader>ff", function()
      require("conform").format({ async = true })
    end)
  end,
}
