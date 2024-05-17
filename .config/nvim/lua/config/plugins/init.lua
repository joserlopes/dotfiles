return {
	"onsails/lspkind.nvim",

	"christoomey/vim-tmux-navigator",

	"RRethy/vim-illuminate",

	"folke/twilight.nvim",

	"xiyaowong/transparent.nvim",

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require("lsp_signature").setup({
				doc_lines = 0,
				hint_prefix = "",
				-- handler_opts = {
				--     border = "none"
				-- },
			})
		end,
	},

	{
		"kaarmu/typst.vim",
		ft = "typst",
		lazy = false,
		config = function()
			require("lspconfig").typst_lsp.setup({
				settings = {
					exportPdf = "never", -- Choose onType, onSave or never.
					-- serverPath = "" -- Normally, there is no need to uncomment it.
				},
			})
			vim.keymap.set("n", "<leader>tw", function()
				vim.fn["typst#TypstWatch"]()
			end, { desc = "[T]ypst [W]atch", silent = true })
		end,
	},

	-- {
	--     'chomosuke/typst-preview.nvim',
	--     lazy = false, -- or ft = 'typst'
	--     version = '0.1.*',
	--     build = function() require 'typst-preview'.update() end,
	--     config = function()
	--         vim.keymap.set('n', '<leader>tp', "<cmd>TypstPreviewToggle<CR>", { desc = "[T]ypst [P]review" })
	--     end
	-- },
}
