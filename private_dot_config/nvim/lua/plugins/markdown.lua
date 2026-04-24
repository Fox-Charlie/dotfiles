require("render-markdown").setup({
	-- Render in all markdown buffers (including help, etc.)
	file_types = { "markdown" },
	-- Use rounded style for code blocks
	code = {
		sign = false,
		width = "block",
		right_pad = 1,
	},
	heading = {
		sign = false,
		icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
	},
})

-- Keymaps: <leader>m prefix (markdown)
vim.keymap.set("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", { desc = "Markdown: Toggle render" })
vim.keymap.set("n", "<leader>me", "<cmd>RenderMarkdown enable<CR>", { desc = "Markdown: Enable render" })
vim.keymap.set("n", "<leader>md", "<cmd>RenderMarkdown disable<CR>", { desc = "Markdown: Disable render" })
