-- mini.ai - Extend and create a/i textobjects
require("mini.ai").setup({
  n_lines = 500,
  custom_textobjects = nil,
})

-- mini.surround - Fast surround actions
require("mini.surround").setup({
  mappings = {
    add = "sa",            -- Add surrounding in Normal and Visual modes
    delete = "sd",         -- Delete surrounding
    find = "sf",           -- Find surrounding (to the right)
    find_left = "sF",      -- Find surrounding (to the left)
    highlight = "sh",      -- Highlight surrounding
    replace = "sr",        -- Replace surrounding
    update_n_lines = "sn", -- Update `n_lines`
  },
  n_lines = 20,
})

-- mini.comment - Comment code
require("mini.comment").setup({
  options = {
    custom_commentstring = nil,
    ignore_blank_line = false,
    start_of_line = false,
    pad_comment_parts = true,
  },
  mappings = {
    comment = "gc",
    comment_line = "gcc",
    comment_visual = "gc",
    textobject = "gc",
  },
})
