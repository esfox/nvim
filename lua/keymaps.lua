local helpers = require("helpers")

local keymaps = {}

function keymaps.general()
  vim.keymap.set({ "i", "c" }, "jk", "<Esc>")
  vim.keymap.set({ "i", "c" }, "JK", "<Esc>")
  vim.keymap.set({ "n", "v" }, "J", "10j")
  vim.keymap.set({ "n", "v" }, "K", "10k")
  vim.keymap.set({ "", "i" }, "<PageDown>", "<c-d>")
  vim.keymap.set({ "", "i" }, "<PageUp>", "<c-u>")
  vim.keymap.set({ "", "v" }, "H", "^")
  vim.keymap.set({ "", "v" }, "L", "$")
  vim.keymap.set("n", "U", "<c-r>")
  vim.keymap.set("n", "<leader><cr>", "<CR>")
  vim.keymap.set("n", "<c-enter>", "<Enter>:cclose<CR>")
  vim.keymap.set("n", "<Enter>", "o<Esc>")
  vim.keymap.set("i", "<c-bs>", "<c-w>")
  -- vim.keymap.set('n', 'p', 'pgvy')
  vim.keymap.set("v", "p", '"_dP')

  vim.keymap.set("v", "ii", "<Esc>i")
  vim.keymap.set("i", "vv", "<Esc>lv")
  vim.keymap.set("n", "<leader>v", "<c-v>")

  vim.keymap.set("n", "<c-v>", "p")
  vim.keymap.set("i", "<c-v>", "<Esc>pa")
  vim.keymap.set("c", "<c-v>", "<c-r>+")
  vim.keymap.set({ "", "i" }, "<c-a>", "<Esc>ggVG")
  vim.keymap.set("", "<c-s>", ":update<CR>")
  vim.keymap.set("i", "<c-s>", "<Esc>:update<CR>a")
  vim.keymap.set("", "<c-m-s>", ":NoAutocmdSave<CR>")
  vim.keymap.set("i", "<c-m-s>", "<Esc>:NoAutocmdSave<CR>a")
  vim.keymap.set({ "n", "i" }, "<c-l>", "<tab>")
  vim.keymap.set({ "n", "i" }, "<c-h>", "<c-o>")
  -- vim.keymap.set("i", "<c-bs>", "<c-w>")
  -- vim.keymap.set("i", "<c-bs>", "<esc>dbi")

  -- vim.keymap.set({ "n", "i" }, "<c-j>", "<tab>")
  -- vim.keymap.set({ "n", "i" }, "<c-k>", "<c-o>")

  -- window management
  vim.keymap.set("n", "<leader>wh", "<c-w>h")
  vim.keymap.set("n", "<leader>wj", "<c-w>j")
  vim.keymap.set("n", "<leader>wk", "<c-w>k")
  vim.keymap.set("n", "<leader>wl", "<c-w>l")
  vim.keymap.set("n", "<leader>wm", "<c-w>_")
  vim.keymap.set("n", "<leader>wH", "<c-w>H")
  vim.keymap.set("n", "<leader>wJ", "<c-w>J")
  vim.keymap.set("n", "<leader>wK", "<c-w>K")
  vim.keymap.set("n", "<leader>wL", "<c-w>L")
  vim.keymap.set("n", "<leader>wV", "<c-w><c-v>")
  vim.keymap.set("n", "<leader>wS", "<c-w><c-s>")
  vim.keymap.set("n", "<leader>q", ":q!<cr>")
  vim.keymap.set("n", "<leader>qa", ":qa<cr>")
  vim.keymap.set("n", "<leader>qA", ":qa!<cr>")
  vim.keymap.set("n", "<leader>qb", ":bd!<cr>")
  vim.keymap.set("n", "<leader>fp", function()
    local filepath = vim.fn.expand("%")
    print("Filepath: " .. filepath)
    vim.fn.getchar()
  end)

  vim.keymap.set("n", "<leader>fc", function()
    local filepath = vim.fn.expand("%")
    os.execute("echo " .. filepath .. "| xclip -sel clipboard")
    print("Copied current file path (" .. filepath .. ")")
    vim.fn.getchar()
  end)

  vim.keymap.set("n", "<leader>fC", function()
    local filepath = vim.fn.expand("%:p")
    os.execute("echo " .. filepath .. "| xclip -sel clipboard")
    print("Copied current absolute file path (" .. filepath .. ")")
    vim.fn.getchar()
  end)

  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Diagnostic keymaps
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
end

