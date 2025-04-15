return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
	},
	config = true,
	keys = {
		{
			"<leader>gg",
			function()
				require("neogit").open()
			end,
			desc = "Neogit",
			silent = true,
		},
	},
}
