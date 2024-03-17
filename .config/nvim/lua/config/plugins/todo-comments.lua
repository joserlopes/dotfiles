return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTelescope<cr>", { desc = "TodoTelescope", silent = true })
    },
    config = true,
}
