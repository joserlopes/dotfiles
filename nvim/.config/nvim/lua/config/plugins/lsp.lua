return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		},
	},

	config = function()
		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		local servers = {
			marksman = {},
			-- ts_ls = {},
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

		vim.lsp.enable("ruby_lsp")

		local vue_language_server_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
		local vue_plugin = {
			name = "@vue/typescript-plugin",
			location = vue_language_server_path,
			languages = { "vue" },
			configNamespace = "typescript",
		}
		local vtsls_config = {
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							vue_plugin,
						},
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		}

		local vue_ls_config = {
			on_init = function(client)
				client.handlers["tsserver/request"] = function(_, result, context)
					local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
					if #clients == 0 then
						vim.notify(
							"Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
							vim.log.levels.ERROR
						)
						return
					end
					local ts_client = clients[1]

					local param = unpack(result)
					local id, command, payload = unpack(param)
					ts_client:exec_cmd({
						title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
						command = "typescript.tsserverRequest",
						arguments = {
							command,
							payload,
						},
					}, { bufnr = context.bufnr }, function(_, r)
						local response_data = { { id, r.body } }
						---@diagnostic disable-next-line: param-type-mismatch
						client:notify("tsserver/response", response_data)
					end)
				end
			end,
		}
		-- nvim 0.11 or above
		vim.lsp.config("vtsls", vtsls_config)
		vim.lsp.config("vue_ls", vue_ls_config)
		vim.lsp.enable({ "vtsls", "vue_ls" })

		vim.diagnostic.config({
			virtual_text = true,
			virtual_lines = false,
			-- virtual_lines = true,
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
			severity_sort = true,
		})
	end,
}
