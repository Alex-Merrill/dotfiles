local cb = require("diffview.config").diffview_callback
local M = {}

require("diffview").setup {
  diff_binaries = false, -- Show diffs for binaries
  use_icons = true, -- Requires nvim-web-devicons
  file_panel = {
    win_config = {
      position = "left", -- One of 'left', 'right', 'top', 'bottom'
      width = 35, -- Only applies when position is 'left' or 'right'
      height = 10, -- Only applies when position is 'top' or 'bottom'
    },
  },
  file_history_panel = {
    wind_config = {
      position = "bottom",
      width = 35,
      height = 16,
    },
    log_options = {
      git = {
        single_file = {
          max_count = 256, -- Limit the number of commits
          follow = false, -- Follow renames (only for single file)
          all = false, -- Include all refs under 'refs/' including HEAD
          merges = false, -- List only merge commits
          no_merges = false, -- List no merge commits
          reverse = false, -- List commits in reverse order
        },
        multi_file = {
          max_count = 256, -- Limit the number of commits
          follow = false, -- Follow renames (only for single file)
          all = false, -- Include all refs under 'refs/' including HEAD
          merges = false, -- List only merge commits
          no_merges = false, -- List no merge commits
          reverse = false, -- List commits in reverse order
        },
      },
    },
  },
  hooks = {
    view_opened = function()
      M.open = true
    end,
  },
  keymaps = {
    disable_defaults = false, -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"] = cb "select_next_entry", -- Open the diff for the next file
      ["<s-tab>"] = cb "select_prev_entry", -- Open the diff for the previous file
      ["<leader>e"] = cb "focus_files", -- Bring focus to the files panel
      ["<leader>b"] = cb "toggle_files", -- Toggle the files panel.
    },
    file_panel = {
      ["j"] = cb "next_entry", -- Bring the cursor to the next file entry
      ["<down>"] = cb "next_entry",
      ["k"] = cb "prev_entry", -- Bring the cursor to the previous file entry.
      ["<up>"] = cb "prev_entry",
      ["<cr>"] = cb "select_entry", -- Open the diff for the selected entry.
      ["o"] = cb "select_entry",
      ["<2-LeftMouse>"] = cb "select_entry",
      ["-"] = cb "toggle_stage_entry", -- Stage / unstage the selected entry.
      ["S"] = cb "stage_all", -- Stage all entries.
      ["U"] = cb "unstage_all", -- Unstage all entries.
      ["X"] = cb "restore_entry", -- Restore entry to the state on the left side.
      ["R"] = cb "refresh_files", -- Update stats and entries in the file list.
      ["<tab>"] = cb "select_next_entry",
      ["<s-tab>"] = cb "select_prev_entry",
      ["<leader>e"] = cb "focus_files",
      ["<leader>b"] = cb "toggle_files",
    },
    file_history_panel = {
      ["g!"] = cb "options", -- Open the option panel
      ["<C-d>"] = cb "open_in_diffview", -- Open the entry under the cursor in a diffview
      ["zR"] = cb "open_all_folds",
      ["zM"] = cb "close_all_folds",
      ["j"] = cb "next_entry",
      ["<down>"] = cb "next_entry",
      ["k"] = cb "prev_entry",
      ["<up>"] = cb "prev_entry",
      ["<cr>"] = cb "select_entry",
      ["o"] = cb "select_entry",
      ["<2-LeftMouse>"] = cb "select_entry",
      ["<tab>"] = cb "select_next_entry",
      ["<s-tab>"] = cb "select_prev_entry",
      ["<leader>e"] = cb "focus_files",
      ["<leader>b"] = cb "toggle_files",
    },
    option_panel = {
      ["<tab>"] = cb "select",
      ["q"] = cb "close",
    },
  },
}

function M.toggleDiffview()
  if M.open then
    vim.cmd "DiffviewClose"
    M.open = false
  else
    vim.cmd "DiffviewOpen"
    M.open = true
  end
end

return M
