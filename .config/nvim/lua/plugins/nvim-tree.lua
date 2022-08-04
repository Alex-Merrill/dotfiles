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
}
