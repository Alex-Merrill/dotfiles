-- bootstrap packer if not found
local fn = vim.fn
local api = vim.api
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.isdirectory(install_path) == 0 then
  fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

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

require "settings"
require "mappings"
require "plugins"
require "utils"
