-- Telescope keymaps
local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fw", telescope_builtin.grep_string, { desc = "Find word under cursor" })
vim.keymap.set("n", "<leader>fc", telescope_builtin.commands, { desc = "Find commands" })
vim.keymap.set("n", "<leader>fk", telescope_builtin.keymaps, { desc = "Find keymaps" })
vim.keymap.set("n", "<leader>fs", telescope_builtin.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "Diagnostics" })

-- LSP keymaps (set in on_attach in lsp.lua, but here are some additional ones)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "Go to references" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>ds", telescope_builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace symbols" })

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
