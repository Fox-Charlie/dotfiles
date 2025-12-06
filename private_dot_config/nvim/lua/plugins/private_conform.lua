local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        rust = { "rustfmt" },
    },
    default_format_opts = {
        timeout_ms = 3000,
        async = false,
        lsp_format = "fallback",
    },
    format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
    },
})

-- Keymap to format current buffer
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 3000,
    })
end, { desc = "Format file or range (in visual mode)" })
