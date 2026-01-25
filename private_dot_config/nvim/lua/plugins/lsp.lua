require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "rust_analyzer" },
})
require("mason-tool-installer").setup({
    ensure_installed = { "stylua", "prettier", "ruff", "eslint_d" },
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

        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
    end,
})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("basedpyright", {
    before_init = function(_, config)
        if vim.env.VIRTUAL_ENV then
            config.settings.python = { pythonPath = vim.env.VIRTUAL_ENV .. "/bin/python" }
        end
    end,
})

vim.lsp.enable({ "basedpyright", "lua_ls", "ts_ls", "rust_analyzer" })
