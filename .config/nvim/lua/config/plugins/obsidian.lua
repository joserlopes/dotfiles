return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        require("obsidian").setup({
            workspaces = {
                -- Should I create an obsidian vault for each of the PARA folders?
                {
                    name = "Notes",
                    path = "~/Dropbox/Notes",
                },
                -- {
                --     name = "Area",
                --     path = "~/Dropbox/Notes/Area",
                -- },
                -- {
                --     name = "Resource",
                --     path = "~/Dropbox/Notes/Resource",
                -- },
                -- {
                --     name = "Archive",
                --     path = "~/Dropbox/Notes/Archive",
                -- },
            },
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,

                -- Trigger completion at 2 chars.
                min_chars = 2,

                -- Where to put new notes created from completion. Valid options are
                --  * "current_dir" - put new notes in same directory as the current buffer.
                --  * "notes_subdir" - put new notes in the default notes subdirectory.
                new_notes_location = "current_dir",

                -- Control how wiki links are completed with these (mutually exclusive) options:
                --
                -- 1. Whether to add the note ID during completion.
                -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
                -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
                prepend_note_id = true,
                -- 2. Whether to add the note path during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
                prepend_note_path = false,
                -- 3. Whether to only use paths during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
                use_path_only = false,
            },
            -- templates = {
            --     subdir = "Templates",
            --     date_format = "%d-%m-%Y",
            --     time_format = "%H:%M",
            -- },
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                -- vim.fn.jobstart({ "open", url }) -- Mac OS
                vim.fn.jobstart({ "xdg-open", url }) -- linux
            end,

            vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "[O]bsidian [O]pen" }),
            vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "[O]bsidian [N]ew" }),
            vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>", { desc = "[O]bsidian [B]acklinks" }),
            vim.keymap.set("n", "<leader>otd", ":ObsidianToday<CR>", { desc = "[O]bsidian [T]o[m]orrow" }),
            vim.keymap.set("n", "<leader>otm", ":ObsidianTomorrow<CR>", { desc = "[O]bsidian [T]o[d]ay" }),
            vim.keymap.set("n", "<leader>oyd", ":ObsidianYesterday<CR>", { desc = "[O]bsidian [Y]ester[d]ay" }),
            vim.keymap.set("n", "<leader>owp", ":ObsidianWorkspace Project<CR>",
                { desc = "[O]bsidian [W]orkspace [P]roject" }),
            vim.keymap.set("n", "<leader>owa", ":ObsidianWorkspace Area<CR>",
                { desc = "[O]bsidian [W]orkspace [A]rea" }),
            vim.keymap.set("n", "<leader>owr", ":ObsidianWorkspace Resource<CR>",
                { desc = "[O]bsidian [W]orkspace [R]esource" }),
            vim.keymap.set("n", "<leader>owc", ":ObsidianWorkspace Archive<CR>",
                { desc = "[O]bsidian [W]orkspace [A]rchive" }),
            vim.keymap.set("n", "<leader>ofl", ":ObsidianFollowLink<CR>", { desc = "[O]bsidian [F]ollow [L]ink" }),
        })
    end
}
