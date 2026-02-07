require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "jedi_language_server", "ts_ls", "rust_analyzer", "tflint" },
})
require("mason-tool-installer").setup({
	ensure_installed = { "stylua", "prettier", "ruff", "eslint_d", "debugpy" },
})

local fzf = require("fzf-lua")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gr", fzf.lsp_references, "Go to references")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
		map("n", "K", vim.lsp.buf.hover, "Hover documentation")
		map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, "Toggle inlay hints")
	end,
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable({ "jedi_language_server", "lua_ls", "ts_ls", "rust_analyzer" })
