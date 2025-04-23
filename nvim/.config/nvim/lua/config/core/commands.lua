-- A sort of typst preview but with pdf
-- See here: https://myriad-dreamin.github.io/tinymist/frontend/neovim.html#label-Live%20Preview for inspiration
vim.api.nvim_create_user_command("TypstWatch", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		local pdf_path = filepath:gsub("%.typ$", ".pdf")
		-- Start zathura and capture the process handle
		local handle = vim.system({ "zathura", pdf_path }, { detach = true })

		-- Create autocmd to kill zathura when neovim exits
		vim.api.nvim_create_autocmd("VimLeave", {
			callback = function()
				if handle and handle.pid then
					vim.system({ "kill", tostring(handle.pid) })
				end
			end,
			group = vim.api.nvim_create_augroup("ZathuraKiller", { clear = true }),
		})
	end
end, {})

vim.keymap.set("n", "<leader>tw", "<CMD>TypstWatch<CR>", { desc = "Typst Watch" })
