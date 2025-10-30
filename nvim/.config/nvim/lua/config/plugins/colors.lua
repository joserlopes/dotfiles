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
				transparent = true,
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
		"f4z3r/gruvbox-material.nvim",
		name = "gruvbox-material",
		lazy = false,
		priority = 1000,
		opts = {
			contrast = "soft",
		},
	},

	{
		"ribru17/bamboo.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup({})
			require("bamboo").load()
		end,
	},
	{
		"everviolet/nvim",
		name = "evergarden",
		priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
		opts = {
			theme = {
				variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
				-- accent = "green",
			},
			editor = {
				transparent_background = true,
				-- sign = { color = "none" },
				-- float = {
				-- 	color = "mantle",
				-- 	solid_border = false,
				-- },
				-- completion = {
				-- 	color = "surface0",
				-- },
			},
		},
	},
}
