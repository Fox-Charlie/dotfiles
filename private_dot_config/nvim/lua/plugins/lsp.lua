-- Mason first
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ruff", "ts_ls", "rust_analyzer" },
  automatic_enable = true,
})

-- Global LSP defaults (Neovim 0.11+)
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr }) end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K",  vim.lsp.buf.hover)
end

-- Apply to all servers (Neovim 0.11+)
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach   = on_attach,
})
