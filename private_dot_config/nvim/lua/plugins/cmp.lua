require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<Tab>"] = { "select_and_accept", "fallback" },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
        menu = {
            draw = {
                treesitter = { "lsp" },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },
})
