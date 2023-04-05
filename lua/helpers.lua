local helpers = {}

function helpers.is_laptop()
  return vim.env.HOSTNAME == 'ckftm-laptop'
end

return helpers
