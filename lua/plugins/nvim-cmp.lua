local keymaps = require("keymaps")

local function deprio(kind)
  return function(e1, e2)
    if e1:get_kind() == kind then
      return false
    end
    if e2:get_kind() == kind then
      return true
    end
  end
end

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
    local types = require("cmp.types")
    cmp.setup({
      sorting = {
        comparators = {
          cmp.config.compare.exact,
          deprio(types.lsp.CompletionItemKind.Text),
          deprio(types.lsp.CompletionItemKind.Snippet),
          cmp.config.compare.offset,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
        },
      },
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
      performance = {
        debounce = 10,
        max_view_entries = 20,
        throttle = 10,
        fetching_timeout = 100,
        confirm_resolve_timeout = 10,
      },
    })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
