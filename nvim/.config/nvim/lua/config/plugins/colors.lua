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

	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
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
		"ramojus/mellifluous.nvim",
	},

	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
	},

	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
	},

	{
		"sainnhe/everforest",
		priority = 1000,
	},
}
