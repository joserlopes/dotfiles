-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Preview git hunk" }),
		})
	end,
}
