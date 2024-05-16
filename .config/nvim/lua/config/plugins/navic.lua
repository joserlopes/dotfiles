return {
	--[[ "SmiteshP/nvim-navic",
    dependencies = {
        "LunarVim/breadcrumbs.nvim",
    },
    config = function()
        require("nvim-navic").setup {
            highlight = true,
            lsp = {
                auto_attach = true,
            },
            click = true,
            depth_limit = 0,
            depth_limit_indicator = "..",
        }
        require("breadcrumbs").setup()
    end ]]
}
