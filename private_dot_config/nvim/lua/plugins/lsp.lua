require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "rust_analyzer", "tflint" },
	automatic_enable = { exclude = { "jedi_language_server" } },
})
require("mason-tool-installer").setup({
	ensure_installed = { "stylua", "prettier", "ruff", "eslint_d", "debugpy" },
})

local fzf = require("fzf-lua")
local basedpyright_root_markers = {
	"pyrightconfig.json",
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	".git",
}

local function find_uv_workspace_root(path)
	local stat = vim.uv.fs_stat(path)
	if stat and stat.type == "file" then
		path = vim.fs.dirname(path)
	end

	local pyprojects = vim.fs.find("pyproject.toml", {
		path = path,
		upward = true,
		type = "file",
		limit = math.huge,
	})

	for _, pyproject in ipairs(pyprojects) do
		local ok, lines = pcall(vim.fn.readfile, pyproject)
		if ok then
			for _, line in ipairs(lines) do
				if line:match("^%[tool%.uv%.workspace%]%s*$") then
					return vim.fs.dirname(pyproject)
				end
			end
		end
	end
end

local function find_python_path(root_dir)
	local venv = vim.fs.find(".venv", { path = root_dir, upward = true, type = "directory" })[1]
	if not venv then
		return nil
	end

	local suffix = vim.fn.has("win32") == 1 and "/Scripts/python.exe" or "/bin/python"
	local python_path = venv .. suffix
	if vim.uv.fs_stat(python_path) then
		return python_path
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Override built-in LSP mappings with fzf-lua pickers
		map("n", "grr", fzf.lsp_references, "Go to references")
		map("n", "gd", fzf.lsp_definitions, "Go to definition")
		map("n", "gi", fzf.lsp_implementations, "Go to implementation")
		map("n", "gy", fzf.lsp_typedefs, "Go to type definition")

		-- Additional mappings (gD, K, gra, grn are built-in defaults in 0.11+)
		map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		map("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, "Toggle inlay hints")
	end,
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("basedpyright", {
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root_dir = find_uv_workspace_root(fname)
			or vim.fs.root(bufnr, basedpyright_root_markers)
			or vim.fs.dirname(fname)
		on_dir(root_dir)
	end,
	before_init = function(_, config)
		local python_path = find_python_path(config.root_dir)
		if not python_path then
			return
		end

		config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
			python = {
				pythonPath = python_path,
			},
		})
	end,
})