function keymaps.for_plugins()
  -- Nvim-tree
  vim.keymap.set("n", "<leader>E", function()
    nvim_tree_keep_open = not nvim_tree_keep_open
    if nvim_tree_keep_open then
      vim.cmd("NvimTreeOpen")
    else
      vim.cmd("NvimTreeClose")
    end
  end)

  vim.keymap.set({ "", "i" }, "<c-e>", function()
    if nvim_tree_keep_open then
      vim.cmd("NvimTreeFocus")
    else
      vim.cmd("NvimTreeToggle")
    end
  end)

  vim.keymap.set("", "<leader>e", "<cmd>NvimTreeFindFile<CR>")

  -- Barbar
  local barbar_keymap_options = { silent = true, noremap = true }
  vim.keymap.set({ "", "i" }, "<c-w>", "<Cmd>BufferClose<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-w>", "<Cmd>BufferClose<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-left>", "<Cmd>BufferPrevious<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-right>", "<Cmd>BufferNext<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-h>", "<Cmd>BufferPrevious<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-l>", "<Cmd>BufferNext<CR>", barbar_keymap_options)
  -- vim.keymap.set({ "", "i" }, "<c-h>", "<Cmd>BufferPrevious<CR>", barbar_keymap_options)
  -- vim.keymap.set({ "", "i" }, "<c-l>", "<Cmd>BufferNext<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-s-left>", "<Cmd>BufferMovePrevious<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-s-right>", "<Cmd>BufferMoveNext<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-1>", "<Cmd>BufferGoto 1<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-2>", "<Cmd>BufferGoto 2<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-3>", "<Cmd>BufferGoto 3<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-4>", "<Cmd>BufferGoto 4<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-5>", "<Cmd>BufferGoto 5<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-6>", "<Cmd>BufferGoto 6<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-7>", "<Cmd>BufferGoto 7<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-8>", "<Cmd>BufferGoto 8<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<a-9>", "<Cmd>BufferGoto 9<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-1>", "<Cmd>BufferGoto 1<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-2>", "<Cmd>BufferGoto 2<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-3>", "<Cmd>BufferGoto 3<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-4>", "<Cmd>BufferGoto 4<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-5>", "<Cmd>BufferGoto 5<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-6>", "<Cmd>BufferGoto 6<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-7>", "<Cmd>BufferGoto 7<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-8>", "<Cmd>BufferGoto 8<CR>", barbar_keymap_options)
  vim.keymap.set({ "", "i" }, "<c-9>", "<Cmd>BufferGoto 9<CR>", barbar_keymap_options)
  -- vim.keymap.set("n", "<leader>b", "<Cmd>BufferPick<CR>", barbar_keymap_options)

  -- Hop
  local hop = require("hop")
  vim.keymap.set("", "m", function()
    hop.hint_words()
  end, { remap = true })

  vim.keymap.set("", "M", function()
    hop.hint_char1()
  end, { remap = true })

  --- LSP commands
  vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>")

  -- Navbuddy
  vim.keymap.set("n", "<leader>ns", "<cmd>Navbuddy<CR>")

  -- Comment
  local comment = require("Comment.api")
  vim.keymap.set("n", "gc", comment.call("toggle.linewise", "g@"), { expr = true })
  vim.keymap.set({ "n", "i" }, "<c-/>", comment.toggle.linewise.current)
  vim.keymap.set({ "n", "i" }, "<c-?>", comment.toggle.blockwise.current)

  -- lsp_lines
  vim.keymap.set("", "gE", function()
    require("lsp_lines").toggle()
    local to_enable_virtual_text = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = to_enable_virtual_text })
  end, { desc = "Toggle lsp_lines" })

  -- Formatting
  vim.keymap.set("n", "<leader>fc", "<Cmd>Format<CR>")
  vim.keymap.set("n", "<leader>fe", "<Cmd>EslintFixAll<CR>")
  vim.keymap.set("n", "<leader>fi", "<Cmd>OrganizeImports<CR>")

  -- Treesitter
  vim.keymap.set("n", "<leader>th", "<Cmd>TSHighlightCapturesUnderCursor<CR>")

  -- Trouble
  vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")

  -- TreeSJ
  vim.keymap.set("n", "<leader>js", "<cmd>TSJSplit<CR>")
  vim.keymap.set("n", "<leader>jj", "<cmd>TSJJoin<CR>")

  -- Telescope
  vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(
      require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      })
    )
  end, { desc = "[/] Fuzzily search in current buffer" })

  vim.keymap.set({ "n", "i", "v" }, "<c-p>", function()
    require("telescope.builtin").oldfiles({ cwd_only = true })
  end, { desc = "Find [p]reviously opened files" })

  vim.keymap.set({ "", "i", "v" }, "<c-o>", function()
    require("telescope").extensions.menufacture.find_files({
      previewer = false,
    })
  end, { desc = "Search Files" })

  vim.keymap.set({ "", "i", "v" }, "<c-r>", function()
    require("telescope").extensions.olddirs.picker({
      previewer = false,
      selected_dir_callback = function(dir)
        vim.cmd("bufdo bd")
        vim.cmd.cd(dir)
      end,
      layout_config = {
        width = 0.4,
        height = 0.3,
      },
      path_display = function(_, path)
        local last_directory_pos = (path:reverse()):find("%/")
        return (path:sub(1 - last_directory_pos))
      end,
    })
  end)

  vim.keymap.set(
    { "n", "i" },
    "<leader>gs",
    ":Telescope git_signs<CR>",
    { desc = "Current Buffer Git Status" }
  )

  vim.keymap.set(
    { "n", "i" },
    "<leader>;",
    require("telescope.builtin").commands,
    { desc = "Search Commands" }
  )

  vim.keymap.set(
    "n",
    "<leader>sw",
    require("telescope.builtin").grep_string,
    { desc = "[S]earch current [W]ord" }
  )

  vim.keymap.set(
    "n",
    "<leader>sh",
    require("telescope.builtin").help_tags,
    { desc = "[S]earch [H]elp" }
  )

  vim.keymap.set(
    "n",
    "<leader>sg",
    require("telescope").extensions.menufacture.live_grep,
    { desc = "[S]earch by [G]rep" }
  )

  vim.keymap.set(
    "n",
    "<leader>sd",
    require("telescope.builtin").diagnostics,
    { desc = "[S]earch [D]iagnostics" }
  )

  vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "[S]earch [U]ndo" })
