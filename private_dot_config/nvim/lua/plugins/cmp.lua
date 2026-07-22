require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_and_accept", "fallback" },
	},
	sources = { default = { "lsp", "path", "snippets" } },
	completion = {
		documentation = { auto_show = true },
	},
	signature = { enabled = true },
})
