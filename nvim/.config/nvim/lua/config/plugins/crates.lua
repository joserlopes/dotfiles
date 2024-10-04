return {
	"saecki/crates.nvim",
	event = "BufRead Cargo.toml",
	opts = {
		popup = {
			border = "rounded",
		},
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
		},
	},
}
