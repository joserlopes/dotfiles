return {
    "NeogitOrg/neogit",
    --branch = "nightly",
    dependencies = {
        "nvim-lua/plenary.nvim",   -- required
        "sindrets/diffview.nvim",  -- optional - Diff integration

        "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,

    keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit", silent = true } },
}
