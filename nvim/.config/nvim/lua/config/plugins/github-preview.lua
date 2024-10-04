return {
	"wallpants/github-preview.nvim",
	opts = {
		cursor_line = {
			disable = true,
		},
	},

	config = function(_, opts)
		local gpreview = require("github-preview")
		gpreview.setup(opts)

		local fns = gpreview.fns
		vim.keymap.set("n", "<leader>gpt", fns.toggle, { desc = "[G]ithub [P]review [T]oggle" })
		vim.keymap.set("n", "<leader>gps", fns.single_file_toggle, { desc = "[G]ithub [P]review [S]ingle" })
		vim.keymap.set("n", "<leader>gpd", fns.details_tags_toggle, { desc = "[G]ithub [P]review [D]details" })
	end,
}
