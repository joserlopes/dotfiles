return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			fzf_colors = true,
			winopts = {
				split = "belowright 10new",
				preview = {
					hidden = true,
				},
			},
			files = {
				git_icons = true,
				_fzf_nth_devicons = true,
			},
			buffers = {
				git_icons = true,
			},
		})

		-- this guy is a genius:
		-- https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua#L403-L418
		vim.keymap.set("n", "<leader>pf", function()
			local opts = {}
			opts.cmd = "fd --color=never --hidden --type f --type l --exclude .git"
			local base = vim.fn.fnamemodify(vim.fn.expand("%"), ":h:.:S")
			if base ~= "." then
				-- if there is no current file,
				-- proximity-sort can't do its thing
				opts.cmd = opts.cmd .. (" | proximity-sort %s"):format(vim.fn.shellescape(vim.fn.expand("%")))
			end
			opts.fzf_opts = {
				["--scheme"] = "path",
				["--tiebreak"] = "index",
				["--layout"] = "default",
			}
			fzf.files(opts)
		end, { desc = "fzf Find files" })

		-- vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "fzf Find files" })
		-- vim.keymap.set("n", "<leader>pr", fzf.lsp_references, { desc = "fzf Find References" })
		-- vim.keymap.set("n", "<leader>pd", fzf.lsp_definitions, { desc = "fzf Find Definitions" })
		-- vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "fzf find git files" })
		vim.keymap.set("n", "<leader>ps", fzf.grep, { desc = "fzf grep search" })
		-- vim.keymap.set("n", "<leader>pws", fzf.grep_cword, { desc = "fzf word search" })
		-- vim.keymap.set("n", "<leader>pg", fzf.git_status, { desc = "fzf git status" })
		vim.keymap.set("n", "<leader>lg", fzf.live_grep, { desc = "Live Grep" })
		-- vim.keymap.set("n", "<leader>pc", fzf.git_commits, { desc = "Git Commits" })
		-- vim.keymap.set("n", "<leader>pb", fzf.git_branches, { desc = "Git Brances" })
	end,
}
