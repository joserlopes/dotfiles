return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})

        local npairs = require("nvim-autopairs")
        local rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")
        npairs.add_rules({ rule("|", "|", { "rust", "go", "lua" }):with_move(cond.after_regex("|")) })
        npairs.add_rules({ rule("<", ">", { "rust", }):with_move(cond.after_regex("<")) })
        npairs.add_rules({ rule("$", "$", { "typst", }):with_move(cond.after_regex("$")) })
    end,
}
