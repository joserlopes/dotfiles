return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa-paper").setup({
				overrides = function(colors)
					return {
						["@comment.documentation"] = { fg = colors.palette.waveAqua2, italic = true },
						["@comment"] = { fg = colors.palette.canvasAsh1, italic = true },
					}
				end,
			})
		vim.cmd.colorscheme("kanagawa-paper")
		end,
	},

}

