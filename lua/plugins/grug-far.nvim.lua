return {
  "MagicDuck/grug-far.nvim",
  version = "1.6.3",
  config = function()
    require("grug-far").setup({
      openTargetWindow = { preferredLocation = "above" },
      keymaps = {
        toggleShowCommand = { n = "" },
      },
      windowCreationCommand = "split",
      helpLine = {
        enabled = false,
      },
      disableBufferLineNumbers = false,
      transient = true,
      prefills = {
        flags = "--ignore-case",
      },
    })

    vim.keymap.set("n", "<leader>lg", function()
      vim.cmd("bo GrugFar")

      -- vim.api.nvim_create_autocmd("FileType", {
      --   group = vim.api.nvim_create_augroup("grug-far-keybindings", { clear = true }),
      --   pattern = { "*Grug FAR*" },
      --   -- pattern = { "grug-far" },
      --   callback = function()
      --     vim.keymap.set("n", "<leader>j", function()
      --       vim.notify("hi")
      --       -- require("grug-far").get_instance(0):open_location()
      --       -- require("grug-far").get_instance(0):close()
      --     end, { buffer = true })
      --   end,
      -- })
    end)
  end,
}
