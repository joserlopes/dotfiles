{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  inherit (lib) lists;
  commonGrammars = with pkgs-unstable.vimPlugins.nvim-treesitter.builtGrammars; [
    bash
    comment
    html
    markdown
    nix
    python
    c
    cpp
    java
    javascript
    latex
    lua
    rust
    toml
    typescript
    pkgs-unstable.tree-sitter-grammars.tree-sitter-typst
    vim
    yaml
  ];
in {
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      {
        plugin =
          nvim-treesitter.withPlugins
          (plugins: commonGrammars);
        type = "lua";
        config = ''
          -- enable highlighting
           require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
        '';
      }

      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require("telescope").setup({
          	defaults = {
          		mappings = {
          			i = {
          				["<C-u>"] = false,
          				["<C-d>"] = false,
          				["<C-j>"] = require("telescope.actions").move_selection_next,
          				["<C-k>"] = require("telescope.actions").move_selection_previous,
          			},
          		},
          	},
          })
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope Find files" })
          vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })
          vim.keymap.set("n", "<leader>ps", function()
          	builtin.grep_string({ search = vim.fn.input("Grep > ") })
          end, { desc = "Telescope grep search" })
          vim.keymap.set("n", "<leader>pws", function()
          	builtin.grep_string({ search = vim.fn.expand("<cword>") })
          end, { desc = "Telescope word search" })
          vim.keymap.set("n", "<leader>pg", builtin.git_status, { desc = "Telescope git status" })
          vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live Grep" })
          vim.keymap.set("n", "<leader>/", function()
          	-- You can pass additional configuration to telescope to change theme, layout, etc.
          	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          		winblend = 10,
          		previewer = true,
          	}))
          end, { desc = "[/] Fuzzily search in current buffer]" })
          vim.keymap.set("n", "<leader>pc", builtin.git_commits, { desc = "Git Commits" })
          vim.keymap.set("n", "<leader>pb", builtin.git_branches, { desc = "Git Brances" })
          vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Telescope help tags" })
        '';
      }
      {
        plugin = base16-nvim;
        type = "lua";
        config = ''
          vim.cmd.colorscheme("base16-everforest")
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup({
            options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
            statusline = {},
            winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            },
            },
            sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
             { "filename", path = 1 },
             {
              "lsp_progress",
              spinner_symbols = { "🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘" },
             },
            },
            lualine_x = { "encoding", "fileformat", "filetype", "fileicon" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
            },
            inactive_sections = {
             lualine_a = {},
             lualine_b = {},
             lualine_c = { "filename" },
             lualine_x = { "location" },
             lualine_y = {},
             lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
          })
        '';
      }
    ];
    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

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

      vim.opt.wrap = false

      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true

      vim.opt.hlsearch = false
      vim.opt.incsearch = true

      -- Shows incremental commands on a split
      vim.opt.inccommand = "split"

      -- NOTE: No longer needed since 0.10
      vim.opt.termguicolors = true

      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.isfname:append("@-@")

      vim.opt.updatetime = 50

      -- show a column at 80 characters as a guide for long lines
      vim.opt.colorcolumn = "80"
      --- except in Rust where the rule is 100 characters
      vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })

      vim.opt.selection = "exclusive"

      vim.opt.spell = true
      vim.opt.spelllang = { "en", "pt" }

      vim.wo.number = true
      vim.wo.signcolumn = "yes"

      vim.o.mouse = "a"

      vim.o.breakindent = true

      -- In visual block doc is "infinite"
      vim.opt.virtualedit = "block"

      vim.opt.conceallevel = 2

      -- Set completeopt to have a better completion experience
      vim.o.completeopt = "menuone,noselect"

      -- Enable cursor line highlight
      vim.opt.cursorline = true

      -- REMAPS

      -- Use this one if NetRw is the file explorer being used
      vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "NetRW" })
      -- Use this one if Oil is the file explorer being used
      --vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

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
      vim.cmd("cabbrev W w")
      -- avoid typing Q instead of q to quit the file
      vim.cmd("cabbrev Q q")

      vim.keymap.set("n", "<leader><leader>", function()
              vim.cmd("so")
              end)

      -- This next keymaps are a courtesy of Jon Gjengset

      -- Jump to start and end of line using the home row keys
      vim.keymap.set("", "H", "^")
      vim.keymap.set("", "L", "$")

      -- handy keymap for replacing up to next _ (like in variable names)
      vim.keymap.set("n", "<leader>m", "ct_")
      -- handy keymap for deleting up to next _ (like in variable names)
      vim.keymap.set("n", "<leader>M", "dt_")

      -- always center search results
      vim.keymap.set("n", "n", "nzz", { silent = true })
      vim.keymap.set("n", "N", "Nzz", { silent = true })

      -- better indenting
      vim.keymap.set("v", "<", "<gv")
      vim.keymap.set("v", ">", ">gv")
    '';
  };
}
