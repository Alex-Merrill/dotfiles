set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set exrc
set relativenumber
set guicursor=
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile
set incsearch
set scrolloff=8
set sidescrolloff=4
set colorcolumn=80
set signcolumn=yes
set cmdheight=2
set cursorline
set clipboard+=unnamed

" JSX/TSX highlighting
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
filetype plugin indent on
" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

"" ============================================================
"" Key Mappings  ==============================================
"" ============================================================

nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

"" ============================================================
"" Key Mappings  ==============================================
"" ============================================================


"" ============================================================
"" Init Plugins  ==============================================
"" ============================================================

call plug#begin('~/.vim/plug')
" gruvbox
Plug 'gruvbox-community/gruvbox'

" fugitive - git
Plug 'tpope/vim-fugitive'

" LSP
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" JSX/TSX semantic hl
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" LuaLine - ruler stuff
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'

" auto-pair brackets
Plug 'windwp/nvim-autopairs'

" vim-surround
Plug 'tpope/vim-surround'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" formatting
Plug 'jose-elias-alvarez/null-ls.nvim'

" file browsing
Plug 'nvim-telescope/telescope-file-browser.nvim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" devicons
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

"" ============================================================
"" Init Plugins  ==============================================
"" ============================================================

" colorscheme
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
hi CursorLine term=bold cterm=bold guibg=Grey40

"" ============================================================
"" AUTO_COMPLETE ==============================================
"" ============================================================

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local types = require'cmp.types'

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-CR>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
  })

  --  ==================================================================
  -- LSP CONFIGURATION
  -- ==================================================================

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.settings({
      ui = {
          icons = {
              server_installed = "✓",
              server_pending = "➜",
              server_uninstalled = "✗"
          }
      }
  })
  lsp_installer.setup{}

  local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer=0})
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    --vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, {buffer=0})
  end

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig').tsserver.setup {
    capabilities = capabilities,
    init_options = require("nvim-lsp-ts-utils").init_options,
    --
    on_attach = function(client, bufnr)
      local ts_utils = require("nvim-lsp-ts-utils")
      client.server_capabilities.documentFormattingProvider = false
      ts_utils.setup({
          debug = false,
          disable_commands = false,
          enable_import_on_completion = true,

          -- import all
          import_all_timeout = 5000, -- ms
          -- lower numbers = higher priority
          import_all_priorities = {
              same_file = 1, -- add to existing import statement
              local_files = 2, -- git files or files with relative path markers
              buffer_content = 3, -- loaded buffer content
              buffers = 4, -- loaded buffer names
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,
          -- if false will avoid organizing imports
          always_organize_imports = true,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},

          -- inlay hints
          auto_inlay_hints = true,
          inlay_hints_highlight = "Comment",
          inlay_hints_priority = 200, -- priority of the hint extmarks
          inlay_hints_throttle = 150, -- throttle the inlay hint request
          inlay_hints_format = { -- format options for individual hint kind
              Type = {},
              Parameter = {},
              Enum = {},
          },

          -- update imports on file move
          update_imports_on_move = true,
          require_confirmation_on_move = false,
          watch_dir = nil,
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
      vim.keymap.set("n", "<leader>gt", vim.lsp.buf.definition, {buffer=0})
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer=0})
      vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
      vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
    end,
  }
  require('lspconfig').html.setup {
    capabilities = capabilities,
    on_attach=on_attach,
  }
  require('lspconfig').gopls.setup {
    capabilities = capabilities,
    on_attach=on_attach,
    setings={
      gopls={
        gofumpt=true,
        gofumports=true,
      }
    },
  }
  require('lspconfig').pylsp.setup {
    capabilities = capabilities,
    on_attach=on_attach,
  }

  local sumneko_root_path = "/home/alex/tools/lua-language-server/bin"
  local sumneko_binary = "/home/alex/tools/lua-language-server/bin/lua-language-server"
  
  if sumneko_binary == "" then
    print('Unable to load Sumneko language servr.  Make sure it is installed in ' .. sumneko_root_path)
  else
    local lua_lsp_config = {
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
      settings = {
          Lua = {
              runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
              diagnostics = {globals = {'vim'}},
              workspace = {
                  library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true},
                  preloadFileSize = 450
              }
          }
      }
    }
  
    require'lspconfig'.sumneko_lua.setup(lua_lsp_config)
  end

  --  ==================================================================
  -- LSP CONFIGURATION
  -- ==================================================================
    
  --  ==================================================================
  -- FORMATTER CONFIG
  -- ==================================================================

  local nullls = require("null-ls")
  nullls.setup({
    sources = {
      nullls.builtins.formatting.gofumpt,
      nullls.builtins.formatting.autopep8.with({
        extra_args = {"-a", "-a"}
      }),
      nullls.builtins.formatting.prettier.with({
        filestypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
      }),
      nullls.builtins.formatting.stylua,
    },
    on_attach=function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({bufnr = bufnr})
          end,
          })
      end
    end,
    debug=true,
  }) 

  --  ==================================================================
  -- FORMATTER CONFIG
  -- ==================================================================

