-- Mason first
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "rust_analyzer" },
    automatic_install = true,
})

require("mason-tool-installer").setup({
    ensure_installed = { "stylua", "prettier", "ruff", "eslint_d" },
})

-- Global LSP defaults (Neovim 0.11+)
local capabilities = require("blink.cmp").get_lsp_capabilities()
local fzf = require("fzf-lua")

local on_attach = function(client, bufnr)
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

    -- Enable inlay hints if supported
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

vim.lsp.config('*', { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config('basedpyright', {
    settings = { basedpyright = { analysis = { diagnosticMode = "workspace" } } },
})
