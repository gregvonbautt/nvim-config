vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.termguicolors = true
vim.opt.number = true

vim.opt.fillchars:append({ diff = "░" })

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", space = "·", trail = "●", eol = "↩" }


require("bootstrap")

-- Close current buffer with <Leader> + x
vim.keymap.set("n", "<Leader>x", ":bd<CR>", { silent = true, desc = "Close buffer" })

-- Toggle whitespace visibility
vim.keymap.set("n", "<Leader>tw", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle whitespace visibility" })
