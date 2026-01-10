-- Simple, clean Neotree configuration for an IDE-like experience
require("neo-tree").setup({
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = true,

	window = {
		position = "left",
		width = 30,
		mappings = {
			["l"] = "open",
			["<cr>"] = "open",
			["h"] = "close_node",
			["s"] = "open_vsplit",
			["v"] = "open_split",
			["a"] = "add",
			["d"] = "delete",
			["r"] = "rename",
			["R"] = "refresh",
			["?"] = "show_help",
		},
	},

	filesystem = {
		follow_current_file = {
			enabled = true,
		},
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = true,
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				".git",
				".DS_Store",
				"thumbs.db",
			},
		},
	},

	default_component_configs = {
		git_status = {
			symbols = {
				added = "✚",
				modified = "",
				deleted = "✖",
				renamed = "󰁕",
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
})

-- Auto-open Neotree when opening a real file
local neotree_opened = false
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	callback = function()
		local buftype = vim.bo.buftype
		local filetype = vim.bo.filetype
		-- Only open for real files, not special buffers like dashboard
		if buftype == "" and filetype ~= "dashboard" and filetype ~= "" and not neotree_opened then
			neotree_opened = true
			vim.cmd("Neotree show")
		end
	end,
})
