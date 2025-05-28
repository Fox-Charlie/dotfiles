local M = {}

function M.setup()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
    },
  })
  -- Convenience keymaps
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep"  })
end

return M
