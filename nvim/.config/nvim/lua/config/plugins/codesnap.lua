return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	keys = {
		{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
		{ "<leader>cp", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
	},
	opts = {
		save_path = "~/Pictures",
		mac_window_bar = false,
		has_breadcrumbs = true,
		border = "rounded",
		bg_theme = "grape",
		watermark = "",
		has_line_number = true,
	},
}
