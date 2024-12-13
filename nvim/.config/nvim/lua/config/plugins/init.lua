return {
	"onsails/lspkind.nvim",

	"christoomey/vim-tmux-navigator",

	"RRethy/vim-illuminate",

	"xiyaowong/transparent.nvim",

	"benknoble/vim-dafny",

	"runoshun/vim-alloy",

	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			maxkeys = 5,
			position = "top-center",
		},
	},

	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<leader>tw", function()
				vim.fn["typst#TypstWatch"]()
			end, { desc = "[T]ypst [W]atch", silent = true })
		end,
	},

	-- {
	-- 	"chomosuke/typst-preview.nvim",
	-- 	ft = "typst",
	-- 	version = "1.*",
	-- 	build = function()
	-- 		require("typst-preview").update()
	-- 	end,
	-- 	config = function()
	-- 		vim.keymap.set("n", "<leader>tp", "<cmd>TypstPreviewToggle<CR>", { desc = "[T]ypst [P]review" })
	-- 	end,
	-- },
}
