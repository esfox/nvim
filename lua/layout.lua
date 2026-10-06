local consts = require "consts"

local M = {}

M.term_buf = nil
M.term_win = nil
M.term_chan = nil

local cached_cwd = nil
local cached_branch = nil
local last_check_time = 0

local function setup_highlights()
  -- Matches ~/.zsh_prompt_string
  vim.api.nvim_set_hl(0, "AgyPromptCorner", { fg = "#e0af68", bold = true })
  vim.api.nvim_set_hl(0, "AgyPromptLaptop", { fg = "#00d75f", bg = "#262626", bold = true })
  vim.api.nvim_set_hl(0, "AgyPromptTriangle1", { fg = "#262626", bg = "#00d75f" })
  vim.api.nvim_set_hl(0, "AgyPromptDir", { fg = "#000000", bg = "#00d75f", bold = true })
  vim.api.nvim_set_hl(0, "AgyPromptTriangle2", { fg = "#00d75f" })
  vim.api.nvim_set_hl(0, "AgyPromptGit", { fg = "#5fd7ff", bold = true })
  vim.api.nvim_set_hl(0, "AgyPromptSymbol", { fg = "#e0af68", bold = true })
  vim.api.nvim_set_hl(0, "AgyPromptCont", { fg = "#565f89" })
end

local function get_git_branch(cwd)
  if not cwd or cwd == "" then
    return nil
  end

  local git_root = vim.fs.root(cwd, ".git")
  if not git_root then
    return nil
  end

  local dot_git = git_root .. "/.git"
  local stat = vim.uv.fs_stat(dot_git)
  local head_path = dot_git .. "/HEAD"

  -- If .git is a file (worktree or submodule), parse gitdir
  if stat and stat.type == "file" then
    local gf = io.open(dot_git, "r")
    if gf then
      local line = gf:read("*l")
      gf:close()
      local gitdir = line and line:match("^gitdir:%s*(.+)$")
      if gitdir then
        if not gitdir:match("^/") then
          gitdir = git_root .. "/" .. gitdir
        end
        head_path = gitdir .. "/HEAD"
      end
    end
  end

  local f = io.open(head_path, "r")
  if f then
    local content = f:read("*l")
    f:close()
    if content then
      local branch = content:match("^ref: refs/heads/(.+)$")
      if branch then
        return branch
      end
      local hash = content:match("^([0-9a-fA-F]+)$")
      if hash then
        return hash:sub(1, 7)
      end
    end
  end

  -- Fallback to git CLI
  local handle = io.popen("git -C " .. vim.fn.shellescape(cwd) .. " branch --show-current 2>/dev/null")
  if handle then
    local branch = handle:read("*l")
    handle:close()
    if branch and branch ~= "" then
      return branch
    end
  end

  return nil
end

local function update_prompt_state(force)
  local now = vim.uv.now()
  if not force and cached_cwd and (now - last_check_time < 200) then
    return cached_cwd, cached_branch
  end
  last_check_time = now

  local cwd = nil
  if M.term_chan then
    local pid = vim.fn.jobpid(M.term_chan)
    if pid and pid > 0 then
      local handle = io.popen("lsof -p " .. pid .. " -a -d cwd -Fn 2>/dev/null")
      if handle then
        local output = handle:read("*a")
        handle:close()
        if output then
          local parsed = output:match("n([^\n]+)")
          if parsed and parsed ~= "" and vim.fn.isdirectory(parsed) == 1 then
            cwd = parsed
          end
        end
      end
    end
  end

  if not cwd then
    cwd = vim.fn.getcwd()
  end

  if cwd and cwd ~= "" and cwd ~= vim.fn.getcwd() then
    pcall(vim.fn.chdir, cwd)
  end

  cached_cwd = cwd
  cached_branch = get_git_branch(cwd)
  return cached_cwd, cached_branch
end

function M.sync_cwd(force)
  return update_prompt_state(force)
end

