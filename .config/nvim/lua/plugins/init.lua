local modules = {

  -- plenary
  { "nvim-lua/plenary.nvim" },

  -- util
  {
    "rcarriga/nvim-notify",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    config = function()
      require("notify").setup {
        stages = "fade",
      }
      vim.notify = require "notify"
    end,
  },
  {
    "glacambre/firenvim",
    event = "VeryLazy",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require "plugins.autopairs"
    end,
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tokyonight.nvim" },
    event = "VeryLazy",
    config = function()
      require("leap").create_default_mappings()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require "plugins.indent-blankline"
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require "plugins.colorizer"
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require "plugins.comment"
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },
  {
    "sbulav/nredir.nvim",
  },
  {
    "stevearc/dressing.nvim",
  },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  },
  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
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
    lazy = false,
    priority = 1000,
    config = function()
      require "highlights"
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    event = "VeryLazy",
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
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require "plugins.diffview"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  --treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update { with_sync = true }
    end,
    dependencies = {
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
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false,
    config = function()
      require "plugins.telescope"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  { "nvim-telescope/telescope-file-browser.nvim" },

  -- LSP
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.lsp"
    end,
  },
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },
  { "onsails/lspkind.nvim" },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    enable = false,
    config = function()
      require("lsp_signature").setup {
        toggle_key = "<C-k>",
      }
    end,
  },
  -- formatting
  {
    "elentok/format-on-save.nvim",
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },
  { "L3MON4D3/LuaSnip" },
  { "codota/tabnine-nvim", build = "./dl_binaries.sh" },
  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  },

  -- processing
  {
    "sophacles/vim-processing",
  },
}

require("lazy").setup(modules)
