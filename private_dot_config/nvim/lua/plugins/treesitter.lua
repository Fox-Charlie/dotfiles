local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "html",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "rust",
            "zig",
            "vim",
            "vimdoc",
        },
    autoinstall = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
