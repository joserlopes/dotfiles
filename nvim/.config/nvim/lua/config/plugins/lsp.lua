return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},

	config = function()
		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		local servers = {
			marksman = {},
			ts_ls = {},
			gopls = {
				analyses = {
					unusedparams = true,
				},
				gofumpt = true,
				staticcheck = true,
			},
			rust_analyzer = {
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
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- Ensure the servers above are installed
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = false,
			automatic_enable = true,
		})

		-- Harper LSP
		vim.lsp.config["harper_ls"] = {
			capabilities = capabilities,
			settings = {
				["harper-ls"] = {
					linters = {
						SentenceCapitalization = false,
						SpellCheck = false,
					},
				},
			},
		}

		-- Gleam LSP
		-- vim.lsp.config["gleam"] = {
		-- 	on_attach = on_attach,
		-- 	capabilities = capabilities,
		-- }
		-- vim.lsp.enable("gleam")

		-- Python LSP
		vim.lsp.config["pyright"] = {
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						diagnosticSeverityOverrides = {
							reportPossiblyUnboundVariable = "none",
						},
					},
				},
			},
		}
		vim.lsp.enable("pyright")

		vim.lsp.config["tinymist"] = {
			capabilities = capabilities,
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onSave",
			},
		}
		vim.lsp.enable("tinymist")

		vim.diagnostic.config({
			virtual_text = true,
			float = {
				focusable = false,
				border = "rounded",
				source = true,
			},
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
		})
	end,
}
