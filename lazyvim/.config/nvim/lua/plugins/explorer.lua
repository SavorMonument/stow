return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    window = {
      mappings = {
        ["<cr>"] = "open_with_window_picker",
      }
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_ignored = false,
        hide_hidden = false,
      },
    },
  },
  dependencies = {
    "s1n7ax/nvim-window-picker",
  },
}

