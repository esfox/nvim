local keymaps = require("keymaps")

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    local kind_icons = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = keymaps.for_cmp(cmp),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
      formatting = {
        format = function(entry, item)
          item.kind = string.format("%s %s", kind_icons[item.kind], "[" .. item.kind .. "]")
          item.menu = entry.completion_item.detail
          return item
        end,
      },
    })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
