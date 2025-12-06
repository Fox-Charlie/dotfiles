-- Mason first
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "rust_analyzer" },
    automatic_install = true,
})

require("mason-tool-installer").setup({
    ensure_installed = {
        -- Formatters
        "stylua",
        "black",
        "isort",
        "prettier",
        "rustfmt",
        -- Linters
        "ruff",
        "eslint_d",
    },
    auto_update = false,
    run_on_start = true,
})

-- Global LSP defaults (Neovim 0.11+)
local capabilities = require("blink.cmp").get_lsp_capabilities()
local on_attach = function(_, bufnr)
    local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr }) end
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "K", vim.lsp.buf.hover)
end

-- Apply to all servers (Neovim 0.11+)
vim.lsp.config('*', {
    capabilities = capabilities,
    on_attach = on_attach,
})
