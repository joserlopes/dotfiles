return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "v2.*",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},

	version = "1.*",

	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<C-f>"] = { "select_next" },
			["<C-g>"] = { "select_prev" },
			["<C-l>"] = { "accept" },
			["<C-n>"] = { "scroll_documentation_down", "fallback" },
			["<C-p>"] = { "scroll_documentation_up", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			menu = {
				scrollbar = false,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },

			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
