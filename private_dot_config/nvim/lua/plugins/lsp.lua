require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "rust_analyzer", "tflint" },
	automatic_enable = { exclude = { "jedi_language_server" } },
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

		-- Override built-in LSP mappings with fzf-lua pickers
		map("n", "grr", fzf.lsp_references, "Go to references")
		map("n", "gd", fzf.lsp_definitions, "Go to definition")
		map("n", "gi", fzf.lsp_implementations, "Go to implementation")
		map("n", "gy", fzf.lsp_typedefs, "Go to type definition")

		-- gD, K, gra, grn, <C-s> (signature in insert) are built-in defaults in 0.11+
		map("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, "Toggle inlay hints")

		-- LSP-driven folds where supported
		if client and client:supports_method("textDocument/foldingRange") then
			vim.wo[0][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"
		end
	end,
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
