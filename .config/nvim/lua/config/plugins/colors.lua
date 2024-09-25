return {

	{
		"RRethy/base16-nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("base16-everforest")
			-- Different colorschemes
			--vim.cmd.colorscheme("base16-gruvbox-material-dark-soft")
			--vim.cmd.colorscheme("base16-kanagawa")
			--vim.cmd.colorscheme('base16-nord')
			--vim.cmd.colorscheme('base16-zenburn')
			--vim.cmd.colorscheme('base16-rose-pine')
			--vim.cmd.colorscheme("base16-ayu-mirage")
			--vim.cmd.colorscheme("base16-ayu-mirage")
		end,
	},

	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				-- optional configuration here
				transparent = true,
				style = {
					-- "none" is the same thing as default. But "italic" and "bold" are also valid options
					boolean = "none",
					number = "none",
					float = "none",
					error = "none",
					comments = "none",
					conditionals = "none",
					functions = "none",
					headings = "bold",
					operators = "none",
					strings = "none",
					variables = "none",

					-- keywords
					keywords = "none",
					keyword_return = "none",
					keywords_loop = "none",
					keywords_label = "none",
					keywords_exception = "none",

					-- builtin
					builtin_constants = "none",
					builtin_functions = "none",
					builtin_types = "none",
					builtin_variables = "none",
				},
				colors = {
					func = "#bc96b0",
					keyword = "#787bab",
					-- string = "#d4bd98",
					string = "#8a739a",
					-- string = "#f2e6ff",
					-- number = "#f2e6ff",
					-- string = "#d8d5b1",
					number = "#8f729e",
					-- type = "#dcaed7",
				},
			})
		end,
	},

	{
		"cdmill/neomodern.nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			require("neomodern").setup({})

			-- vim.cmd.colorscheme("roseprime")
		end,
	},

	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("ayu")
	-- 	end,
	-- },

	-- {
	--     "AlexvZyl/nordic.nvim",
	--     priority = 1000,
	--     config = function ()
	--         require("nordic").load()
	--         vim.cmd.colorscheme("nordic")
	--     end
	-- },

	-- {
	--     "sainnhe/gruvbox-material",
	--     priority = 1000,
	--     config = function()
	--         vim.cmd.colorscheme("gruvbox-material")
	--     end,
	-- },

	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({})
			-- vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},

	-- {
	--     "folke/tokyonight.nvim",
	--     priority = 1000,
	--     config = function ()
	--         vim.cmd.colorscheme("tokyonight-night")
	--     end
	-- },

	-- {
	--     "catppuccin/nvim",
	--     priority = 1000,
	--     config = function ()
	--         vim.cmd.colorscheme "catppuccin-mocha"
	--     end,
	-- },

	-- {
	--     "EdenEast/nightfox.nvim",
	--     priority = 1000,
	--     config = function ()
	--         vim.cmd.colorscheme "nordfox"
	--     end,
	-- },

	-- {
	--     "rose-pine/neovim",
	--     priority = 1000,
	--     config = function ()
	--         vim.cmd.colorscheme "rose-pine"
	--     end,
	-- },

	-- {
	-- 	"sainnhe/everforest",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("everforest")
	-- 	end,
	-- },

	-- {
	--     "sainnhe/sonokai",
	--     name = "sonokai",
	--     lazy = false,
	--     priority = 1000,
	--     config = function()
	--         vim.g.sonokai_style =
	--         "andromeda" --  Available values: 'default', 'atlantis', 'andromeda', 'shusia', 'maia','espresso'
	--         vim.g.sonokai_enable_italic = 1
	--         vim.g.sonokai_transparent_background = 0
	--         vim.g.sonokai_diagnostic_text_highlight = 1
	--         vim.g.sonokai_diagnostic_line_highlight = 1
	--         vim.g.sonokai_diagnostic_virtual_text = "highlighted"
	--     end,
	-- },
}
