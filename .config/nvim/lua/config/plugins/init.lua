return {
    "onsails/lspkind.nvim",

    "christoomey/vim-tmux-navigator",

    "RRethy/vim-illuminate",

    "folke/twilight.nvim",

    "xiyaowong/transparent.nvim",

    -- {
    --     "AlexvZyl/nordic.nvim",
    --     priority = 1000,
    --     config = function ()
    --         require("nordic").load()
    --         vim.cmd.colorscheme("nordic")
    --     end
    -- },

    -- {
    --     "sainnhe/gruvbox-material",
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme("gruvbox-material")
    --     end,
    -- },

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

    -- {
    --     "sainnhe/sonokai",
    --     name = "sonokai",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.g.sonokai_style =
    --         "andromeda" --  Available values: 'default', 'atlantis', 'andromeda', 'shusia', 'maia','espresso'
    --         vim.g.sonokai_enable_italic = 1
    --         vim.g.sonokai_transparent_background = 0
    --         vim.g.sonokai_diagnostic_text_highlight = 1
    --         vim.g.sonokai_diagnostic_line_highlight = 1
    --         vim.g.sonokai_diagnostic_virtual_text = "highlighted"
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

    {
        "RRethy/base16-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('base16-gruvbox-material-dark-hard')
            -- Different colorschemes
            --vim.cmd.colorscheme('base16-kanagawa')
            --vim.cmd.colorscheme('base16-everforest')
            --vim.cmd.colorscheme('base16-nord')
            --vim.cmd.colorscheme('base16-zenburn')
            --vim.cmd.colorscheme('base16-rose-pine')
        end
    },

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },

    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            -- Get signatures (and _only_ signatures) when in argument lists.
            require "lsp_signature".setup({
                doc_lines = 0,
                hint_prefix = "",
                handler_opts = {
                    border = "none"
                },
            })
        end
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
    --
    -- }
}
