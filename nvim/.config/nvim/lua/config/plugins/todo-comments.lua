return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		vim.keymap.set("n", "<leader>ftd", "<cmd>TodoFzfLua<cr>", { desc = "Find Todos", silent = true }),
		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" }),

		vim.keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" }),

		-- SAFETY:
		keywords = {
			SAFETY = { icon = "🔒", color = "safety" },
		},

		colors = {
			safety = { "#FFB347" },
		},
	},
}
