return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        plugins = {
            gitsigns = true,
            tmux = true,
        },
        window = {
            width = .90,
        }
    },
    keys = { { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
}
