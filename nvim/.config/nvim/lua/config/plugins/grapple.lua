return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "git",
	},
	keys = {
		{ "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Tag a file" },
		{ "<c-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },

		{ "<c-s>", "<cmd>Grapple select index=1<cr>", desc = "Select first tag" },
		-- For some reason ç counts as <c-ç> but <c-ç> does nothing...
		{ "ç", "<cmd>Grapple select index=2<cr>", desc = "Select second tag" },
		{ "<c-q>", "<cmd>Grapple select index=3<cr>", desc = "Select third tag" },
		{ "<c-y>", "<cmd>Grapple select index=4<cr>", desc = "Select fourth tag" },

		{ "<c-s-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
		{ "<c-s-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
	},
}
