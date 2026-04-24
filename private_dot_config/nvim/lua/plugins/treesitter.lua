local parsers = {
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"dockerfile",
	"editorconfig",
	"git_config",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"hcl",
	"html",
	"ini",
	"javascript",
	"json",
	"jsonc",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"python",
	"requirements",
	"rust",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"xml",
	"yaml",
	"zig",
	"vim",
	"vimdoc",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype
		local lang = vim.treesitter.language.get_lang(ft) or ft
		if not pcall(vim.treesitter.start, buf, lang) then
			return
		end
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
