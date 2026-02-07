-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Core libraries
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", lazy = true },

		-- Dev tooling
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = { library = { "lazy.nvim" } },
		},

		-- UI
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			config = function()
				require("plugins.snacks")
			end,
		},
		{
			"nvim-lualine/lualine.nvim",
			event = "VeryLazy",
			config = function()
				require("plugins.ui")
			end,
		},

		-- File Management
		{
			"stevearc/oil.nvim",
			opts = {},
			keys = {
				{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
				{ "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil" },
			},
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
			cmd = "Neotree",
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				require("plugins.neotree")
			end,
		},

		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("plugins.treesitter")
			end,
		},

		-- Fuzzy finder
		{
			"ibhagwan/fzf-lua",
			opts = { lsp = { symbols = { async_or_timeout = 5000 } } }, -- add "skim" to opts for skim fuzzy finder
		},

		-- LSP / Completion
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
			config = function()
				require("plugins.lsp")
			end,
		},
		{
			"saghen/blink.cmp",
			version = "1.*",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				require("plugins.cmp")
			end,
		},

		-- Formatting & Linting
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("plugins.conform")
			end,
		},
		{
			"mfussenegger/nvim-lint",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("plugins.lint")
			end,
		},

		-- Debugging
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				"rcarriga/nvim-dap-ui",
				"nvim-neotest/nvim-nio",
				"mfussenegger/nvim-dap-python",
				"theHamsta/nvim-dap-virtual-text",
			},
			keys = {
				{
					"<F5>",
					function()
						require("dap").continue()
					end,
					desc = "Debug: Start/Continue",
				},
				{
					"<leader>db",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "Debug: Toggle Breakpoint",
				},
			},
			config = function()
				require("plugins.dap")
			end,
		},

		-- Git
		{
			"lewis6991/gitsigns.nvim",
			event = "BufReadPre",
			config = function()
				require("plugins.git")
			end,
		},
		-- "tpope/vim-fugitive",
		-- { "sindrets/diffview.nvim", cmd = { "DiffviewOpen" } },

		-- Misc
		{
			"echasnovski/mini.nvim",
			event = "VeryLazy",
			config = function()
				require("plugins.mini")
			end,
		},
		{ "folke/trouble.nvim", cmd = "Trouble", config = true },
		{ "nvim-pack/nvim-spectre", cmd = "Spectre" },

		-- Colorscheme
		-- { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
		{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true, notify = false },
})
