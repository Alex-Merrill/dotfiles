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

local vmap = function(keybind, cmd, bufnr)
  keymap("v", keybind, cmd, bufnr)
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

-- Notifications
nmap("<leader>nh", "<cmd>lua require('telescope').extensions.notify.notify()<cr>")
nmap("<leader>nd", "<cmd> lua vim.notify.dismiss()<cr>")

-- nvim-tree
nmap("<leader>to", "<cmd>NvimTreeRefresh | NvimTreeToggle<cr>")

-- copy paste global
nmap("<leader>y", '"+y')
nmap("<leader>p", '"+p')
vmap("<leader>y", '"+y')
vmap("<leader>p", '"+p')

-- trouble
nmap("<leader>db", "<cmd>Trouble diagnostics toggle<cr>")
vmap("<leader>db", "<cmd>Trouble diagnostics toggle<cr>")


-- diffview map
nmap("<leader>gd", "<cmd>lua require('plugins.diffview').toggleDiffview()<cr>")

-- utils
nmap("<leader>r", "<cmd>lua reload_nvim_conf()<cr>")

-- window resizing
nmap("<A-->", "<cmd>res-1<cr>")
nmap("<A-=>", "<cmd>res+1<cr>")
nmap("<A-_>", "<cmd>vert res-1<cr>")
nmap("<A-+>", "<cmd>vert res+1<cr>")

-- emoji picker
nmap("<leader>e", "<cmd>IconPickerNormal<cr>")

-- general
nmap("<leader>bb", "<C-^>")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-h>", "<C-w>h")
nmap("<C-l>", "<C-w>l")
imap("<C-j>", "<esc><C-w>j")
imap("<C-k>", "<esc><C-w>k")
imap("<C-h>", "<esc><C-w>h")
imap("<C-l>", "<esc><C-w>l")

-- leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- terminal
nmap("<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>")
nmap("<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>")
nmap("<leader>tf", "<cmd>ToggleTerm direction=float<cr>")
nmap("<leader>st", function()
  require("toggleterm").send_lines_to_terminal("single_line", false, { args = vim.v.count })
end)
vmap("<leader>st", function()
  require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
end)
