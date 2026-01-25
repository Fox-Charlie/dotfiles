require("lualine").setup({
  options = { theme = "gruvbox" },
  sections = {
    lualine_c = { "filename" },
    lualine_x = { "filetype" },
  },
})
