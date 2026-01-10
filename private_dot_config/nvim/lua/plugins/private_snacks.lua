-- Helper function to open symbol search with LSP check
local function find_workspace_symbols()
	-- Check if there are any LSP clients attached
	local clients = vim.lsp.get_clients()
	if #clients > 0 then
		-- LSP is already active, just run the command
		require("telescope.builtin").lsp_dynamic_workspace_symbols()
	else
		-- No LSP active, open a recent file first, then run symbol search
		vim.notify("Opening workspace to activate LSP...", vim.log.levels.INFO)
		-- Find a recent file that would have LSP
		local files = vim.fn.systemlist("find . -type f -name '*.lua' -o -name '*.py' -o -name '*.js' -o -name '*.ts' -o -name '*.rs' 2>/dev/null | head -1")
		if #files > 0 and files[1] ~= "" then
			vim.cmd("edit " .. files[1])
			-- Wait a bit for LSP to attach, then run symbol search
			vim.defer_fn(function()
				require("telescope.builtin").lsp_dynamic_workspace_symbols()
			end, 500)
		else
			vim.notify("No project files found. Open a file first.", vim.log.levels.WARN)
		end
	end
end

require("snacks").setup({
	-- Enable recommended modules
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
				{ icon = "󰍉 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = "󰊄", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = "󰊕 ", key = "y", desc = "Find Symbol", action = ":lua _G.find_workspace_symbols()" },
				{ icon = "󰁯 ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{
					icon = " ",
					key = "c",
					desc = "Config",
					action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
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

-- Export symbol search function globally for dashboard use
_G.find_workspace_symbols = find_workspace_symbols
