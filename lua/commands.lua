local commands = {}

function commands.load_auto_commands()
  -- [[ Highlight on yank ]]
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })

  -- [[ Terminal Startup & Lifecycle ]]
  local term_group = vim.api.nvim_create_augroup("TerminalLifecycle", { clear = true })

  -- Always start in terminal; if file/folder given in args, cd into its directory
  vim.api.nvim_create_autocmd("VimEnter", {
    group = term_group,
    callback = function()
      local arg = vim.fn.argv(0)
      if arg and arg ~= "" then
        local target_dir
        if vim.fn.isdirectory(arg) == 1 then
          target_dir = vim.fn.fnamemodify(arg, ":p")
        else
          target_dir = vim.fn.fnamemodify(arg, ":p:h")
        end

        if target_dir and target_dir ~= "" and vim.fn.isdirectory(target_dir) == 1 then
          vim.fn.chdir(target_dir)
        end

        vim.cmd("%bwipeout!")
      end

      require("layout").setup()
      require("keymaps").layout()
    end,
  })

  -- Auto-close when shell exits (regardless of exit code, e.g. Ctrl-C then Ctrl-D)
  vim.api.nvim_create_autocmd("TermClose", {
    group = term_group,
    callback = function()
      vim.schedule(function()
        vim.cmd("quitall!")
      end)
    end,
  })

  -- [[ Strict Single-Buffer Enforcement ]]
  -- Block split, tab, and new buffer commands in main window (tmux handles multiplexing)
  local blocked_cmds = { "split", "vsplit", "tabnew", "tabedit", "tab", "enew", "new", "vnew", "sp", "vs" }
  for _, cmd in ipairs(blocked_cmds) do
    vim.cmd(string.format(
      "cnoreabbrev <expr> %s (getcmdtype() == ':' && getcmdline() ==# '%s' && v:lua.require('layout').is_main_win()) ? 'echo \"Single buffer only! Use tmux.\"' : '%s'",
      cmd,
      cmd,
      cmd
    ))
  end

  -- [[ Safe Quit Confirmation ]]
  vim.api.nvim_create_user_command("Quit", function()
    require("layout").confirm_quit()
  end, { desc = "Confirm quit from nvim.term" })
  vim.api.nvim_create_user_command("Q", function()
    require("layout").confirm_quit()
  end, { desc = "Confirm quit from nvim.term" })

  -- In main host window, redirect :q and :qa to :Quit confirmation modal
  vim.cmd([[
    cnoreabbrev <expr> q (getcmdtype() == ':' && getcmdline() ==# 'q' && v:lua.require('layout').is_main_win()) ? 'Quit' : 'q'
    cnoreabbrev <expr> qa (getcmdtype() == ':' && getcmdline() ==# 'qa' && v:lua.require('layout').is_main_win()) ? 'Quit' : 'qa'
  ]])

  -- [[ Saved Commands Creation ]]
  vim.api.nvim_create_user_command("CreateSavedCommand", function()
    require("saved_commands.form").open_create_form()
  end, { desc = "Open form to create new saved command" })
  vim.api.nvim_create_user_command("SaveCommand", function()
    require("saved_commands.form").open_create_form()
  end, { desc = "Open form to create new saved command" })
end

return commands
