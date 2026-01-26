return {
	"L3MON4D3/LuaSnip",
    lazy = true,
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v2.*",
	build = "make install_jsregexp",
	config = function()
		-- NOTE: Are this really useful? I feel like they just waste space...
		-- require("luasnip.loaders.from_vscode").lazy_load()

		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		vim.keymap.set({ "i", "s" }, "<A-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<A-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		ls.add_snippets("zig", {
			s("..", {
				t(".{ "),
				i(1),
				t(" }"),
			}),
		})
	end,
}
