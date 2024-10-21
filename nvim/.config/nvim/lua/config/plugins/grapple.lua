return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "git", -- also try out "git_branch"
	},
	keys = {
		{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
		{ "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

		{ "<c-s>", "<cmd>Grapple select index=1<cr>", desc = "Select fourth tag" },
		{ "<c-h>", "<cmd>Grapple select index=2<cr>", desc = "Select first tag" },
		{ "<c-t>", "<cmd>Grapple select index=3<cr>", desc = "Select second tag" },
		{ "<c-n>", "<cmd>Grapple select index=4<cr>", desc = "Select third tag" },

		{ "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
		{ "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
	},
}