function M.winbar()
  local cwd, branch = update_prompt_state()
  local display_dir = vim.fn.fnamemodify(cwd, ":~")

  local parts = {
    "%#AgyPromptLaptop#  💻 ",
    "%#AgyPromptTriangle1#",
    "%#AgyPromptDir# ",
    display_dir,
    " ",
    "%#AgyPromptTriangle2#",
  }

  if branch and branch ~= "" then
    table.insert(parts, "%#AgyPromptGit#  ")
    table.insert(parts, branch)
    table.insert(parts, " ")
  end

  table.insert(parts, "%*")
  return table.concat(parts, "")
end

local MIN_INPUT_HEIGHT = 7
local MAX_INPUT_HEIGHT = 20

local scroll_pending = false

function M.scroll_term_to_bottom()
  if not M.term_win or not vim.api.nvim_win_is_valid(M.term_win) then
    return
  end
  if not M.term_buf or not vim.api.nvim_buf_is_valid(M.term_buf) then
    return
  end

  local cur_win = vim.api.nvim_get_current_win()
  local line_count = vim.api.nvim_buf_line_count(M.term_buf)

  -- If focused in terminal window:
  -- - in terminal mode ('t'): Neovim terminal emulator follows cursor automatically
  -- - in normal/visual mode: don't hijack cursor if user scrolled up to inspect
  if cur_win == M.term_win then
    if vim.fn.mode() == "t" then
      return
    end
    local cur_cursor = vim.api.nvim_win_get_cursor(M.term_win)
    if cur_cursor[1] < line_count - 1 then
      return
    end
  end

  pcall(vim.api.nvim_win_set_cursor, M.term_win, { line_count, 0 })
end

local function schedule_scroll_term()
  if scroll_pending then
    return
  end
  scroll_pending = true
  vim.schedule(function()
    scroll_pending = false
    M.scroll_term_to_bottom()
  end)
end

function M.adjust_input_height() end

function M.refresh_prompt()
  update_prompt_state(true)
end

local function sanitize_command(raw_lines)
  local lines = {}
  for _, l in ipairs(raw_lines) do
    table.insert(lines, l)
  end

  -- Strip trailing blank lines
  while #lines > 0 and lines[#lines]:match("^%s*$") do
    table.remove(lines)
  end

  if #lines == 0 then
    return ""
  end

  if #lines == 1 then
    return lines[1]
  end

  local sanitized = {}
  for i, line in ipairs(lines) do
    local trimmed = line:gsub("%s+$", "")
    if i < #lines then
      -- If line does not already end with backslash, append ' \'
      if trimmed:sub(-1) == "\\" then
        table.insert(sanitized, trimmed)
      else
        table.insert(sanitized, trimmed .. " \\")
      end
    else
      table.insert(sanitized, trimmed)
    end
  end

  return table.concat(sanitized, "\n")
end

local function get_all_git_branches(cwd)
  if not cwd or cwd == "" then
    return {}
  end
  local git_root = vim.fs.root(cwd, ".git")
  if not git_root then
    return {}
  end

  local branches = {}
  local handle = io.popen("git -C " .. vim.fn.shellescape(cwd) .. ' branch --format="%(refname:short)" 2>/dev/null')
  if handle then
    for branch in handle:lines() do
      if branch and branch ~= "" then
        table.insert(branches, branch)
      end
    end
    handle:close()
  end
  return branches
end

