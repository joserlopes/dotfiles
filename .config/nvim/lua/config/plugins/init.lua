return {
    "onsails/lspkind.nvim",

    "christoomey/vim-tmux-navigator",

    "RRethy/vim-illuminate",

    "folke/twilight.nvim",

    -- {
    --     {
    --         "zbirenbaum/copilot-cmp",
    --         event = { "BufEnter" },
    --         dependencies = { "zbirenbaum/copilot.lua" },
    --         config = function()
    --             require("copilot").setup({})
    --             require("copilot_cmp").setup()
    --         end,
    --     },
    -- }

    -- "xiyaowong/transparent.nvim",

    -- {
    --     "AlexvZyl/nordic.nvim",
    --     priority = 1000,
    --     config = function ()
    --         require("nordic").load()
    --         vim.cmd.colorscheme("nordic")
    --     end
    -- },

    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },

    -- {
    --     "rebelot/kanagawa.nvim",
    --     priority = 1000,
    --     config = function ()
    --         -- require("kanagawa").setup({
    --         --     transparent = true,
    --         --     theme = "dragon",
    --         -- })
    --         vim.cmd.colorscheme("kanagawa-dragon")
    --     end
    -- },

    -- {
    --     "folke/tokyonight.nvim",
    --     priority = 1000,
    --     config = function ()
    --         vim.cmd.colorscheme("tokyonight-night")
    --     end
    -- },

    -- {
    --     "catppuccin/nvim",
    --     priority = 1000,
    --     config = function ()
    --         vim.cmd.colorscheme "catppuccin-mocha"
    --     end,
    -- },

    -- {
    --     "EdenEast/nightfox.nvim",
    --     priority = 1000,
    --     config = function ()
    --         vim.cmd.colorscheme "nordfox"
    --     end,
    -- },

    -- {
    --     "rose-pine/neovim",
    --     priority = 1000,
    --     config = function ()
    --         vim.cmd.colorscheme "rose-pine"
    --     end,
    -- },

    -- {
    --     "sainnhe/everforest",
    --     priority = 1000,
    --     config = function ()
    --         vim.cmd.colorscheme "everforest"
    --     end,
    -- },

    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = "ibl",
        opts = {},
    },

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}, -- this is equalent to setup({}) function
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
        config = function()
            require 'lspconfig'.typst_lsp.setup {
                settings = {
                    exportPdf = "never" -- Choose onType, onSave or never.
                    -- serverPath = "" -- Normally, there is no need to uncomment it.
                }
            }
            vim.keymap.set('n', '<leader>tw', function() vim.fn['typst#TypstWatch']() end, { silent = true })
        end
    },

    -- {
    --     "ray-x/lsp_signature.nvim",
    --     event = "VeryLazy",
    --     opts = {},
    --     config = function(_, _)
    --         -- Get signatures (and _only_ signatures) when in argument lists.
    --         require "lsp_signature".setup({
    --             doc_lines = 0,
    --             handler_opts = {
    --                 border = "none"
    --             },
    --             hint_prefix = "",
    --         })
    --     end
    -- }
}
