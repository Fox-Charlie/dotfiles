-- Mason automatically installs servers you list in mason-lspconfig.
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "tsserver", "rust_analyzer" },
})

local lsp = require("lspconfig")
local on_attach = function(_, bufnr)
  local buf = vim.lsp.buf
  local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr }) end
  map("n", "gd", buf.definition)
  map("n", "K",  buf.hover)
end

-- Loop through servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in ipairs({ "lua_ls", "pyright", "tsserver", "rust_analyzer" }) do
  lsp[server].setup({ on_attach = on_attach, capabilities = capabilities })
end
