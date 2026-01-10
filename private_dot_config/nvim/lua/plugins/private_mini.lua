-- mini.ai - Extend and create a/i textobjects
require("mini.ai").setup({
  n_lines = 500,
  custom_textobjects = nil,
})

-- mini.surround - Fast surround actions
require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    find = "",
    find_left = "",
    highlight = "",
    replace = "cs",
    update_n_lines = "",
    suffix_last = "",
    suffix_next = "",
  },
  n_lines = 20,
  search_method = "cover_or_next",
  custom_surroundings = {
    ["("] = { output = { left = "(", right = ")" } },
    ["["] = { output = { left = "[", right = "]" } },
    ["{"] = { output = { left = "{", right = "}" } },
    ["<"] = { output = { left = "<", right = ">" } },
  },
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
