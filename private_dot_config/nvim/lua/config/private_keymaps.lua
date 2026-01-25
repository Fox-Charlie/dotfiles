-- Neotree
vim.keymap.set(
	"n",
	"<leader>n",
	"<cmd>Neotree toggle<CR>",
	{ desc = "Toggle file explorer", silent = true, nowait = true }
)

-- Dashboard
vim.keymap.set("n", "<leader>sd", function()
	Snacks.dashboard()
end, { desc = "Open dashboard" })

-- Fuzzy finder keymaps
local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fo", fzf.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fc", fzf.commands, { desc = "Find commands" })
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fS", fzf.lsp_document_symbols, { desc = "Find symbols (file)" })
vim.keymap.set("n", "<leader>fs", fzf.lsp_live_workspace_symbols, { desc = "Find symbols (workspace)" })
vim.keymap.set("n", "<leader>fd", fzf.diagnostics_workspace, { desc = "Diagnostics" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic quickfix list" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer", silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Clear search highlighting
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })

-- Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file", silent = true })
