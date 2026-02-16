local actions = require("diffview.actions")

require("diffview").setup({
	enhanced_diff_hl = true,
	use_icons = true,
	view = {
		merge_tool = {
			layout = "diff3_mixed",
			disable_diagnostics = true,
		},
	},
	keymaps = {
		view = {
			{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS" } },
			{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS" } },
			{ "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose BASE" } },
			{ "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose ALL" } },
			{ "n", "<leader>cx", actions.conflict_choose("none"), { desc = "Choose NONE" } },
			{ "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
			{ "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
		},
		file_panel = {
			{ "n", "j", actions.next_entry, { desc = "Next entry" } },
			{ "n", "k", actions.prev_entry, { desc = "Previous entry" } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open file" } },
			{ "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
			{ "n", "S", actions.stage_all, { desc = "Stage all" } },
			{ "n", "U", actions.unstage_all, { desc = "Unstage all" } },
			{ "n", "X", actions.restore_entry, { desc = "Restore to index" } },
			{ "n", "R", actions.refresh_files, { desc = "Refresh" } },
		},
	},
})

