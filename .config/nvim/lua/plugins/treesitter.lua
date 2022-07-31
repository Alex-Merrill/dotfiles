require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript", "typescript" },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      disable = {},
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ao"] = "@class.outer",
        ["io"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["id"] = "@comment.inner",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
      },
    },
  },
}
