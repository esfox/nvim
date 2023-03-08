local helpers = {}

function helpers.is_pc()
  local cwd = vim.fn.getcwd()
  local is_pc = '/home/esfox'
  return string.sub(cwd, 1, string.len(is_pc)) == is_pc
end

return helpers
