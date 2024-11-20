local options = require("options")
local keymaps = require("keymaps")
local commands = require("commands")

local lsp = {}

function lsp.setup()
  -- LSP settings.
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    keymaps.for_lsp(bufnr)
    commands.on_lsp_attach(bufnr)
    options.on_lsp_attach()
  end

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }

  -- Setup mason so it can manage external tooling
  require("mason").setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  local blink = require("blink.cmp")

  mason_lspconfig.setup_handlers({
    function(server_name)
      local lspconfig = require("lspconfig")


      local capabilities = lspconfig[server_name].capabilities
      local lsp_setup_config = {
        capabilities = blink.get_lsp_capabilities(capabilities),
        on_attach = on_attach,
        settings = servers[server_name],
      }

      if server_name == "tsserver" then
        lsp_setup_config["handlers"] = {
          ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            if result.diagnostics == nil then
              return
            end

            -- ignore some tsserver diagnostics
            local idx = 1
            while idx <= #result.diagnostics do
              local entry = result.diagnostics[idx]

              local formatter = require("format-ts-errors")[entry.code]
              entry.message = formatter and formatter(entry.message) or entry.message

              -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
              if entry.code == 80001 then
                -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end

            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
          end,
        }

        local function organize_imports()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          }
          vim.lsp.buf.execute_command(params)
        end

        lsp_setup_config["commands"] = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
        }
      elseif server_name == "jsonls" then
        lsp_setup_config["filetypes"] = { "json", "jsonc" }
        lsp_setup_config["settings"] = {
          json = {
            -- Schemas https://www.schemastore.org
            schemas = require("schemastore").json.schemas(),
          },
        }
      elseif server_name == "angularls" then
        lsp_setup_config["filetypes"] = { "angular" }
      elseif server_name == "emmet_language_server" then
        lsp_setup_config["filetypes"] = { "angular", "html", "css", "scss", "typescriptreact" }
      elseif server_name == "html" then
        lsp_setup_config["filetypes"] = { "angular", "html" }
      end

      lspconfig[server_name].setup(lsp_setup_config)
    end,
  })
end

return lsp
