return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				java = { "google-java-format" },
				kotlin = { "ktlint" },
				ruby = { "standardrb" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				erb = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				bash = { "beautysh" },
				proto = { "buf" },
				python = {
					-- To fix lint errors "ruff_fix",
					"ruff_format",
				},
				rust = { "rustfmt" },
				c = { "uncrustify" },
				ocaml = { "ocamlformat" },
				go = { "gofmt" },
				yaml = { "yamlfix" },
				toml = { "taplo" },
				typst = { "typstyle" },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>l", function()
			conform.format({
				lsp_format = "fallback",
				quiet = true,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
