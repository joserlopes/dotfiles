return {
    "wallpants/github-preview.nvim",
    opts = {
        cursor_line = {
            disable = true,
        }
    },

    config = function(_, opts)
        local gpreview = require("github-preview")
        gpreview.setup(opts)

        local fns = gpreview.fns
        vim.keymap.set("n", "<leader>mpt", fns.toggle, { desc = "[M]arkdown [P]review [T]oggle" })
        vim.keymap.set("n", "<leader>mps", fns.single_file_toggle, { desc = "[M]arkdown [P]review [S]ingle" })
        vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle, { desc = "[M]arkdown [P]review [D]details" })
    end,
}
