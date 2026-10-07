return {
  "kylechui/nvim-surround",
  opts = {
    surrounds = {
      ["p"] = {
        add = { "{{", "}}" },
        find = "{{.-}}",
        delete = "^({{)().-(}})()$",
        change = {
          target = "^({{)().-(}})()$",
        },
      },
    },
  },
}
