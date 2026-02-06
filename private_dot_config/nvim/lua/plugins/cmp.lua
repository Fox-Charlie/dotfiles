require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_and_accept", "fallback" },
	},
	sources = { default = { "lsp", "path", "snippets" } },
	completion = {
		menu = { border = "rounded" },
		documentation = { auto_show = true, window = { border = "rounded" } },
	},
	signature = { enabled = true, window = { border = "rounded" } },
})
