local M = {}

M.CONFIG_FILE = vim.fn.stdpath("config") .. "/saved-commands.json"

--- Load all saved commands from JSON storage
--- @return table[]
function M.load_commands()
  local f = io.open(M.CONFIG_FILE, "r")
  if not f then
    return {}
  end
  local content = f:read("*a")
  f:close()

  local ok, data = pcall(vim.json.decode, content)
  if not ok or type(data) ~= "table" then
    return {}
  end
  return data
end

--- Save or update command entry in storage
--- @param new_cmd table
--- @param original_name? string if updating an existing entry
--- @return boolean success, string? err
function M.save_command(new_cmd, original_name)
  local list = M.load_commands()

  local replaced = false
  if original_name and original_name ~= "" then
    for i, cmd in ipairs(list) do
      if cmd.name == original_name then
        list[i] = new_cmd
        replaced = true
        break
      end
    end
  end

  if not replaced then
    table.insert(list, new_cmd)
  end

  local out_file, err = io.open(M.CONFIG_FILE, "w")
  if not out_file then
    return false, err or ("Cannot write to " .. M.CONFIG_FILE)
  end

  local ok_enc, encoded = pcall(vim.json.encode, list)
  if not ok_enc then
    out_file:close()
    return false, "JSON encoding error"
  end

  out_file:write(encoded)
  out_file:close()

  -- Format file cleanly with jq if available
  if vim.fn.executable("jq") == 1 then
    vim.fn.system(string.format("jq . %s > %s.tmp && mv %s.tmp %s", M.CONFIG_FILE, M.CONFIG_FILE, M.CONFIG_FILE, M.CONFIG_FILE))
  end

  return true, nil
end

--- Detect current shell and return appropriate buffer filetype
--- @return string
function M.get_shell_filetype()
  local shell = vim.o.shell or vim.env.SHELL or "sh"
  local bin = shell:match("([^/]+)$") or shell
  if bin == "zsh" then
    return "zsh"
  elseif bin == "bash" then
    return "bash"
  elseif bin == "fish" then
    return "fish"
  end
  return "sh"
end

return M
