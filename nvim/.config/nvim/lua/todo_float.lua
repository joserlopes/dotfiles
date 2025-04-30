local utils = require("nice_utils")
local M = {}

-- Store window and buffer IDs for cycling
local todos = {
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
	if todos.win and vim.api.nvim_win_is_valid(todos.win) then
		local title
		if todos.current_buf == todos.project_buf then
			title = " Project TODO "
		else
			title = " Global TODO "
		end

		vim.api.nvim_win_set_config(todos.win, {
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
				if todos.win and vim.api.nvim_win_is_valid(todos.win) then
					vim.api.nvim_win_close(todos.win, true)
					todos.win = nil
				end
			end
		end,
	})

	vim.api.nvim_buf_set_keymap(buf, "n", "<Tab>", "", {
		noremap = true,
		silent = true,
		callback = function()
			if todos.win and vim.api.nvim_win_is_valid(todos.win) then
				if todos.current_buf == todos.project_buf and todos.global_buf then
					vim.api.nvim_win_set_buf(todos.win, todos.global_buf)
					todos.current_buf = todos.global_buf
					update_window_title()
				elseif todos.project_buf then
					vim.api.nvim_win_set_buf(todos.win, todos.project_buf)
					todos.current_buf = todos.project_buf
					update_window_title()
				end
			end
		end,
	})
end

local function open_todo_window()
	if todos.win and vim.api.nvim_win_is_valid(todos.win) then
		-- Focus existing window
		vim.api.nvim_set_current_win(todos.win)
		return
	end

	-- Determine which buffer to show first (prefer project, fallback to global)
	local starting_buf = todos.project_buf or todos.global_buf
	if not starting_buf then
		vim.notify("No todo files available", vim.log.levels.ERROR)
		return
	end

	todos.current_buf = starting_buf

	-- Create title based on which buffer we're displaying
	local title = todos.current_buf == todos.project_buf and " Project TODO " or " Global TODO "

	-- Create the window with the title
	todos.win = vim.api.nvim_open_win(starting_buf, true, float_win_config(title))
	vim.cmd("setlocal nospell")

	vim.api.nvim_create_autocmd("VimResized", {
		callback = function()
			if todos.win and vim.api.nvim_win_is_valid(todos.win) then
				-- Keep the current title when resizing
				local current_title = todos.current_buf == todos.project_buf and " Project TODO " or " Global TODO "
				vim.api.nvim_win_set_config(todos.win, float_win_config(current_title))
			end
		end,
		once = false,
	})

	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(todos.win),
		callback = function()
			todos.win = nil
		end,
		once = true,
	})
end

local function find_project_todo(filename)
	-- Start from the current working directory
	local cwd = vim.fn.getcwd()
	local todo_path = cwd .. "/" .. filename

	-- Check if the file exists in the current directory
	if vim.fn.filereadable(todo_path) == 1 then
		return todo_path
	end

	return nil
end

local function setup_user_commands(opts)
	local filename = opts.filename or "todo.md"
	local global_file = utils.expand_path(opts.global_file)

	vim.api.nvim_create_user_command("Td", function()
		-- Prepare both todo files
		local project_todo = find_project_todo(filename)

		-- Reset buffer references
		todos.project_buf = nil
		todos.global_buf = nil

		-- Prepare project todo buffer if available
		if project_todo then
			todos.project_buf = prepare_buffer(project_todo)
			if todos.project_buf then
				setup_buffer_keymaps(todos.project_buf)
			end
		end

		-- Always prepare global todo buffer
		todos.global_buf = prepare_buffer(global_file)
		if todos.global_buf then
			setup_buffer_keymaps(todos.global_buf)
		end

		-- Open the floating window with the appropriate buffer
		open_todo_window()
	end, {})
end

local function setup_keymaps()
	vim.keymap.set("n", "<leader>td", ":Td<CR>", { silent = true })
end

M.setup = function(opts)
	-- Default options
	opts = opts or {}
	opts.filename = opts.filename or "todo.md"

	if not opts.global_file then
		-- Default global todo file location if not specified
		opts.global_file = vim.fn.expand("~/todo.md")
	end

	setup_user_commands(opts)
	setup_keymaps()
end

return M
