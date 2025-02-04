local helpers = require("helpers")

local commands = {}

function commands.load_user_commands()
  vim.api.nvim_create_user_command("NoAutocmdSave", function(_)
    vim.cmd("silent! noautocmd w")
  end, { desc = "Save without running auto commands" })

  vim.api.nvim_create_user_command("CopyCurrentFilePath", function(_)
    local filepath = vim.fn.expand("%:.")
    os.execute("echo " .. filepath .. "| xclip -sel clipboard")
    print("Copied current file path (" .. filepath .. ")")
    vim.fn.getchar()
  end, { desc = "Copy current file path" })

  vim.api.nvim_create_user_command("CopyCurrentFileAbsolutePath", function(_)
    local filepath = vim.fn.expand("%:p")
    os.execute("echo " .. filepath .. "| xclip -sel clipboard")
    print("Copied current absolute file path (" .. filepath .. ")")
    vim.fn.getchar()
  end, { desc = "Copy current file absolute path" })

  -- Angular
  vim.api.nvim_create_user_command("SetAngularFiletype", function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(bufnr, "filetype", "angular")
  end, { desc = "Set current buffer filetype to `angular`" })
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

  vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = "*.component.html",
    callback = function()
      vim.bo.filetype = "angular"
    end,
  })
end

function commands.on_lsp_attach(buffer_number)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(buffer_number, "LspFormat", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer_number,
    group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false }),
    callback = function()
      if helpers.is_noautocmd_write_path() then
        return
      end
      -- vim.cmd("silent! EslintFixAll")
      vim.cmd("silent! noautocmd w")
    end,
    desc = "Async format after write",
  })
end

return commands
