return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                lua = { "stylua" },
                svelte = { "prettierd", "prettier" },
                nix = { "alejandra" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                graphql = { "prettierd", "prettier" },
                java = { "google-java-format" },
                kotlin = { "ktlint" },
                ruby = { "standardrb" },
                markdown = { "prettierd", "prettier" },
                erb = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                bash = { "beautysh" },
                proto = { "buf" },
                python = { "black" },
                rust = { "rustfmt" },
                go = { "gofmt" },
                yaml = { "yamlfix" },
                toml = { "taplo" },
                typst = { "typstyle" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>l", function()
            conform.format({
                lsp_format = "fallback",
                quiet = true,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
