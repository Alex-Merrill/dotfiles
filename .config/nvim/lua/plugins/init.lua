local modules = {
  -- packer
  { "wbthomason/packer.nvim" },

  -- plenary
  { "nvim-lua/plenary.nvim" },

  -- util
  { "lewis6991/impatient.nvim" }, -- lazy load
  {
    "rcarriga/nvim-notify",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("notify").setup {
        stages = "fade",
      }
      vim.notify = require "notify"
    end,
  },
  {
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  { "tpope/vim-surround" },
  {
    "windwp/nvim-autopairs",
    config = function()
      require "plugins.autopairs"
    end,
  },
  {
    "ggandor/leap.nvim",
    after = "tokyonight.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  {
    "tpope/vim-repeat",
    event = "InsertEnter",
    config = function()
      vim.cmd [[silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)]]
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "plugins.indent-blankline"
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "plugins.colorizer"
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- file tree
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "plugins.nvim-tree"
    end,
    tag = "nightly",
  },

  -- theme/ruler
  {
    "folke/tokyonight.nvim",
    config = function()
      require "highlights"
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugins.devicons"
    end,
  },
  { "nvim-lualine/lualine.nvim" },
  {
    "arkav/lualine-lsp-progress",
    config = function()
      require "plugins.lualine"
    end,
  },

  -- git
  { "tpope/vim-fugitive" },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update { with_sync = true }
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require "plugins.treesitter"
    end,
  },
  { "windwp/nvim-ts-autotag" },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require "plugins.telescope"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  },
  { "nvim-telescope/telescope-file-browser.nvim" },

  -- LSP
  { "williamboman/nvim-lsp-installer" },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },
  { "onsails/lspkind.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.lsp"
    end,
  },
  -- formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },
  { "L3MON4D3/LuaSnip" },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  },
}

require("packer").startup { modules }
