return {
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        build = ":Neorg sync-parsers",
        -- tag = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- This is to deal with neorg concealing not working properly
            -- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
            --     pattern = {"*.norg"},
            --     command = "set conceallevel=3"
            -- })

            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},  -- Loads default behaviour
                    ["core.concealer"] = {}, -- Adds pretty icons to your documents
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp"
                        }
                    },
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/Dropbox/Notes"
                            },
                        },
                    },
                },
            }
        end,
    },
}
