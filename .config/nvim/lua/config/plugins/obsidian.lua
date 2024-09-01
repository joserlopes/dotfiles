return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "Notes",
					path = "~/Dropbox/Notes",
				},
			},
			completion = {
				-- Set to false to disable completion.
				nvim_cmp = true,

				-- Trigger completion at 2 chars.
				min_chars = 2,
			},
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({ "open", url }) -- Mac OS
				vim.fn.jobstart({ "xdg-open", url }) -- linux
			end,

			vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "[O]bsidian [O]pen" }),
			vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "[O]bsidian [N]ew" }),
			vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", { desc = "[O]bsidian [B]acklinks" }),
			vim.keymap.set("n", "<leader>otd", ":ObsidianToday<CR>", { desc = "[O]bsidian [T]o[m]orrow" }),
			vim.keymap.set("n", "<leader>otm", ":ObsidianTomorrow<CR>", { desc = "[O]bsidian [T]o[d]ay" }),
			vim.keymap.set("n", "<leader>oyd", ":ObsidianYesterday<CR>", { desc = "[O]bsidian [Y]ester[d]ay" }),
			vim.keymap.set(
				"n",
				"<leader>owp",
				":ObsidianWorkspace Project<CR>",
				{ desc = "[O]bsidian [W]orkspace [P]roject" }
			),
			vim.keymap.set(
				"n",
				"<leader>owa",
				":ObsidianWorkspace Area<CR>",
				{ desc = "[O]bsidian [W]orkspace [A]rea" }
			),
			vim.keymap.set(
				"n",
				"<leader>owr",
				":ObsidianWorkspace Resource<CR>",
				{ desc = "[O]bsidian [W]orkspace [R]esource" }
			),
			vim.keymap.set(
				"n",
				"<leader>owc",
				":ObsidianWorkspace Archive<CR>",
				{ desc = "[O]bsidian [W]orkspace [A]rchive" }
			),
			vim.keymap.set("n", "<leader>ofl", ":ObsidianFollowLink<CR>", { desc = "[O]bsidian [F]ollow [L]ink" }),
		})
	end,
}
