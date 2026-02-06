vim.loader.enable()

-- Basic settings
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- UI enhancements
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wildmode = { "longest", "list" }
vim.opt.colorcolumn = "120"
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'

-- Auto-reload files changed externally (useful for AI coding tools)
vim.opt.autoread = true
vim.opt.updatetime = 300
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	callback = function()
		if vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "DiffAdd", timeout = 150 })
	end,
})

-- Load plugin manager
require("config.lazy")

-- Load colorscheme
require("plugins.colourscheme")

-- Load keymaps
require("config.keymaps")
