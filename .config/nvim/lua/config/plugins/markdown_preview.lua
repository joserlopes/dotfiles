return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,

    cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop",
    },

    keys = { { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreviewToggle" } }
}
