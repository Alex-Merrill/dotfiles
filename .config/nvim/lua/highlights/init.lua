local palette = require "highlights.colorscheme"

local hl = function(thing, opts)
  vim.api.nvim_set_hl(0, thing, opts)
end

local dark_blue = palette.bg_dark -- darker than bg
local light_blue = palette.bg_highlight -- lighter than bg
local even_lighter_blue = "#2e3c59" -- even lighter than light_blue
local bg_blue = palette.bg -- bg color

local highlight_groups = {
  -- telescope
  -- cursorline
  { "TelescopeSelection", { bg = light_blue } },

  -- input line/border
  { "TelescopePromptTitle", { fg = palette.cyan, bg = even_lighter_blue } },
  { "TelescopePromptNormal", { fg = palette.cyan, bg = even_lighter_blue } },
  { "TelescopePromptBorder", { bg = even_lighter_blue } },

  -- results
  { "TelescopeResultsTitle", { fg = palette.cyan, bg = bg_blue } },
  { "TelescopeResultsNormal", { fg = palette.cyan, bg = dark_blue } },
  { "TelescopeResultsBorder", { bg = bg_blue } },

  -- preview
  { "TelescopePreviewTitle", { fg = palette.cyan, bg = bg_blue } },
  { "TelescopePreviewDirectory", { fg = palette.magenta } },
  { "TelescopepreviewNormal", { fg = palette.cyan, bg = dark_blue } },
  { "TelescopePreviewBorder", { bg = bg_blue } },

  { "TelescopeNormal", { fg = palette.light1, bg = palette.dark0_hard } },
}

-- set custom telescope highlights
for _, pair in pairs(highlight_groups) do
  hl(pair[1], pair[2])
end

-- set colorscheme and cursor/line colorcoloumn colors
vim.g.tokyonight_style = "storm"
vim.cmd "colorscheme tokyonight"
vim.cmd "hi CursorLine cterm=underline guibg=#303540"
vim.cmd "hi ColorColumn ctermbg=1 guibg=#303540"
