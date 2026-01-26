vim.opt.guicursor = ""

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Something to do with netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Better search
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.wrap = false

-- Undo files and whatnot
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"

vim.opt.selection = "exclusive"

vim.opt.spell = true
vim.opt.spelllang = { "en", "pt" }

vim.wo.number = true
vim.wo.signcolumn = "yes"

vim.o.mouse = "a"

vim.o.breakindent = true

-- Set all floating window borders as rounded
vim.o.winborder = "rounded"

-- In visual block doc is "infinite"
vim.opt.virtualedit = "block"

vim.opt.conceallevel = 2

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Make it clear that we have a nerd font
vim.g.have_nerd_font = true
