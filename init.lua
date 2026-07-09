vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cmdheight = 0

vim.opt.fillchars:append({ diff = "░", eob = " " })

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", space = "·", trail = "●", eol = "↩" }


require("bootstrap")

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
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "Find references")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("gy", vim.lsp.buf.type_definition, "Go to type definition")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, "Find symbols")
    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
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

vim.lsp.config("jdtls", {
  cmd = { mason_bin .. "/jdtls" },
  filetypes = { "java" },
  root_markers = { ".bemol", "build.gradle", "pom.xml", ".git" },
})

vim.lsp.enable({ "pyright", "ts_ls", "lua_ls", "jdtls" })
