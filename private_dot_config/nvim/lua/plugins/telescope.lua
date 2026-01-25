require("telescope").setup({
  defaults = {
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
    },
  },
})
