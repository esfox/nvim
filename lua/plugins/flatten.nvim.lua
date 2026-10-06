return {
  "willothy/flatten.nvim",
  lazy = false,
  priority = 1001,
  opts = function()
    local layout = require("layout")

    return {
      window = {
        open = function(ctx)
          local target = ctx.stdin_buf or (ctx.files and ctx.files[1])

          local all_files = {}
          if ctx.stdin_buf then
            table.insert(all_files, ctx.stdin_buf)
          end
          if ctx.files then
            for _, f in ipairs(ctx.files) do
              table.insert(all_files, f)
            end
          end

          if not target then
            -- When nvim has no args: create a new empty unnamed buffer
            local new_buf = vim.api.nvim_create_buf(true, false)
            vim.bo[new_buf].buflisted = true
            vim.bo[new_buf].bufhidden = ""
            target = { bufnr = new_buf }
            table.insert(all_files, target)
          end

          local sentinel_buf = vim.api.nvim_create_buf(true, false)
          vim.bo[sentinel_buf].buftype = "nofile"
          vim.bo[sentinel_buf].bufhidden = "wipe"

          local guest_pipe = ctx.data and ctx.data.pipe
          layout.start_edit_session(target.bufnr, all_files, guest_pipe)

          return sentinel_buf, layout.term_win
        end,
      },
      block_for = {
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
      },
      hooks = {
        should_block = function(_)
          return true
        end,
        guest_data = function()
          return { pipe = vim.v.servername }
        end,
        no_files = function(_)
          -- When user runs `nvim` with no args: open a new empty buffer in host
          local new_buf = vim.api.nvim_create_buf(true, false)
          vim.bo[new_buf].buflisted = true
          vim.bo[new_buf].bufhidden = ""
          layout.start_edit_session(new_buf, { { bufnr = new_buf } }, nil)
          return { nest = false, block = false }
        end,
        block_end = function(_)
          -- edit session lifecycle handled completely by layout.lua
        end,
      },
    }
  end,
}
