local Popup = require("nui.popup")

local M = {}

--- Show a consistent, floating confirmation popup modal.
--- @param opts { title?: string, prompt?: string, warning?: string, on_confirm: fun(), on_cancel?: fun() }
function M.show_confirm(opts)
  opts = opts or {}
  local title = opts.title or "Confirm"
  local prompt = opts.prompt or "Are you sure?"
  local warning = opts.warning

  local lines = { "" }
  if warning and warning ~= "" then
    table.insert(lines, "   " .. warning)
    table.insert(lines, "")
  end
  table.insert(lines, "   " .. prompt)
  table.insert(lines, "")
  table.insert(lines, "         [y]es  /  [n]o (<Esc>)")
  table.insert(lines, "")

  local height = #lines
  local width = math.max(46, #prompt + 12)
  if warning and #warning + 12 > width then
    width = #warning + 12
  end
  width = math.min(width, math.floor(vim.o.columns * 0.8))

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = string.format(" [ %s ] ", title),
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = width,
      height = height,
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

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
  vim.bo[popup.bufnr].modifiable = false

  local ns = vim.api.nvim_create_namespace("modal_confirm")
  if warning and warning ~= "" then
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "WarningMsg", 1, 0, -1)
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Title", 3, 0, -1)
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Special", 5, 9, 14)
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Comment", 5, 19, 31)
  else
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "WarningMsg", 1, 0, -1)
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Special", 3, 9, 14)
    vim.api.nvim_buf_add_highlight(popup.bufnr, ns, "Comment", 3, 19, 31)
  end

  local closed = false
  local function close()
    if closed then
      return
    end
    closed = true
    popup:unmount()
    if opts.on_cancel then
      opts.on_cancel()
    end
  end

  local function confirm()
    if closed then
      return
    end
    closed = true
    popup:unmount()
    if opts.on_confirm then
      opts.on_confirm()
    end
  end

  local modes = { "n", "i" }
  for _, m in ipairs(modes) do
    popup:map(m, "y", confirm, { noremap = true, silent = true })
    popup:map(m, "Y", confirm, { noremap = true, silent = true })
    popup:map(m, "<CR>", confirm, { noremap = true, silent = true })

    popup:map(m, "n", close, { noremap = true, silent = true })
    popup:map(m, "N", close, { noremap = true, silent = true })
    popup:map(m, "<Esc>", close, { noremap = true, silent = true })
    popup:map(m, "q", close, { noremap = true, silent = true })
  end

  popup:on("BufLeave", function()
    pcall(function()
      if not closed then
        close()
      end
    end)
  end, { once = true })
end

return M
