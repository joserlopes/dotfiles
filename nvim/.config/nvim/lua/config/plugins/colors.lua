return {
	{
		"RRethy/base16-nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function() end,
	},

	{
		"thesimonho/kanagawa-paper.nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			require("kanagawa-paper").setup({
				-- transparent = true,
				styles = {
					functions = { italic = true },
					keyword = { italic = true },
				},
			})
		end,
	},

	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local everforest = require("everforest")
			everforest.setup({
				background = "hard",
				-- This is for enabling transparent background
				-- transparent_background_level = 2,
				italics = true,
			})
		end,
	},
}
