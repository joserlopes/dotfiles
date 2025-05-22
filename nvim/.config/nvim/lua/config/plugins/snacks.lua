return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 2000,
		},
		quickfile = { enabled = true },
		words = { enabled = true },
		dashboard = { enabled = true },
		toggle = { enabled = true },
		indent = { enabled = true, animate = { enabled = false } },
		input = { enabled = true },
		-- image = { enabled = true },
		lazygit = { enabled = true },
		picker = { enabled = true },
	},
	keys = {
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},

		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
	},
}
