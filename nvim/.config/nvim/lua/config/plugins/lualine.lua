return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local lazy_status = require("lazy.status")

		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					"fileformat",
					"filetype",
					"fileicon",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = {
				"oil",
				"quickfix",
				"trouble",
			},
		})
	end,
}
