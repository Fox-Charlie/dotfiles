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
vim.opt.clipboard = "unnamedplus"
vim.opt.winborder = "rounded"
vim.opt.smoothscroll = true
vim.opt.splitkeep = "screen"
vim.opt.jumpoptions = "stack,view"

-- Folds start fully open (foldexpr is set per-buffer on LspAttach)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Auto-reload files changed externally (useful for AI coding tools)
vim.opt.autoread = true
vim.opt.updatetime = 300
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
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
		vim.hl.on_yank({ higroup = "DiffAdd", timeout = 150 })
	end,
})

-- Diagnostics
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	underline = true,
	signs = true,
	severity_sort = true,
	float = { border = "rounded" },
})

-- Load plugin manager
require("config.lazy")

-- Load colorscheme
require("plugins.colourscheme")

-- Load keymaps
require("config.keymaps")
