return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		"arkav/lualine-lsp-progress",
	},

	config = function()
		local on_attach = function(client, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			nmap("<leader>vrn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>vca", vim.lsp.buf.code_action, "[C]ode [A]ction")

			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("<leader>vrf", vim.lsp.buf.references, "[G]oto [R]eferences")
			nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			nmap("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
			nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")

			-- See `:help K` for why this keymap
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, { desc = "LSP: Signature Help" })

			-- Lesser used LSP functionality
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")
			nmap("<leader>vd", function()
				vim.diagnostic.open_float()
			end)

			-- Create a command `:Format` local to the LSP buffer
			vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })

			nmap("<leader>hl", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, "Toggle [I]nlay [H]ints")
		end

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
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				vim.lsp.config[server_name] = {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				}
				vim.lsp.enable(server_name)
			end,
		})

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
