local helpers = {}

function helpers.is_laptop()
  return vim.loop.os_gethostname() == 'ckftm-laptop'
end

return helpers
