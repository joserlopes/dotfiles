return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = true,
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
                ["<C-p>"] = false,
                ["<C-c>"] = false,
                ["<C-l>"] = false,
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = false,
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        })
    end,
}
