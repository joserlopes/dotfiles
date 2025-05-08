return {
	"saecki/crates.nvim",
	tag = "stable",
	config = function()
		local on_attach = require("nice_utils").on_attach
		require("crates").setup({
			lsp = {
				enabled = true,
				on_attach = on_attach,
				actions = true,
				completion = true,
				hover = true,
			},
		})
	end,
}
