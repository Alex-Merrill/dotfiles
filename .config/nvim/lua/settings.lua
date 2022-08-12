local opt = vim.opt

-- firenvim
vim.cmd [[
  let g:firenvim_config = { 
      \ 'globalSettings': {
          \ 'alt': 'all',
      \  },
      \ 'localSettings': {
          \ '.*': {
              \ 'cmdline': 'firenvim',
              \ 'priority': 0,
              \ 'takeover': 'never',
          \ },
      \ }
  \ }
]]

-- options

-- indent
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- wrapping
opt.wrap = false
opt.breakindent = true
opt.linebreak = true
vim.cmd [[set formatoptions-=cro]]

-- line numbers
opt.number = true
opt.relativenumber = true

-- don't save on switching buffers
opt.hidden = true

-- text search
opt.hlsearch = false
opt.incsearch = true

-- completion
opt.completeopt = "menu,menuone,noselect"

-- scroll off behavior
opt.scrolloff = 8
opt.sidescrolloff = 4

-- swaps and undos
local undodir = os.getenv "HOME" .. "/.nvim"
if vim.fn.isdirectory(undodir) == 0 then
  os.execute("mkdir " .. undodir)
end
if vim.fn.isdirectory(undodir .. "/undodir") == 0 then
  os.execute("mkdir " .. undodir .. "/undodir")
end
opt.swapfile = false
opt.undodir = undodir .. "/undodir"
opt.undofile = true

-- some ui stuff
opt.colorcolumn = "80"
opt.cmdheight = 2
opt.cursorline = true
opt.signcolumn = "auto:1-4"
opt.title = true

-- status line
opt.laststatus = 3

opt.guicursor = {
  "n-v-c-sm:block",
  "i-ci-ve:block",
}
opt.termguicolors = true

-- clipboard
opt.clipboard = "unnamed"
