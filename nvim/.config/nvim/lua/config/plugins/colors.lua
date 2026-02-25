return {

    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local everforest = require("everforest")
            everforest.setup({
                background = "hard",
                -- This is for enabling transparent background
                transparent_background_level = 1,
                italics = true,

                on_highlights = function(hl, palette)
                    hl["@comment.documentation.rust"] = { fg = palette.aqua, italic = true }
                    hl["@lsp.type.comment.rust"] = { fg = palette.aqua, italic = true }
                    hl.TSComment = { fg = "#928374", italic = true }
                end,
            })
            vim.cmd.colorscheme("everforest")
        end,
    },

    {
        "thesimonho/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa-paper").setup({
                overrides = function(colors)
                    return {
                        ["@comment.documentation"] = { fg = colors.palette.waveAqua2, italic = true },
                        ["@comment"] = { fg = colors.palette.canvasAsh1, italic = true },
                    }
                end,
            })
            -- vim.cmd.colorscheme("kanagawa-paper")
        end,
    },

}
