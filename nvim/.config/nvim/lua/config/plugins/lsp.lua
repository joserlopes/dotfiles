return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",

		"arkav/lualine-lsp-progress",
	},

	config = function()
		local on_attach = require("nice_utils").on_attach

		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		local servers = {
			marksman = {},
			ts_ls = {},
			-- clangd = {},
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
			-- html = { filetypes = { "html", "twig", "hbs" } },
			-- ocamllsp = {},
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

		-- mason_lspconfig.setup_handlers({
		-- 	function(server_name)
		-- 		vim.lsp.config[server_name] = {
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			settings = servers[server_name],
		-- 			filetypes = (servers[server_name] or {}).filetypes,
		-- 		}
		-- 		vim.lsp.enable(server_name)
		-- 	end,
		-- })

		-- Harper LSP
		vim.lsp.config["harper_ls"] = {
			on_attach = on_attach,
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
			on_attach = on_attach,
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

		-- Dafny LSP
		-- vim.lsp.config["dafny"] = {
		-- 	cmd = { "/home/jrl/.nix-profile/bin/dafny", "server" },
		-- 	on_attach = on_attach,
		-- 	capabilities = capabilities,
		-- }
		-- vim.lsp.enable("dafny")

		-- Clinet

		vim.lsp.config["tinymist"] = {
			on_attach = on_attach,
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
		})
	end,
}
