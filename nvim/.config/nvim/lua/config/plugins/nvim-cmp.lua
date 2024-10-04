return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",

		-- Adds LSP signature help while typing
		"hrsh7th/cmp-nvim-lsp-signature-help",

		-- Adds Path help while typing
		"hrsh7th/cmp-path",

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
	},

	config = function() end,
}
