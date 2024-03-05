return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        plugins = {
            tmux = true,
            options = {
                colurcolumn = "0"
            },
        },
        window = {
            width = .90,
        }
    },
    keys = { { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
}
