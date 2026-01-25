require("snacks").setup({
	bigfile = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	indent = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },

	-- Dashboard configuration (migrated from alpha.nvim)
	dashboard = {
		enabled = true,
		width = 60,
		preset = {
			-- 		header = [[
			--   ▄▄     ▄▄▄
			--   ██▄   ██▀
			--   ███▄  ██                   ▀▀ ▄
			--   ██ ▀█▄██ ▄█▀█▄ ▄███▄▀█▄ ██▀██ ███▄███▄
			--   ██   ▀██ ██▄█▀ ██ ██ ██▄██ ██ ██ ██ ██
			-- ▀██▀    ██▄▀█▄▄▄▄▀███▀  ▀█▀ ▄██▄██ ██ ▀█
			--            ]],
			--             header = [[
			--  ██████   █████                                ███
			-- ░░██████ ░░███                                ░░░
			--  ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████
			--  ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███
			--  ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███
			--  ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███
			--  █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████
			-- ░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░
			--             ]],
			header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
            ]],
			keys = {
				{ icon = "󰍉 ", key = "f", desc = "Find File", action = ":FzfLua files" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = "󰊄", key = "g", desc = "Find Text", action = ":FzfLua live_grep" },
				{ icon = "󰊕 ", key = "y", desc = "Find Symbol", action = ":FzfLua lsp_live_workspace_symbols" },
				{ icon = "󰁯 ", key = "r", desc = "Recent Files", action = ":FzfLua oldfiles" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":FzfLua files cwd=~/.config/nvim",
				},
				{ icon = "󱀸 ", key = "s", desc = "Restore Session", section = "session" },
				{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
				{ icon = "󱠢 ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		formats = {
			icon = function(item)
				if item.file and item.icon == "file" or item.icon == "directory" then
					return require("snacks.dashboard").icon(item.file, item.icon)
				else
					return { item.icon, width = 2, hl = "icon" }
				end
			end,
			footer = { "%s", align = "center" },
			header = { "%s", align = "center" },
		},
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{ section = "startup" },
		},
	},
})

-- Setup keymaps for snacks features
vim.keymap.set("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss notifications" })
vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "Git blame line" })
vim.keymap.set("n", "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git browse" })
vim.keymap.set("n", "<leader>gf", function()
	Snacks.lazygit.log_file()
end, { desc = "Lazygit file history" })
vim.keymap.set("n", "<leader>gl", function()
	Snacks.lazygit.log()
end, { desc = "Lazygit log" })
vim.keymap.set("n", "<leader>nh", function()
	Snacks.notifier.show_history()
end, { desc = "Notification history" })

