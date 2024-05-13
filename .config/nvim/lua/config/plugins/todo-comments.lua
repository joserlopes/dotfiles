return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- NOTE: This keybind has to be in trouble config, because it's what
        -- triggers the plugin initialization
        -- vim.keymap.set("n", "<leader>tdf", "<cmd>TodoTrouble<cr>", { desc = "TodoTrouble", silent = true })
    },
    config = true,
}
