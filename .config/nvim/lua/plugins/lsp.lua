-- setup tabnine config
local tabnine = require "cmp_tabnine.config"
tabnine:setup {
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
  show_prediction_strength = true,
}

-- Setup nvim-cmp.
local cmp = require "cmp"
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
  luasnip = "[SNP]",
}
local lspkind = require "lspkind"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    --completion = cmp.config.window.bordered(),
    --documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-CR>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "cmp_tabnine" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer",                 keyword_length = 5 },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        local menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
          end
          vim_item.kind = ""
        end
        vim_item.menu = menu
        return vim_item
      end,
    },
  },
}
-- LSP CONFIGURATION
require("mason").setup {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
}

require("mason-lspconfig").setup {
  ensure_installed = { "pylsp", "gopls", "tsserver" },
  automatic_installation = true,
}

local on_attach = function(client, bufnr)
  -- client.server_capabilities.documentFormattingProvider = false
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set("n", "<leader>gt", vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = 0 })
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = 0 })
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = 0 })
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- tsserver setup
require("lspconfig").tsserver.setup {
  capabilities = capabilities,
  init_options = require("nvim-lsp-ts-utils").init_options,
  --
  on_attach = function(client, bufnr)
    local ts_utils = require "nvim-lsp-ts-utils"
    -- client.server_capabilities.documentFormattingProvider = false
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,
      disable_suggestions = false,
      include_completionsForImportStatements = true,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers = higher priority
      import_all_priorities = {
        same_file = 1,      -- add to existing import statement
        local_files = 2,    -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4,        -- loaded buffer names
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
      inlay_hints_format = {      -- format options for individual hint kind
        Type = {},
        Parameter = {},
        Enum = {},
      },

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = false,
      watch_dir = nil,
    }

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { buffer = 0 })
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = 0 })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = 0 })
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
  end,
}

-- html server setup
require("lspconfig").html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require("lspconfig").cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- gopls server setup
require("lspconfig").gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- pylsp server setup
require("lspconfig").pylsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require("lspconfig").yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
  formatter_by_ft = {
    css = formatters.prettierd,
    html = formatters.prettierd,
    java = formatters.prettierd,
    javascript = formatters.prettierd,
    json = formatters.prettierd,
    lua = formatters.lsp,
    go = formatters.lsp,
    markdown = formatters.prettierd,
    openscad = formatters.lsp,
    python = formatters.black,
    rust = formatters.lsp,
    scad = formatters.lsp,
    scss = formatters.lsp,
    sh = formatters.shfmt,
    terraform = formatters.lsp,
    typescript = formatters.prettierd,
    typescriptreact = formatters.prettierd,
    yaml = formatters.prettierd,
  },

  -- fallback formatter to use when no formatters match the current filetype
  fallback_formatter = {
    formatters.remove_trailing_whitespace,
    formatters.remove_trailing_newlines,
    formatters.prettierd,
  },

  run_with_sh = false,
})
