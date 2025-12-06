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
