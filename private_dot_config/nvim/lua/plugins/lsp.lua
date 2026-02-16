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
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Override built-in LSP mappings with fzf-lua pickers
		map("n", "grr", fzf.lsp_references, "Go to references")
		map("n", "gd", fzf.lsp_definitions, "Go to definition")
		map("n", "gi", fzf.lsp_implementations, "Go to implementation")
		map("n", "gy", fzf.lsp_typedefs, "Go to type definition")

		-- Additional mappings (gD, K, gra, grn are built-in defaults in 0.11+)
		map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		map("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, "Toggle inlay hints")
	end,
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
