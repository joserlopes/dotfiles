return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	event = "BufReadPre",

	config = function()
		require("neogen").setup({
			enabled = true,
			snippet_engine = "luasnip",
		})
	end,

	keys = {
		{
			"<leader>cg",
			function()
				require("neogen").generate({})
			end,
			desc = "Generate annotation comments",
		},
	},
}
