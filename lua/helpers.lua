local status, paths_specs_module = pcall(require, "paths-specs")
local paths_specs = {}
if status then
  paths_specs = paths_specs_module
end

local helpers = {}

function helpers.is_laptop()
  return vim.loop.os_gethostname() == "ckftm-laptop"
end

function helpers.is_wide()
  return vim.go.columns > 150
end

function helpers.is_noautocmd_write_path()
  for _, dir in ipairs(paths_specs.noautocmd_write_paths) do
    if vim.fn.getcwd() == dir then
      return true
    end
  end

  return false
end

return helpers