end

function keymaps.for_lsp(buffer_number)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, description)
    if description then
      description = "LSP: " .. description
    end

    vim.keymap.set("n", keys, func, { buffer = buffer_number, desc = description })
  end

  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("gt", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("gh", vim.lsp.buf.hover, "Hover Documentation")
  nmap("gH", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("ge", vim.diagnostic.open_float, "[G]et [E]rrors")
  nmap("gR", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gr", function()
    vim.lsp.buf.rename()
    vim.wait(50)
    vim.api.nvim_input("jk")
  end, "Rename")

  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')

  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

  nmap("<leader>ts", require("telescope.builtin").treesitter, "[T]reesitter [S]ymbols")

  nmap(
    "<leader>ws",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    "[W]orkspace [S]ymbols"
  )
end

function keymaps.for_cmp(cmp)
  local cmp_types = require("cmp.types")

  return {
    ["<C-Space>"] = {
      i = cmp.mapping.complete({}),
    },
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Up>"] = {
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp_types.cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    },
    ["<Down>"] = {
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp_types.cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    },
    ["<PageUp>"] = cmp.mapping.scroll_docs(-5),
    ["<PageDown>"] = cmp.mapping.scroll_docs(5),
  }
end

nvim_tree_keep_open = helpers.is_wide()

function keymaps.for_nvim_tree(buffer_number)
  local hop = require("hop")
  local nvim_tree_api = require("nvim-tree.api")

  if nvim_tree_keep_open then
    vim.keymap.set("n", "<c-e>", "<c-w><c-p>", { buffer = buffer_number, noremap = true })
  else
    vim.keymap.set(
      "n",
      "<c-e>",
      "<cmd>NvimTreeToggle<CR>",
      { buffer = buffer_number, noremap = true }
    )
  end

  vim.keymap.set("n", "H", "0", { buffer = buffer_number, noremap = true })
  vim.keymap.set(
    "n",
    "J",
    "10j",
    { desc = "Go down 10 lines", buffer = buffer_number, noremap = true }
  )
  vim.keymap.set(
    "n",
    "K",
    "10k",
    { desc = "Go up 10 lines", buffer = buffer_number, noremap = true }
  )

  vim.keymap.set(
    "n",
    "m",
    hop.hint_lines,
    { desc = "Hop", buffer = buffer_number, noremap = true, silent = true, nowait = true }
  )

  vim.keymap.set("n", "h", function()
    local node = nvim_tree_api.tree.get_node_under_cursor()
    if node == nil then
      return
    end

    if node.type == "directory" and node.open then
      nvim_tree_api.node.open.edit()
    else
      nvim_tree_api.node.navigate.parent()
    end
  end, {
    desc = "Close if the selected node is an opened folder and go to parent if it is closed",
    buffer = buffer_number,
    noremap = true,
    silent = true,
  })

  vim.keymap.set("n", "<c-enter>", nvim_tree_api.tree.change_root_to_node, {
    desc = "cd into directory",
    buffer = buffer_number,
    noremap = true,
    silent = true,
  })

  vim.keymap.set(
    "n",
    "l",
    nvim_tree_api.node.open.edit,
    { desc = "Open", buffer = buffer_number, noremap = true, silent = true }
  )
end

return keymaps
