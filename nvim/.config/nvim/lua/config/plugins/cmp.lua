return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
		},
	},

	version = "1.*",

	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<C-f>"] = { "select_next" },
			["<C-h>"] = { "select_prev" },
			["<C-l>"] = { "accept" },
			["<C-n>"] = { "scroll_documentation_down", "fallback" },
			["<C-p>"] = { "scroll_documentation_up", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = { documentation = { auto_show = false } },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
