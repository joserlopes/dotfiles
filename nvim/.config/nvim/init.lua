require("config.core")
require("config.lazy")

local utils = require("config.utils")

-- Improve lualine
-- theme
-- vim.cmd("colorscheme vague")
--vim.cmd("colorscheme base16-black-metal-gorgoroth")
vim.cmd.colorscheme("kanagawa-dragon")
if vim.g.colors_name == "vague" then
	utils.color_overrides.vague_line_colors()
	utils.color_overrides.vague_status_colors()
elseif vim.g.colors_name == "roseprime" then
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#710000" })
	vim.api.nvim_set_hl(0, "TSComment", { fg = "#555555", gui = nil })

	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "#1e1e1e" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })
end

utils.color_overrides.vague_line_colors()
utils.color_overrides.vague_status_colors()

vim.api.nvim_create_user_command("VagueStatus", utils.color_overrides.vague_status_colors, {})
vim.api.nvim_create_user_command("VagueLine", utils.color_overrides.vague_line_colors, {})
vim.api.nvim_create_user_command("DefStatus", function()
	require("lualine").setup({ options = { theme = "auto" } })
end, {})
