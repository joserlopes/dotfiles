return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()

        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })

        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-w>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(3) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-g>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-i>", function() harpoon:list():next() end)
    end,
}
