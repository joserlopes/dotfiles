return {
	"onsails/lspkind.nvim",

	"christoomey/vim-tmux-navigator",

	"RRethy/vim-illuminate",

	"folke/twilight.nvim",

	"xiyaowong/transparent.nvim",

	"benknoble/vim-dafny",

	"runoshun/vim-alloy",

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},

	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
		config = function()
			-- require("lspconfig").tinymist.setup({
			-- 	settings = {
			-- 		exportPdf = "never", -- Choose onType, onSave or never.
			-- 		-- serverPath = "" -- Normally, there is no need to uncomment it.
			-- 	},
			-- })
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
