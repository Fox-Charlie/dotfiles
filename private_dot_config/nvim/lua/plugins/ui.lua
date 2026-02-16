require("lualine").setup({
  options = { theme = "gruvbox" },
  sections = {
    lualine_c = { "filename" },
    lualine_x = { "filetype" },
  },
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
