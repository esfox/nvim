local helpers = {}

function helpers.is_pc()
  return vim.env.HOME == '/home/esfox'
end

return helpers
