return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			fzf_colors = true,
		})
		local fzf = require("fzf-lua")
		vim.keymap.set("n", "<leader>pf", fzf.files, { desc = "fzf Find files" })
		vim.keymap.set("n", "<leader>pr", fzf.lsp_references, { desc = "fzf Find References" })
		vim.keymap.set("n", "<leader>pd", fzf.lsp_definitions, { desc = "fzf Find Definitions" })
		vim.keymap.set("n", "<C-p>", fzf.git_files, { desc = "fzf find git files" })
		vim.keymap.set("n", "<leader>ps", fzf.grep, { desc = "fzf grep search" })
		vim.keymap.set("n", "<leader>pws", fzf.grep_cword, { desc = "fzf word search" })
		vim.keymap.set("n", "<leader>pg", fzf.git_status, { desc = "fzf git status" })
		vim.keymap.set("n", "<leader>lg", fzf.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>pc", fzf.git_commits, { desc = "Git Commits" })
		vim.keymap.set("n", "<leader>pb", fzf.git_branches, { desc = "Git Brances" })
	end,
}
