-- A sort of typst preview but with pdf
-- See here: https://myriad-dreamin.github.io/tinymist/frontend/neovim.html#label-Live%20Preview
vim.api.nvim_create_user_command("OpenPdf", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		local pdf_path = filepath:gsub("%.typ$", ".pdf")
		vim.system({ "zathura", pdf_path })
	end
end, {})

vim.keymap.set("n", "<leader>tw", "<CMD>OpenPdf<CR>", { desc = "Typst Watch" })
