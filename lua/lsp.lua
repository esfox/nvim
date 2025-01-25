local options = require("options")
local keymaps = require("keymaps")
local commands = require("commands")

local lsp = {}

local function setup_sonarlint()
  require("sonarlint").setup({
    server = {
      cmd = {
        "sonarlint-language-server",
        "-stdio",
        "-analyzers",
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
      },
    },
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    autostart = true,
  })

  -- require("sonarlint").setup({
  --   server = {
  --     cmd = {
  --       "sonarlint-language-server",
  --       -- Ensure that sonarlint-language-server uses stdio channel
  --       "-stdio",
  --       "-analyzers",
  --       -- paths to the analyzers you need, using those for python and java in this example
  --       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarlintomnisharp.jar"),
  --       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
  --     },
  --     settings = {
  --       sonarlint = {
  --         test = "test",
  --       },
  --     },
  --   },
  --   filetypes = {
  --     "typescript",
  --     "javascript",
  --     "cs",
  --   },
  --   autostart = true,
  -- })
end

function lsp.setup()
  -- LSP settings.
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    commands.on_lsp_attach(bufnr)
    options.on_lsp_attach()
    keymaps.on_lsp_attach(bufnr)
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

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Setup mason so it can manage external tooling
  require("mason").setup()

  -- Ensure the servers above are installed
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  local lspconfig = require("lspconfig")
  setup_sonarlint()

  mason_lspconfig.setup_handlers({
    function(server_name)
      local lsp_setup_config = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }

      if server_name == "vtsls" then
        lsp_setup_config["root_dir"] = lspconfig.util.root_pattern(".git")
        lsp_setup_config["single_file_support"] = true
        lsp_setup_config["settings"] = {
          typescript = {
            preferences = {
              importModuleSpecifierEnding = "ts",
            },
          },
        }
      elseif server_name == "denols" then
        lsp_setup_config["root_dir"] = lspconfig.util.root_pattern("deno.json")
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
        lsp_setup_config["filetypes"] =
          { "angular", "html", "css", "scss", "typescriptreact", "svelte" }
      elseif server_name == "prettierd" then
        lsp_setup_config["filetypes"] = lsp_setup_config["filetypes"].insert("svg")
      elseif server_name == "html" then
        lsp_setup_config["filetypes"] = { "angular", "html", "svelte" }
      end

      lspconfig[server_name].setup(lsp_setup_config)
    end,
  })
end

return lsp