function M.handle_tab()
  -- If popup menu already open, cycle to next item
  if vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, false, true), "n", false)
    return
  end

  local col = vim.fn.col(".")
  local line = vim.api.nvim_get_current_line()
  local before = line:sub(1, col - 1)

  -- Indent if blank before cursor
  if before:match("^%s*$") then
    vim.api.nvim_feedkeys("  ", "n", false)
    return
  end

  -- Sync Neovim working dir with terminal shell cwd
  local term_cwd = update_prompt_state()
  if term_cwd and term_cwd ~= "" and term_cwd ~= vim.fn.getcwd() then
    pcall(vim.fn.chdir, term_cwd)
  end

  -- Find start of current word
  local word_start = before:match(".*()[%s=|&;]")
  word_start = word_start and (word_start + 1) or 1
  local word = before:sub(word_start)
  local prefix = before:sub(1, word_start - 1)

  local matches = {}

  if word:match("^%$") then
    -- Environment variable completion
    local env_matches = vim.fn.getcompletion(word:sub(2), "environment")
    for _, e in ipairs(env_matches) do
      table.insert(matches, "$" .. e)
    end
  else
    local trimmed_prefix = prefix:gsub("%s+$", "")
    local is_command = (trimmed_prefix == "" or trimmed_prefix:match("[%|%&%;]$"))

    if is_command then
      -- Complete commands in PATH
      matches = vim.fn.getcompletion(word, "shellcmd")
      if word:match("^%.?/") then
        for _, f in ipairs(vim.fn.getcompletion(word, "file")) do
          table.insert(matches, f)
        end
      end
    else
      -- Git branches
      local is_git_branch = trimmed_prefix:match("git%s+(checkout|switch|merge|rebase|branch%s+%-d)$")
      if is_git_branch then
        local branches = get_all_git_branches(term_cwd or vim.fn.getcwd())
        for _, b in ipairs(branches) do
          if word == "" or b:find(word, 1, true) == 1 then
            table.insert(matches, b)
          end
        end
      end

      -- If 'cd', complete directories only
      if #matches == 0 and trimmed_prefix:match("^cd$") then
        matches = vim.fn.getcompletion(word, "dir")
      end

      -- Default: file / directory completion
      if #matches == 0 then
        matches = vim.fn.getcompletion(word, "file")
      end
    end
  end

  if #matches == 0 then
    return
  end

  -- Single match: insert directly
  if #matches == 1 then
    local match = matches[1]
    if match:sub(-1) ~= "/" then
      match = match .. " "
    end
    local after = line:sub(col)
    local new_line = before:sub(1, word_start - 1) .. match .. after
    vim.api.nvim_set_current_line(new_line)
    local new_col = (word_start - 1) + #match
    vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), new_col })
    return
  end

  -- Multiple matches: trigger native completion popup menu
  vim.fn.complete(word_start, matches)
end

function M.handle_s_tab()
  if vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, false, true), "n", false)
    return
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", false)
end

local tui_timer = nil

local function is_tui_command(cmd)
  local first_line = cmd:match("^[^\n]+") or cmd
  first_line = first_line:match("^%s*(.-)%s*$")
  local words = {}
  for w in first_line:gmatch("%S+") do
    table.insert(words, w)
  end
  if #words == 0 then
    return false
  end

  local idx = 1
  while idx <= #words and (words[idx] == "sudo" or words[idx] == "env" or words[idx] == "time" or words[idx] == "nohup" or words[idx]:match("^%w+=")) do
    idx = idx + 1
  end

  local bin = words[idx]
  if not bin then
    return false
  end
  bin = bin:match("([^/]+)$") or bin

  if bin == "gh" and words[idx + 1] == "dash" then
    return true
  end

  return consts.TUI_COMMANDS[bin] == true
end

function M.hide_input() end
function M.show_input() end
function M.toggle_input()
  M.open_command_modal()
end
function M.jump_to_input()
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_set_current_win(M.term_win)
    vim.cmd("startinsert")
  end
end
function M.jump_to_term()
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_set_current_win(M.term_win)
    vim.cmd("startinsert")
  end
end
function M.toggle_focus()
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_set_current_win(M.term_win)
    vim.cmd("startinsert")
  end
end

M.edit_session = nil

function M.is_editing()
  return M.edit_session ~= nil
end

function M.is_main_win()
  return not M.is_editing()
end

