-- Enable word wrapping
vim.opt_local.wrap = true

-- Break lines at word boundaries
vim.opt_local.linebreak = true

-- Enable automatic text formatting
vim.opt_local.formatoptions:append("t")
vim.opt_local.formatoptions:append("w")
vim.opt_local.formatoptions:append("j")

-- Create an autocommand to update textwidth based on window width
local augroup = vim.api.nvim_create_augroup("TypstDynamicTextWidth", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter", "WinEnter" }, {
	group = augroup,
	buffer = 0, -- Only for the current buffer
	callback = function()
		-- Get the current window width
		local win_width = vim.api.nvim_win_get_width(0)
		-- Set textwidth to window width (minus a small margin)
		vim.opt_local.textwidth = win_width - 2
	end,
})

-- Trigger the autocommand immediately to set initial textwidth
vim.cmd("doautocmd TypstDynamicTextWidth BufEnter")
