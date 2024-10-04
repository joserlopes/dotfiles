-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	--branch = "master",
	--tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { ".git/" },
				mappings = {
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
			},
		})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ hidden = true })
		end, { desc = "Telescope Find files" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Telescope grep search" })
		vim.keymap.set("n", "<leader>pws", function()
			builtin.grep_string({ search = vim.fn.expand("<cword>") })
		end, { desc = "Telescope word search" })
		vim.keymap.set("n", "<leader>pg", builtin.git_status, { desc = "Telescope git status" })
		vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = true,
			}))
		end, { desc = "[/] Fuzzily search in current buffer]" })
		vim.keymap.set("n", "<leader>pc", builtin.git_commits, { desc = "Git Commits" })
		vim.keymap.set("n", "<leader>pb", builtin.git_branches, { desc = "Git Brances" })
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
