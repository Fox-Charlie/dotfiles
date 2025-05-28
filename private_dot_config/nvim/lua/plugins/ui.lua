local M = {}

function M.lualine()
  require("lualine").setup({
    options = {
      theme = "gruvbox",
      icons_enabled = true,
    },
    sections = {
      lualine_c = { "filename", "require'lsp-status'.status()" },
      lualine_x = { "filetype" },
    },
  })
end

-- nvim-autopairs and which-key need no extra setup when `config=true`

return M
