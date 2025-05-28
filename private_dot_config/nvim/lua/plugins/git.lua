local M = {}

function M.gitsigns()
  require("gitsigns").setup({
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
  })
end

return M
