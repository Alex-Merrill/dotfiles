require("nvim-tree").setup {
  sort_by = "name",
  open_on_setup = false,
  hijack_directories = {
    enable = false,
    auto_open = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
}
