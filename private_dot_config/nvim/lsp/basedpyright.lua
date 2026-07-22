local root_markers = {
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

return {
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root_dir = find_uv_workspace_root(fname)
			or vim.fs.root(bufnr, root_markers)
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
}
