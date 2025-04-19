-- strikethrough, bold and italic shortcuts
vim.keymap.set("v", "<leader>s", 'c~~<c-r>"~~')
vim.keymap.set("v", "<leader>b", 'c**<c-r>"**')
vim.keymap.set("v", "<leader>i", 'c_<c-r>"_')

vim.keymap.set("n", "<leader>s", 'viwc~~<c-r>"~~<esc>')
vim.keymap.set("n", "<leader>b", 'viwc**<c-r>"**<esc>')
vim.keymap.set("n", "<leader>i", 'viwc_<c-r>"_<esc>')

-- wrap in backticks
vim.keymap.set("v", "<leader>`", 'c`<c-r>"`')

vim.keymap.set("n", "<leader>`", 'viwc`<c-r>"`<esc>')
