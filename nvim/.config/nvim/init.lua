require("config.core")
require("config.lazy")

require("todo_float").setup({
	filename = "todo.md",
	global_file = "~/Notes/todo.md",
})

require("notes_float").setup({
	filename = "notes.md",
	global_file = "~/Notes/notes.md",
})

vim.cmd.colorscheme("everforest")
-- vim.cmd("colorscheme vague")

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
