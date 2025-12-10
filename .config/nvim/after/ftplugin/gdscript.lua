local opt = vim.opt
local port = os.getenv('GDScript_Port') or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
local pipe = '/tmp/godot.pipe' -- I use /tmp/godot.pipe

local on_attach = function(client, bufnr)
  vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
  vim.diagnostic.config({
    float = {
      source = "always"
    }
  })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set("n", "<leader>gt", vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = 0 })
  vim.keymap.set("n", "<leader>dt", vim.lsp.buf.type_definition, { buffer = 0 })
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = 0 })
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
end

vim.lsp.start({
  name = 'Godot',
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
  on_attach = on_attach
})

opt.shiftwidth = 4
opt.expandtab = false
opt.tabstop = 4
opt.autoindent = true
