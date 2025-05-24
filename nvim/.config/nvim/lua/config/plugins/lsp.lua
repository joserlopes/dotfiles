return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
	},

	config = function()
		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		local servers = {
			marksman = {},
			ts_ls = {},
			gopls = {},
			rust_analyzer = {},
			lua_ls = {},
		}

		-- Ensure the servers above are installed
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = false,
			automatic_enable = true,
		})

		-- gopls
		vim.lsp.config("gopls", {
			analyses = {
				unusedparams = true,
			},
			gofumpt = true,
			staticcheck = true,
		})
		vim.lsp.enable("gopls")

		-- rust_analyzer
		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						features = "all",
					},
					check = {
						command = "clippy",
					},
					rustfmt = {
						extraArgs = { "--config=wrap_comments=true" },
					},
				},
			},
		})
		vim.lsp.enable("rust_analyzer")

		-- Lua LSP
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
						telemetry = { enable = false },
						library = {
							"${3rd}/love2d/library",
						},
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Harper LSP
		vim.lsp.config("harper_ls", {
			settings = {
				["harper-ls"] = {
					linters = {
						SentenceCapitalization = false,
						SpellCheck = false,
						ToDoHyphen = false,
					},
				},
			},
		})
		vim.lsp.enable("harper_ls")

		-- Gleam LSP
		vim.lsp.config("gleam", {})
		vim.lsp.enable("gleam")

		-- Python LSP
		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						diagnosticSeverityOverrides = {
							reportPossiblyUnboundVariable = "none",
						},
					},
				},
			},
		})
		vim.lsp.enable("pyright")
		vim.lsp.enable("pyrefly")

		vim.lsp.config("tinymist", {
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onSave",
			},
		})
		vim.lsp.enable("tinymist")

		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
			-- virtual_lines = true,
			float = {
				focusable = false,
				border = "rounded",
				source = true,
			},
			-- underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			severity_sort = true,
		})
	end,
}
