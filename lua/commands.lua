local commands = {}

function commands.load_auto_commands()
  -- [[ Highlight on yank ]]
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })
end

function commands.on_lsp_attach(buffer_number)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(buffer_number, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = buffer_number,
    group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false }),
    callback = function()
      vim.lsp.buf.format { bufnr = buffer_number, async = async }
      vim.cmd('silent! FormatWrite')
      vim.cmd('silent! EslintFixAll')
    end,
    desc = '[lsp] format on save',
  })
end

return commands
