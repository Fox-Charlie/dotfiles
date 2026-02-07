local dap = require("dap")
local dapui = require("dapui")

-- UI setup
dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "breakpoints", size = 0.1 },
				{ id = "stacks", size = 0.3 },
				{ id = "watches", size = 0.2 },
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			position = "bottom",
			size = 10,
		},
	},
})

-- Virtual text
require("nvim-dap-virtual-text").setup()

-- Python adapter (Mason-installed debugpy)
require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

-- Gutter signs
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

-- Auto open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Keymaps (F5 and leader-db are in lazy.lua as load triggers)
local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

map("n", "<F10>", dap.step_over, "Debug: Step Over")
map("n", "<F11>", dap.step_into, "Debug: Step Into")
map("n", "<F12>", dap.step_out, "Debug: Step Out")
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Debug: Conditional Breakpoint")
map("n", "<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Debug: Log Point")
map("n", "<leader>dr", dap.repl.open, "Debug: Open REPL")
map("n", "<leader>dc", dap.run_last, "Debug: Run Last")
map("n", "<leader>du", dapui.toggle, "Debug: Toggle UI")
map("n", "<leader>dt", dap.terminate, "Debug: Terminate")
map({ "n", "v" }, "<leader>de", dapui.eval, "Debug: Evaluate Expression")
