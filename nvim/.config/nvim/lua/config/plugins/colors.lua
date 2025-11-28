return {
	-- {
	-- 	"wincent/base16-nvim",
	-- 	lazy = false, -- load at start
	-- 	priority = 1000, -- load first
	-- },

	{
		"neanias/everforest-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local everforest = require("everforest")
			everforest.setup({
				background = "hard",
				-- This is for enabling transparent background
				transparent_background_level = 1,
				italics = true,

				on_highlights = function(hl, palette)
					hl["@comment.documentation.rust"] = { fg = palette.aqua, italic = true }
					hl["@lsp.type.comment.rust"] = { fg = palette.aqua, italic = true }
					hl.TSComment = { fg = "#928374", italic = true }
				end,
			})
		end,
	},

	{
		"vague-theme/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			require("vague").setup({
				on_highlights = function(hl)
					hl["@comment.documentation.rust"] = { fg = "#35a77c", italic = true }
					hl["@lsp.type.comment.rust"] = { fg = "#35a77c", italic = true }
					hl.Comment = { fg = "#928374", italic = true }
				end,
			})
		end,
	},
}
