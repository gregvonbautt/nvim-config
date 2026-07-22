vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cmdheight = 0

vim.opt.updatetime = 300


vim.diagnostic.config({
  virtual_text = false,
  float = { border = "rounded" },
})
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

vim.opt.fillchars:append({ diff = "░", eob = " " })

vim.opt.list = false
vim.opt.listchars = { tab = "→ ", space = "·", trail = "●", eol = "↩" }


require("bootstrap")

-- Clear search highlight on Esc
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Close current buffer with <Leader> + x
vim.keymap.set("n", "<Leader>x", ":bd<CR>", { silent = true, desc = "Close buffer" })

-- Toggle whitespace visibility
vim.keymap.set("n", "<Leader>tw", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle whitespace visibility" })

-- LSP keymaps (set when a server attaches)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end
    map("gd", function() require("telescope.builtin").lsp_definitions() end, "Go to definition")
    map("gr", function() require("telescope.builtin").lsp_references() end, "Find references")
    map("gD", function() require("telescope.builtin").lsp_type_definitions() end, "Go to type definition")
    map("gi", function() require("telescope.builtin").lsp_implementations() end, "Go to implementation")
    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, "Find symbols")
    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("<leader>fd", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, "File diagnostics")
    map("<leader>fD", function() require("telescope.builtin").diagnostics() end, "Workspace diagnostics")
  end,
})

-- LSP server configurations (native Neovim 0.11+ API)
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config("pyright", {
  cmd = { mason_bin .. "/pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyrightconfig.json", "setup.py", "setup.cfg", "pyproject.toml", ".git" },
})

vim.lsp.config("ts_ls", {
  cmd = { mason_bin .. "/typescript-language-server", "--stdio" },
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  root_markers = { "tsconfig.json", "package.json", ".git" },
})

vim.lsp.config("lua_ls", {
  cmd = { mason_bin .. "/lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
})


vim.lsp.enable({ "pyright", "ts_ls", "lua_ls" })
