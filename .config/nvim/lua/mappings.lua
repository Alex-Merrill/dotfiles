local set = vim.keymap.set

local keymap = function(mode, keybind, cmd, bufnr)
  -- Some default options
  local opts = { noremap = true, silent = true }

  if bufnr ~= nil then
    opts["buffer"] = bufnr
    set(mode, keybind, cmd, opts)
  else
    set(mode, keybind, cmd, opts)
  end
end

local nmap = function(keybind, cmd, bufnr)
  keymap("n", keybind, cmd, bufnr)
end

local imap = function(keybind, cmd, bufnr)
  keymap("i", keybind, cmd, bufnr)
end

-- remap leader
vim.g.mapleader = " "

-- Telescope maps
nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nmap("<leader>fb", "<cmd>Telescope file_browser<cr>")
nmap("<leader>fn", "<cmd>lua require('telescope').extensions.notify.notify()<cr>")

-- nvim-tree
nmap("<leader>to", "<cmd>NvimTreeRefresh | NvimTreeFocus<cr>")
nmap("<leader>tc", "<cmd>NvimTreeClose<cr>")

-- copy paste global
nmap("<leader>y", [["+y]])
nmap("<leader>p", [["+p]])

-- lsp lines toggle
nmap("<leader>l", require("lsp_lines").toggle)
