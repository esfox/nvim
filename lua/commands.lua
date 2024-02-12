local helpers = require("helpers")

local commands = {}

function commands.load_user_commands()
  vim.api.nvim_create_user_command("NoAutocmdSave", function(_)
    vim.cmd("silent! noautocmd w")
  end, { desc = "Save without running auto commands" })

  vim.api.nvim_create_user_command("GitBlameView", function(_)
    vim.cmd("silent! Git blame")
  end, { desc = "View Git blame for current file" })
end

function commands.load_auto_commands()
  -- [[ Highlight on yank ]]
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })

  vim.api.nvim_create_autocmd("BufRead,BufEnter", {
    pattern = "*.component.html",
    callback = function()
      vim.bo.filetype = "angular"
    end,
  })

  -- local format_group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
  -- vim.api.nvim_create_autocmd("User", {
  --   callback = function()
  --     vim.cmd("silent! OrganizeImports")
  --     vim.cmd("silent! EslintFixAll")
  --     vim.cmd("silent! noautocmd w")
  --   end,
  --   group = format_group,
  --   pattern = "FormatterPre",
  -- })
end

function commands.on_lsp_attach(buffer_number)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(buffer_number, "LspFormat", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = buffer_number,
    group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false }),
    callback = function()
      if helpers.is_noautocmd_write_path() then
        return
      end
      -- vim.lsp.buf.format({ bufnr = buffer_number, async = true })
      vim.cmd("FormatWrite")
    end,
    desc = "Async format after write",
  })
end

return commands
