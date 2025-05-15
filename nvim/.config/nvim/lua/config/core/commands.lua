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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		nmap("<leader>vrn", vim.lsp.buf.rename, "[R]e[n]ame")
		nmap("<leader>vca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		nmap("<leader>vrf", vim.lsp.buf.references, "[G]oto [R]eferences")
		nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
		nmap("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
		nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")

		-- See `:help K` for why this keymap
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { desc = "LSP: Signature Help" })

		-- Lesser used LSP functionality
		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
		nmap("<leader>vd", function()
			vim.diagnostic.open_float()
		end)

		nmap("<leader>hl", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, "Toggle [I]nlay [H]ints")

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end,
})