local function setup_session_buffer(bufnr)
  local M = require("layout")
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) or bufnr == M.term_buf then
    return
  end
  if M.edit_session then
    M.edit_session.buffers[bufnr] = true
  end

  vim.bo[bufnr].buflisted = true
  vim.bo[bufnr].bufhidden = ""

  pcall(vim.api.nvim_buf_call, bufnr, function()
    vim.cmd([[
      cnoreabbrev <expr> <buffer> q (getcmdtype() ==# ":" && getcmdline() ==# "q") ? "bd" : "q"
      cnoreabbrev <expr> <buffer> q! (getcmdtype() ==# ":" && getcmdline() ==# "q!") ? "bd!" : "q!"
      cnoreabbrev <expr> <buffer> qa (getcmdtype() ==# ":" && getcmdline() ==# "qa") ? "lua require('layout').end_edit_session()" : "qa"
      cnoreabbrev <expr> <buffer> qa! (getcmdtype() ==# ":" && getcmdline() ==# "qa!") ? "lua require('layout').end_edit_session()" : "qa!"
      cnoreabbrev <expr> <buffer> wq (getcmdtype() ==# ":" && getcmdline() ==# "wq") ? "w<bar>bd" : "wq"
      cnoreabbrev <expr> <buffer> wq! (getcmdtype() ==# ":" && getcmdline() ==# "wq!") ? "w!<bar>bd!" : "wq!"
      cnoreabbrev <expr> <buffer> x (getcmdtype() ==# ":" && getcmdline() ==# "x") ? "w<bar>bd" : "x"
      cnoreabbrev <expr> <buffer> x! (getcmdtype() ==# ":" && getcmdline() ==# "x!") ? "w!<bar>bd!" : "x!"
    ]])
  end)

  vim.keymap.set("n", "ZZ", "<cmd>w<CR><cmd>bd<CR>", { buffer = bufnr, silent = true })
  vim.keymap.set("n", "ZQ", "<cmd>bd!<CR>", { buffer = bufnr, silent = true })

  pcall(vim.api.nvim_buf_create_user_command, bufnr, "Q", function(opts)
    vim.cmd("bd" .. (opts.bang and "!" or ""))
  end, { bang = true })
  pcall(vim.api.nvim_buf_create_user_command, bufnr, "Qa", function()
    M.end_edit_session()
  end, { bang = true })
  pcall(vim.api.nvim_buf_create_user_command, bufnr, "Wq", function(opts)
    vim.cmd("w" .. (opts.bang and "!" or "") .. " | bd" .. (opts.bang and "!" or ""))
  end, { bang = true })
end

function M.start_edit_session(target_bufnr, files, guest_pipe)
  -- 1. Keep term_buf alive in background, but unlisted so bnext/bprev never switches to it
  if M.term_buf and vim.api.nvim_buf_is_valid(M.term_buf) then
    vim.bo[M.term_buf].buflisted = false
  end

  -- 3. Pre-load all files and ensure listed
  local session_bufs = {}
  for _, f in ipairs(files or {}) do
    session_bufs[f.bufnr] = true
    if vim.api.nvim_buf_is_valid(f.bufnr) then
      pcall(vim.fn.bufload, f.bufnr)
      vim.bo[f.bufnr].buflisted = true
      vim.bo[f.bufnr].bufhidden = ""
    end
  end

  -- 4. Display target buffer in term_win
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_win_set_buf(M.term_win, target_bufnr)
    vim.api.nvim_set_current_win(M.term_win)

    -- Editor styling for full screen editing
    vim.wo[M.term_win].number = true
    vim.wo[M.term_win].relativenumber = true
    vim.wo[M.term_win].signcolumn = "yes"
    vim.wo[M.term_win].winbar = ""
    vim.wo[M.term_win].statusline = ""

    -- Enable native statusline during edit session
    vim.o.laststatus = 2
    vim.o.statusline = " %<%f %h%m%r%=%y  %l:%c  %P "
  end

  M.edit_session = {
    buffers = session_bufs,
    guest_pipe = guest_pipe,
  }

  for b in pairs(session_bufs) do
    setup_session_buffer(b)
  end

  local group = vim.api.nvim_create_augroup("AgyEditSession", { clear = true })

  -- Setup any new buffers created during edit session
  vim.api.nvim_create_autocmd("BufAdd", {
    group = group,
    callback = function(ev)
      if M.is_editing() and ev.buf ~= M.term_buf then
        setup_session_buffer(ev.buf)
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    group = group,
    callback = function(ev)
      if not M.edit_session or not M.edit_session.buffers[ev.buf] then
        return
      end
      M.edit_session.buffers[ev.buf] = nil

      local remaining = {}
      for b in pairs(M.edit_session.buffers) do
        if vim.api.nvim_buf_is_valid(b) then
          table.insert(remaining, b)
        end
      end

      if #remaining == 0 then
        pcall(vim.api.nvim_del_augroup_by_id, group)
        vim.schedule(function()
          M.end_edit_session()
        end)
      else
        vim.schedule(function()
          if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
            local cur = vim.api.nvim_win_get_buf(M.term_win)
            if not M.edit_session or not M.edit_session.buffers[cur] then
              vim.api.nvim_win_set_buf(M.term_win, remaining[1])
            end
          end
        end)
      end
    end,
  })
end

function M.end_edit_session()
  local s = M.edit_session
  if not s then return end

  local guest_pipe = s.guest_pipe
  local buffers = s.buffers
  M.edit_session = nil

  -- 1. Wipe any remaining session buffers
  for b in pairs(buffers or {}) do
    if vim.api.nvim_buf_is_valid(b) then
      pcall(vim.api.nvim_buf_delete, b, { force = true })
    end
  end

  -- 2. Restore term_buf in term_win
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    if M.term_buf and vim.api.nvim_buf_is_valid(M.term_buf) then
      vim.api.nvim_win_set_buf(M.term_win, M.term_buf)
      -- Restore terminal window styling
      vim.wo[M.term_win].number = false
      vim.wo[M.term_win].relativenumber = false
      vim.wo[M.term_win].signcolumn = "no"
      vim.wo[M.term_win].winbar = ""
      vim.wo[M.term_win].statusline = " "

      -- Hide status bar again in terminal mode
      vim.o.laststatus = 0
      vim.o.statusline = " "
    end
  end

  -- 3. Return focus directly to terminal window in insert mode (NO input box!)
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_set_current_win(M.term_win)
    vim.cmd("startinsert")
  end

  -- 4. Unblock guest via direct RPC
  if guest_pipe then
    pcall(function()
      local rpc = require("flatten.rpc")
      local ok, sock = rpc.connect(guest_pipe)
      if ok then
        rpc.exec_on_host(sock, function()
          pcall(function()
            require("flatten.guest").unblock()
          end)
        end, {}, false)
        pcall(vim.fn.chanclose, sock)
      end
    end)
  end
end

function M.confirm_quit()
  vim.cmd("stopinsert")

  local ok_popup, Popup = pcall(require, "nui.popup")
  if not ok_popup then
    vim.cmd("quitall!")
    return
  end

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " [ Exit nvim.term? ] ",
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = 46,
      height = 5,
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  })

  popup:mount()

  -- Guarantee Normal mode when popup appears
  vim.cmd("stopinsert")
  if vim.fn.mode() ~= "n" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  end

  local lines = {
    "",
    "   Active terminal session will close!",
    "",
    "         [y]es  /  [n]o (<Esc>)",
    "",
  }
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
  vim.bo[popup.bufnr].modifiable = false

  local ns = vim.api.nvim_create_namespace("quit_confirm")
  vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "WarningMsg", 1, 3, -1)
  vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Special", 3, 9, 14)
  vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Comment", 3, 19, 31)

  local function close()
    popup:unmount()
    if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
      vim.api.nvim_set_current_win(M.term_win)
      vim.cmd("startinsert")
    end
  end

  local function do_quit()
    popup:unmount()
    vim.cmd("quitall!")
  end

  local modes = { "n", "i" }
  for _, m in ipairs(modes) do
    popup:map(m, "y", do_quit, { noremap = true, silent = true })
    popup:map(m, "Y", do_quit, { noremap = true, silent = true })
    popup:map(m, "<CR>", do_quit, { noremap = true, silent = true })

    popup:map(m, "n", close, { noremap = true, silent = true })
    popup:map(m, "N", close, { noremap = true, silent = true })
    popup:map(m, "<Esc>", close, { noremap = true, silent = true })
    popup:map(m, "q", close, { noremap = true, silent = true })
  end

  popup:on("BufLeave", function()
    pcall(function()
      popup:unmount()
    end)
  end, { once = true })
end

function M.handle_ctrl_d()
  if M.term_buf and vim.api.nvim_get_current_buf() == M.term_buf then
    M.confirm_quit()
  end
end

function M.handle_ctrl_c()
  -- Close cmp completion menu if visible
  local ok_cmp, cmp = pcall(require, "cmp")
  if ok_cmp and cmp.visible() then
    cmp.close()
  end

  if M.term_chan then
    vim.api.nvim_chan_send(M.term_chan, "\x03")
  end
  vim.cmd("startinsert")
end

function M.toggle_terminal_normal()
  local mode = vim.fn.mode()
  if mode == "t" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<C-\><C-n>]], true, false, true), "n", false)
  else
    vim.cmd("startinsert")
  end
end

M.modal_buf = nil
M.modal_win = nil
M.original_terminal_cmd = ""

local function extract_command_from_prompt_line(line)
  if not line or line == "" then
    return ""
  end
  -- Match after ╰$ or ╰ $ or $ or % or # or ❯
  local cmd = line:match("╰%s*%$%s*(.*)$")
    or line:match(".*╰%s*%$%s*(.*)$")
    or line:match(".*%s+[%$#%%❯]%s+(.*)$")
    or line:match("^[%$#%%❯]%s+(.*)$")
  if cmd then
    return (cmd:gsub("%s+$", ""))
  end
  return ""
end

function M.get_current_prompt_text()
  if not M.term_buf or not vim.api.nvim_buf_is_valid(M.term_buf) then
    return ""
  end
  if not M.term_win or not vim.api.nvim_win_is_valid(M.term_win) then
    return ""
  end

  local total_lines = vim.api.nvim_buf_line_count(M.term_buf)

  -- 1. Find the true last non-empty line in the buffer (skip grid empty padding)
  local last_line_idx = total_lines
  while last_line_idx > 0 do
    local l = vim.api.nvim_buf_get_lines(M.term_buf, last_line_idx - 1, last_line_idx, false)[1]
    if l and l:match("%S") then
      break
    end
    last_line_idx = last_line_idx - 1
  end

  if last_line_idx == 0 then
    return ""
  end

  -- 2. From last_line_idx upwards, find the active shell prompt line
  local prompt_row = nil
  for r = last_line_idx, 1, -1 do
    local l = vim.api.nvim_buf_get_lines(M.term_buf, r - 1, r, false)[1]
    if l and (l:match("╰%s*%$") or l:match("^[%$#%%❯]%s") or l:match(".*%s+[%$#%%❯]%s")) then
      prompt_row = r
      break
    end
  end

  if not prompt_row then
    prompt_row = last_line_idx
  end

  local first_line = vim.api.nvim_buf_get_lines(M.term_buf, prompt_row - 1, prompt_row, false)[1] or ""
  local cmd_start = extract_command_from_prompt_line(first_line)
  local full_cmd = cmd_start or ""

  -- 3. If command spans multiple lines down to last_line_idx, collect them
  for r = prompt_row + 1, last_line_idx do
    local l = vim.api.nvim_buf_get_lines(M.term_buf, r - 1, r, false)[1]
    if l and l:match("%S") then
      local trimmed = (l:gsub("%s+$", ""))
      local cont = trimmed:match("^[%w%s]*>%s*(.*)$")
      if cont then
        full_cmd = full_cmd .. "\n" .. cont
      else
        -- Terminal column soft-wrap: directly concatenate without newline
        full_cmd = full_cmd .. trimmed
      end
    end
  end

  return full_cmd
end

function M.open_command_modal()
  if M.modal_win and vim.api.nvim_win_is_valid(M.modal_win) then
    vim.api.nvim_set_current_win(M.modal_win)
    return
  end

  local initial_text = M.get_current_prompt_text()
  M.original_terminal_cmd = initial_text

  -- Clear the current command line on terminal
  if M.term_chan then
    vim.api.nvim_chan_send(M.term_chan, "\x15")
  end

  -- Create modal buffer
  M.modal_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[M.modal_buf].buftype = "nofile"
  vim.bo[M.modal_buf].bufhidden = "wipe"
  vim.bo[M.modal_buf].swapfile = false
  vim.bo[M.modal_buf].filetype = "zsh"

  local initial_lines = { "" }
  if initial_text and initial_text ~= "" then
    initial_lines = vim.split(initial_text, "\n")
  end
  vim.api.nvim_buf_set_lines(M.modal_buf, 0, -1, false, initial_lines)

  local width = math.min(100, math.max(60, math.floor(vim.o.columns * 0.85)))
  local height = math.min(math.floor(vim.o.lines * 0.6), math.max(6, #initial_lines + 2))
  local row = math.max(1, math.floor((vim.o.lines - height) / 2) - 1)
  local col = math.max(0, math.floor((vim.o.columns - width) / 2))

  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " [ Command Editor ] ",
    title_pos = "center",
    footer = " <C-s> / <C-CR> Apply  |  <C-w> Cancel ",
    footer_pos = "right",
  }

  M.modal_win = vim.api.nvim_open_win(M.modal_buf, true, win_opts)

  vim.wo[M.modal_win].number = true
  vim.wo[M.modal_win].relativenumber = true
  vim.wo[M.modal_win].numberwidth = 3
  vim.wo[M.modal_win].signcolumn = "no"
  vim.wo[M.modal_win].winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,FloatTitle:Title,FloatFooter:Comment"

  -- Keymaps inside modal
  vim.keymap.set({ "n", "i" }, "<C-s>", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set({ "n", "i" }, "<C-CR>", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set({ "n", "i" }, "<C-Enter>", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set({ "n", "i" }, "\x1b[13;5u", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set({ "n", "i" }, "<M-CR>", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set({ "n", "i" }, "<A-CR>", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set({ "n", "i" }, "<C-w>", function() M.close_command_modal(false) end, { buffer = M.modal_buf, desc = "Cancel command editor" })
  vim.keymap.set({ "n", "i" }, "<C-p>", function() require("saved_commands.picker").open_picker() end, { buffer = M.modal_buf, desc = "Saved commands picker" })
  vim.keymap.set("n", "ZZ", M.submit_command_modal, { buffer = M.modal_buf, desc = "Submit command" })
  vim.keymap.set("n", "ZQ", function() M.close_command_modal(true) end, { buffer = M.modal_buf, desc = "Cancel command editor (force)" })

  -- User commands inside modal
  vim.api.nvim_buf_create_user_command(M.modal_buf, "Wq", M.submit_command_modal, {})
  vim.api.nvim_buf_create_user_command(M.modal_buf, "W", M.submit_command_modal, {})
  vim.api.nvim_buf_create_user_command(M.modal_buf, "Q", function(opts) M.close_command_modal(opts.bang) end, { bang = true })

  -- Auto-resize modal window as lines are added/removed
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    buffer = M.modal_buf,
    callback = function()
      if not M.modal_win or not vim.api.nvim_win_is_valid(M.modal_win) then
        return
      end
      local lc = vim.api.nvim_buf_line_count(M.modal_buf)
      local target_h = math.min(math.floor(vim.o.lines * 0.7), math.max(6, lc + 2))
      if vim.api.nvim_win_get_height(M.modal_win) ~= target_h then
        local new_row = math.max(1, math.floor((vim.o.lines - target_h) / 2) - 1)
        vim.api.nvim_win_set_config(M.modal_win, {
          height = target_h,
          row = new_row,
        })
      end
    end,
  })

  -- Position cursor at the end and enter insert mode
  local last_line_idx = #initial_lines
  local last_line_len = #initial_lines[last_line_idx]
  vim.api.nvim_win_set_cursor(M.modal_win, { last_line_idx, last_line_len })
  vim.cmd("startinsert!")
end

function M.submit_command_modal()
  if not M.modal_buf or not vim.api.nvim_buf_is_valid(M.modal_buf) then
    return
  end

  pcall(function() require("saved_commands.template").clear() end)

  local raw_lines = vim.api.nvim_buf_get_lines(M.modal_buf, 0, -1, false)
  local cmd = sanitize_command(raw_lines)

  if M.modal_win and vim.api.nvim_win_is_valid(M.modal_win) then
    vim.api.nvim_win_close(M.modal_win, true)
    M.modal_win = nil
    M.modal_buf = nil
  end

  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_set_current_win(M.term_win)
  end

  if M.term_chan then
    -- Clean whatever is currently on the terminal prompt line
    vim.api.nvim_chan_send(M.term_chan, "\x15")
    -- Exactly replace terminal prompt with command (no \n, so does NOT run immediately)
    if cmd and cmd:match("%S") then
      vim.api.nvim_chan_send(M.term_chan, cmd)
    end
  end

  M.original_terminal_cmd = ""
  vim.cmd("startinsert")
end

function M.close_command_modal(force)
  if not M.modal_buf or not vim.api.nvim_buf_is_valid(M.modal_buf) then
    return
  end

  local raw_lines = vim.api.nvim_buf_get_lines(M.modal_buf, 0, -1, false)
  local current_text = vim.trim(table.concat(raw_lines, "\n"))
  local original = vim.trim(M.original_terminal_cmd or "")

  local is_modified = (current_text ~= original and current_text ~= "")

  if not force and is_modified then
    local choice = vim.fn.confirm("Discard changes?", "&Yes\n&No", 2)
    if choice ~= 1 then
      return
    end
  end

  pcall(function() require("saved_commands.template").clear() end)

  if M.modal_win and vim.api.nvim_win_is_valid(M.modal_win) then
    vim.api.nvim_win_close(M.modal_win, true)
    M.modal_win = nil
    M.modal_buf = nil
  end

  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    vim.api.nvim_set_current_win(M.term_win)
  end

  -- Restore previous command to terminal prompt if there was one
  if original and original ~= "" then
    if M.term_chan then
      vim.api.nvim_chan_send(M.term_chan, "\x15")
      vim.api.nvim_chan_send(M.term_chan, original)
    end
  end

  M.original_terminal_cmd = ""
  vim.cmd("startinsert")
end

function M.setup()
  -- Register prompt highlight groups
  setup_highlights()
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = setup_highlights,
  })

  -- 1. Full-screen terminal window (takes 100% of screen)
  vim.cmd("terminal")
  M.term_buf = vim.api.nvim_get_current_buf()
  M.term_win = vim.api.nvim_get_current_win()
  M.term_chan = vim.bo[M.term_buf].channel

  -- Terminal window styling: clean native terminal
  vim.wo[M.term_win].number = false
  vim.wo[M.term_win].relativenumber = false
  vim.wo[M.term_win].signcolumn = "no"
  vim.wo[M.term_win].statusline = " "
  vim.wo[M.term_win].winbar = ""

  -- Start in terminal mode directly
  vim.cmd("startinsert")
end

return M
