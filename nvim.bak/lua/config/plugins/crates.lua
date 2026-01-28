return {
	"saecki/crates.nvim",
	tag = "stable",
	config = function()
		local crates = require("crates")
		local opts = { silent = true }
		crates.setup({
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		})

		vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
		vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
	end,
}
