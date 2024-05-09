-- Use this one if NetRw is the file explorer being used
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "NetRW" })
-- Use this one if Oil is the file explorer being used
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- greatest remap ever
vim.keymap.set("v", "p", '"_dP')

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- Using conform to format files
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format File" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>e", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim<CR>")

-- avoid typing W instead of w to save the file
vim.cmd('cabbrev W w')
-- avoid typing Q instead of q to quit the file
vim.cmd('cabbrev Q q')

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- This next keymaps are a courtesy of Jon Gjengset

-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')

-- handy keymap for replacing up to next _ (like in variable names)
vim.keymap.set('n', '<leader>m', 'ct_')
-- handy keymap for deleting up to next _ (like in variable names)
vim.keymap.set('n', '<leader>M', 'dt_')

-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })

-- This keymap only applies for html and javascript files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "javascript" },
    callback = function(event)
        vim.keymap.set('n', '<Leader>of', function() vim.ui.open(vim.fn.expand('%')) end,
            { desc = "[O]pen [F]ile in browser", buffer = event.buf })
    end,
})

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
