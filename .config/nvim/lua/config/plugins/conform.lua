return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			timeout_ms = 1000,
			lsp_fallback = true,
			formatters_by_ft = {
				lua = { "stylua" },
				svelte = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				graphql = { { "prettierd", "prettier" } },
				java = { "google-java-format" },
				kotlin = { "ktlint" },
				ruby = { "standardrb" },
				markdown = { { "prettierd", "prettier" } },
				erb = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				bash = { "beautysh" },
				proto = { "buf" },
				python = { "black" },
				rust = { "rustfmt" },
				yaml = { "yamlfix" },
				toml = { "taplo" },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
			pattern = { "*" },
			desc = "Run conform formatting on a file on save",
			callback = function(args)
				conform.format({
					bufnr = args.buf,
					lsp_fallback = true,
					quiet = true,
				})
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>l", function()
			conform.format({
				lsp_fallback = true,
				quiet = true,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}