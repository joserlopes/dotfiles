return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        plugins = {
            tmux = true,
            options = {
                signcolumn = "no"
            },
        },
        window = {
            width = .90,
        }
    },
    keys = { { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
}
