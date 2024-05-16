return {

	{
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("base16-gruvbox-material-dark-soft")
			-- Different colorschemes
			--vim.cmd.colorscheme('base16-kanagawa')
			--vim.cmd.colorscheme('base16-everforest')
			--vim.cmd.colorscheme('base16-nord')
			--vim.cmd.colorscheme('base16-zenburn')
			--vim.cmd.colorscheme('base16-rose-pine')
		end,
	},

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

	-- {
	--     "rebelot/kanagawa.nvim",
	--     priority = 1000,
	--     config = function ()
	--         -- require("kanagawa").setup({
	--         --     transparent = true,
	--         --     theme = "dragon",
	--         -- })
	--         vim.cmd.colorscheme("kanagawa-dragon")
	--     end
	-- },

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
	--     "sainnhe/everforest",
	--     priority = 1000,
	--     config = function ()
	--         vim.cmd.colorscheme "everforest"
	--     end,
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

	-- {
	--     "Shatur/neovim-ayu",
	--     lazy = false,
	--     priority = 1000,
	--     config = function()
	--         vim.cmd.colorscheme('ayu')
	--     end
	-- }
}
