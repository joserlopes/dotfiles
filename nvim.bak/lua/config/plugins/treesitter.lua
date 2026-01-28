return {
	{

		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
	},

	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-modules").setup({
				ensure_installed = {
					"c",
					"lua",
					"rust",
					"gleam",
					"zig",
					"go",
					"query",
					"vim",
					"vimdoc",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
