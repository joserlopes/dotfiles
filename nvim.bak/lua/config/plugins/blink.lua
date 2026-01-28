return {
	"saghen/blink.cmp",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
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
			-- ["<C-n>"] = { "scroll_documentation_down", "fallback" },
			-- ["<C-p>"] = { "scroll_documentation_up", "fallback" },
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
				draw = {
					treesitter = { "lsp" },
				},
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

		signature = {
			enabled = true,
			window = {
				show_documentation = true,
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
