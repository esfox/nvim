local M = {}

--- Checks whether a template string has placeholders {name} or {name:default}
--- @param raw string
--- @return boolean
function M.has_placeholders(raw)
  if not raw then
    return false
  end
  return raw:match("{[%w_]+[:}]") ~= nil or raw:match("{[%w_]+}") ~= nil
end

--- Parse template string and render with "{{param}}" strings
--- e.g. docker exec -it {container:web} {cmd:sh} -> docker exec -it "{{container:web}}" "{{cmd:sh}}"
--- Handles already-quoted placeholders without producing double-quotes:
--- 'git commit -m "{message:foo}"' -> 'git commit -m "{{message:foo}}"'
--- @param raw string
--- @return string rendered_text
function M.parse_template(raw)
  local rendered = ""
  local last_pos = 1

  while true do
    local s, e, var_name, has_colon, default_val = raw:find("{([%w_]+)(:?)(.-)}", last_pos)
    if not s then
      rendered = rendered .. raw:sub(last_pos)
      break
    end

    local prefix = raw:sub(last_pos, s - 1)
    local token_inner = var_name
    if has_colon == ":" and default_val and default_val ~= "" then
      token_inner = var_name .. ":" .. default_val
    end

    -- Check if prefix ends with quote " and character after is quote "
    local has_leading_quote = prefix:sub(-1) == '"'
    local has_trailing_quote = raw:sub(e + 1, e + 1) == '"'

    if has_leading_quote and has_trailing_quote then
      -- Already wrapped in quotes: replace without extra surrounding quotes
      rendered = rendered .. prefix .. string.format("{{%s}}", token_inner) .. '"'
      last_pos = e + 2 -- skip trailing quote as well
    else
      rendered = rendered .. prefix .. string.format('"{{%s}}"', token_inner)
      last_pos = e + 1
    end
  end

  return rendered
end

--- Clear any placeholder state (no-op now)
function M.clear()
end

--- Apply template to a buffer: outputs rendered string and places cursor ready for manual editing
--- @param bufnr number
--- @param raw_template string
function M.apply_template(bufnr, raw_template)
  local rendered_text = M.parse_template(raw_template)
  local lines = vim.split(rendered_text, "\n")
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

  local win = vim.fn.bufwinid(bufnr)
  if win ~= -1 and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
    -- Position cursor at the first "{{
    local row = 1
    local col = 0
    for i, line in ipairs(lines) do
      local s = line:find('"{{') or line:find("{{")
      if s then
        row = i
        col = s - 1
        break
      end
    end
    vim.api.nvim_win_set_cursor(win, { row, col })
    vim.cmd("stopinsert")
  end
end

return M