EOF

"" ============================================================
"" AUTO_COMPLETE ==============================================
"" ============================================================


"" ============================================================
"" LUALINE ====================================================
"" ============================================================

lua << EOF
  local colors = {
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67'
  }
  
  local config = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      component_separators = {'>', '<'},
      section_separators = {'>', '<'},
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'filename'},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {'encoding', 'fileformat', 'filetype'},
      lualine_z = {'branch', 'location'},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
  
  
  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end
  
  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end
  
  ins_left {
  	'lsp_progress',
  	--display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
  	-- With spinner
  	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
  	colors = {
  	  percentage  = colors.cyan,
  	  title  = colors.cyan,
  	  message  = colors.cyan,
  	  spinner = colors.cyan,
  	  lsp_client_name = colors.magenta,
  	  use = true,
  	},
  	separators = {
  		component = ' ',
  		progress = ' | ',
  		message = { pre = '(', post = ')'},
  		percentage = { pre = '', post = '%% ' },
  		title = { pre = '', post = ': ' },
  		lsp_client_name = { pre = '[', post = ']' },
  		spinner = { pre = '', post = '' },
  		message = { commenced = 'In Progress', completed = 'Completed' },
  	},
  	display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
  	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
  	spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
  }
  
  require('lualine').setup(config)
EOF

"" ============================================================
"" LUALINE ====================================================
"" ============================================================


"" ============================================================
"" AUTO-PAIRS =================================================
"" ============================================================

lua << EOF
  local Rule = require"nvim-autopairs.rule"
  local npairs = require"nvim-autopairs"

  npairs.setup {
    check_ts = false,
    fast_wrap = {
      map = '<M-e>',
      chars = { "{", "[", "(", "'", '"' },
      pattern= string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "s%+", ""),
      offset = 0,
    },
  }
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
EOF

"" ============================================================
"" AUTO-PAIRS =================================================
"" ============================================================


"" ============================================================
"" TREE-SITTER ================================================
"" ============================================================

lua << EOF
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript", "typescript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- list of languages that will be disabled (parser name, not file ext)
      disable = {},

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
EOF

"" ============================================================
"" TREE-SITTER ================================================
"" ============================================================

"" ============================================================
"" TELESCOPE ==================================================
"" ============================================================

lua << EOF
  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      },
      file_browser = {
        hijack_netrw = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            vim.api.nvim_set_keymap(
              "n",
              "<leader>fb",
              "<cmd>Telescope file_browser<CR>",
                { noremap = true }
            ),
          },
        },
      },
    },
    defaults = {
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      layout_config = { prompt_position = "top" },
      prompt_prefix = "🔍",
      sorting_strategy = "ascending",
    },
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('file_browser')

EOF

"" ============================================================
"" TELESCOPE ==================================================
"" ============================================================


lua << EOF
  require("nvim-web-devicons").setup {
   -- your personnal icons can go here (to override)
   -- you can specify color or cterm_color instead of specifying both of them
   -- DevIcon will be appended to `name`
   override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
   };
   -- globally enable default icons (default to false)
   -- will get overriden by `get_icons` option
   default = true;
  }
EOF
