return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},

	config = function()
		-- mason-lspconfig requires that these setup functions are called in this order
		-- before setting up the servers.
		require("mason").setup()
		require("mason-lspconfig").setup()

		local servers = {
			-- ts_ls = {},
			-- gopls = {},
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
					checkOnSave = {
						enable = true,
					},
					check = {
						command = "clippy",
					},
					imports = {
						group = {
							enable = false,
						},
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

		vim.lsp.enable("superhtml")

		-- Harper LSP
		-- vim.lsp.config("harper_ls", {
		-- 	settings = {
		-- 		["harper-ls"] = {
		-- 			linters = {
		-- 				SentenceCapitalization = false,
		-- 				SpellCheck = false,
		-- 				ToDoHyphen = false,
		-- 			},
		-- 		},
		-- 	},
		-- })
		-- vim.lsp.enable("harper_ls")

		-- Gleam LSP
		vim.lsp.config("gleam", {})
		vim.lsp.enable("gleam")

		-- Python LSP
		-- vim.lsp.config("pyright", {
		-- 	settings = {
		-- 		python = {
		-- 			analysis = {
		-- 				diagnosticSeverityOverrides = {
		-- 					reportPossiblyUnboundVariable = "none",
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- })
		-- vim.lsp.enable("pyright")
		vim.lsp.config("basedpyright", {
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
		vim.lsp.enable("basedpyright")

		vim.lsp.config("tinymist", {
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onType",
			},
			on_attach = function(client, bufnr)
				-- If the file name is main.typ, auto-pin it as the main file
				local file_path = vim.api.nvim_buf_get_name(bufnr)
				if file_path:match("main%.typ$") then
					client:exec_cmd({
						title = "pin",
						command = "tinymist.pinMain",
						arguments = { file_path },
					}, { bufnr = bufnr })
				end

				vim.keymap.set("n", "<leader>tp", function()
					client:exec_cmd({

						title = "pin",

						command = "tinymist.pinMain",

						arguments = { vim.api.nvim_buf_get_name(0) },
					}, { bufnr = bufnr })
				end, { desc = "[T]inymist [P]in", noremap = true })

				vim.keymap.set("n", "<leader>tu", function()
					client:exec_cmd({

						title = "unpin",

						command = "tinymist.pinMain",

						arguments = { vim.v.null },
					}, { bufnr = bufnr })
				end, { desc = "[T]inymist [U]npin", noremap = true })
			end,
		})
		vim.lsp.enable("tinymist")

		vim.lsp.enable("ruby_lsp")

		-- OCaml LSP
		vim.lsp.config("ocamllsp", {
			cmd = { "ocamllsp" },
			filetypes = {
				"ocaml",
				"ocaml.interface",
				"ocaml.menhir",
				"ocaml.ocamllex",
				"dune",
				"reason",
			},
			root_markers = {
				{ "dune-project", "dune-workspace" },
				{ "*.opam", "esy.json", "package.json" },
				".git",
			},
			settings = {},
		})
		vim.lsp.enable("ocamllsp")

		-- Zig LSP
		vim.lsp.config("zls", {
			settings = {
				zls = {
					semantic_tokens = "partial",
				},
			},
		})
		vim.lsp.enable("zls")

		vim.diagnostic.config({
			virtual_text = true,
			-- virtual_text = false,
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
