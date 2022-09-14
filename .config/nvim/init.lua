-- bootstrap packer if not found
local fn = vim.fn
local api = vim.api
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
   vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.cmd [[ packadd packer.nvim ]]
require('packer').startup(function(use)
   -- make sure to add this line to let packer manage itself
   use 'wbthomason/packer.nvim'

   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
   if packer_bootstrap then
     require('packer').sync()
   end
end)


api.nvim_create_autocmd("BufWritePost", {
  group = api.nvim_create_augroup("Packer", { clear = true }),
  callback = function(args)
    if api.nvim_buf_get_name(args.buf):find "/plugins/init.lua" then
      vim.cmd [[ PackerClean]]
      vim.cmd [[ PackerCompile profile=true ]]
      vim.notify("Cleaned compiled packer!", vim.log.levels.INFO, { title = "Packer", timeout = 1000 })
    end
  end,
})

local has_impatient, impatient = pcall(require, "impatient")
if has_impatient and impatient then
  impatient.enable_profile()
end

require "plugins"
require "settings"
require "mappings"
require "utils"
