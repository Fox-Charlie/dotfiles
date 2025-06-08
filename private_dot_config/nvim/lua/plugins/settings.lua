-- Basic settings
vim.opt.compatible = false        -- Disable Vi compatibility
vim.opt.showmatch = true          -- Show matching brackets
vim.opt.ignorecase = true         -- Case-insensitive searching...
vim.opt.smartcase = true          -- ...unless you use capital letters
vim.opt.mouse = "a"               -- Enable mouse in all modes
vim.opt.hlsearch = true           -- Highlight all search matches
vim.opt.incsearch = true          -- Show search matches as you type

-- Tabs and indentation
vim.opt.tabstop = 4               -- A tab is 4 spaces
vim.opt.softtabstop = 4           -- Soft tab behavior
vim.opt.shiftwidth = 4            -- Indentation amount
vim.opt.expandtab = true          -- Use spaces instead of tabs
vim.opt.autoindent = true         -- Auto-indent new lines

-- UI enhancements
-- vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true
vim.opt.wildmode = { "longest", "list" } -- Tab completion behavior
vim.opt.colorcolumn = "120"        -- Line length marker at 80 columns
vim.opt.cursorline = true         -- Highlight current line
vim.opt.ttyfast = true            -- Speed up scrolling
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- File type and syntax
vim.cmd("syntax on")              -- Enable syntax highlighting
vim.cmd("filetype plugin indent on") -- Enable filetype-based plugins and indenting

-- Highlighting on yank (flash)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "DiffAdd", -- Or "Search" or any other highlight group
      timeout = 150,         -- milliseconds
    })
  end,
})
