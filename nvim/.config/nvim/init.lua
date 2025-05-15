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

-- vim.cmd.colorscheme("kanagawa-dragon")
-- vim.cmd.colorscheme("kanagawa-paper-ink")

vim.cmd.colorscheme("everforest")
