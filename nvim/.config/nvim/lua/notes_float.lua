local utils = require("nice_utils")
local M = {}

-- Store window and buffer IDs for cycling
local notes = {
	win = nil,
	project_buf = nil,
	global_buf = nil,
	current_buf = nil,
}

local function float_win_config(title)
	local width = math.min(math.floor(vim.o.columns * 0.8), 64)
	local height = math.floor(vim.o.lines * 0.8)
	return {
		relative = "editor",
		width = width,
		height = height,
		col = utils.center_in(vim.o.columns, width),
		row = utils.center_in(vim.o.lines, height),
		border = "single",
		title = title,
		title_pos = "center",
	}
end

local function prepare_buffer(filepath)
	local path = utils.expand_path(filepath)
	-- Check if the file exists
	if vim.fn.filereadable(path) == 0 then
		vim.notify("File does not exist: " .. path, vim.log.levels.ERROR)
		return nil
	end

	-- Look for an existing buffer with this file
	local buf = vim.fn.bufnr(path, true)

	-- If the buffer doesn't exist, create one and edit the file
	if buf == -1 then
		buf = vim.api.nvim_create_buf(false, false)
		vim.api.nvim_buf_set_name(buf, path)
		vim.api.nvim_buf_call(buf, function()
			vim.cmd("edit " .. vim.fn.fnameescape(path))
		end)
	end

	vim.bo[buf].swapfile = false
	return buf
end

local function update_window_title()
	if notes.win and vim.api.nvim_win_is_valid(notes.win) then
		local title
		if notes.current_buf == notes.project_buf then
			title = " Project Notes "
		else
			title = " Global Notes "
		end

		vim.api.nvim_win_set_config(notes.win, {
			title = title,
			title_pos = "center",
		})
	end
end

local function setup_buffer_keymaps(buf)
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
		noremap = true,
		silent = true,
		callback = function()
			-- Check if the buffer has unsaved changes
			if vim.api.nvim_get_option_value("modified", { buf = buf }) then
				vim.notify("Save your changes", vim.log.levels.WARN)
			else
				if notes.win and vim.api.nvim_win_is_valid(notes.win) then
					vim.api.nvim_win_close(notes.win, true)
					notes.win = nil
				end
			end
		end,
	})

	vim.api.nvim_buf_set_keymap(buf, "n", "<Tab>", "", {
		noremap = true,
		silent = true,
		callback = function()
			if notes.win and vim.api.nvim_win_is_valid(notes.win) then
				if notes.current_buf == notes.project_buf and notes.global_buf then
					vim.api.nvim_win_set_buf(notes.win, notes.global_buf)
					notes.current_buf = notes.global_buf
					update_window_title()
				elseif notes.project_buf then
					vim.api.nvim_win_set_buf(notes.win, notes.project_buf)
					notes.current_buf = notes.project_buf
					update_window_title()
				end
			end
		end,
	})
end

local function open_notes_window()
	if notes.win and vim.api.nvim_win_is_valid(notes.win) then
		-- Focus existing window
		vim.api.nvim_set_current_win(notes.win)
		return
	end

	-- Determine which buffer to show first (prefer project, fallback to global)
	local starting_buf = notes.project_buf or notes.global_buf
	if not starting_buf then
		vim.notify("No notes files available", vim.log.levels.ERROR)
		return
	end

	notes.current_buf = starting_buf

	-- Create title based on which buffer we're displaying
	local title = notes.current_buf == notes.project_buf and " Project Notes " or " Global Notes "

	-- Create the window with the title
	notes.win = vim.api.nvim_open_win(starting_buf, true, float_win_config(title))
	vim.cmd("setlocal nospell")

	vim.api.nvim_create_autocmd("VimResized", {
		callback = function()
			if notes.win and vim.api.nvim_win_is_valid(notes.win) then
				-- Keep the current title when resizing
				local current_title = notes.current_buf == notes.project_buf and " Project Notes " or " Global Notes "
				vim.api.nvim_win_set_config(notes.win, float_win_config(current_title))
			end
		end,
		once = false,
	})

	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(notes.win),
		callback = function()
			notes.win = nil
		end,
		once = true,
	})
end

local function find_project_notes(filename)
	-- Start from the current working directory
	local cwd = vim.fn.getcwd()
	local notes_path = cwd .. "/" .. filename

	-- Check if the file exists in the current directory
	if vim.fn.filereadable(notes_path) == 1 then
		return notes_path
	end

	return nil
end

local function setup_user_commands(opts)
	local filename = opts.filename or "notes.md"
	local global_file = utils.expand_path(opts.global_file)

	vim.api.nvim_create_user_command("Nt", function()
		-- Prepare both notes files
		local project_notes = find_project_notes(filename)

		-- Reset buffer references
		notes.project_buf = nil
		notes.global_buf = nil

		-- Prepare project notes buffer if available
		if project_notes then
			notes.project_buf = prepare_buffer(project_notes)
			if notes.project_buf then
				setup_buffer_keymaps(notes.project_buf)
			end
		end

		-- Always prepare global notes buffer
		notes.global_buf = prepare_buffer(global_file)
		if notes.global_buf then
			setup_buffer_keymaps(notes.global_buf)
		end

		-- Open the floating window with the appropriate buffer
		open_notes_window()
	end, {})
end

local function setup_keymaps()
	vim.keymap.set("n", "<leader>nt", ":Nt<CR>", { silent = true })
end

M.setup = function(opts)
	-- Default options
	opts = opts or {}
	opts.filename = opts.filename or "notes.md"

	if not opts.global_file then
		-- Default global notes file location if not specified
		opts.global_file = vim.fn.expand("~/notes.md")
	end

	setup_user_commands(opts)
	setup_keymaps()
end

return M
