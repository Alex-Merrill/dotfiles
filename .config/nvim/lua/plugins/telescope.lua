require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {},
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--no-ignore-vcs",
        "--glob",
        "!.git/*",
        "--glob",
        "!node_modules/*",
        "--glob",
        "!.next/*",
      },
    },
    grep_string = {
      find_command = { "rg", "--hidden" },
    },
  },
  defaults = {
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    layout_config = { prompt_position = "top" },
    prompt_prefix = "🔍",
    sorting_strategy = "ascending",
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(fp)
          local image_extensions = { "png", "jpg" } -- Supported image formats
          local split_path = vim.split(fp:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "catimg",
            filepath, -- Terminal image viewer command
          }, { on_stdout = send_output, stdout_buffered = true })
        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end,
    },
  },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "file_browser"
