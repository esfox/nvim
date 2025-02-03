return {
  "mhartington/formatter.nvim",
  config = function()
    require("formatter").setup({
      filetype = {
        javascript = { require("formatter.filetypes.javascript").prettierd },
        typescript = { require("formatter.filetypes.javascript").prettierd },
        typescriptreact = { require("formatter.filetypes.typescriptreact").prettierd },
        javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
        json = { require("formatter.filetypes.json").prettierd },
        css = { require("formatter.filetypes.css").prettierd },
        scss = { require("formatter.filetypes.css").prettierd },
        html = { require("formatter.filetypes.html").prettierd },
        angular = { require("formatter.filetypes.html").prettierd },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        yaml = { require("formatter.filetypes.yaml").prettierd },
        graphql = { require("formatter.filetypes.graphql").prettierd },
        lua = { require("formatter.filetypes.lua").stylua },
        vue = { require("formatter.filetypes.vue").prettier },
        astro = { require("formatter.filetypes.javascript").prettierd },
        svelte = { require("formatter.filetypes.svelte").prettier },
        cs = { require("formatter.filetypes.cs").csharpier() },
      },
    })
  end,
}
