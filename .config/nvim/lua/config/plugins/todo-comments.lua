return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>", { desc = "TodoTelescope", silent = true }),
	},
	config = true,
}
