vim.keymap.set("n", "<Leader>of", function()
	vim.ui.open(vim.fn.expand("%"))
end, { desc = "[O]pen [F]ile in browser" })
vim.opt_local.shiftwidth = 2
