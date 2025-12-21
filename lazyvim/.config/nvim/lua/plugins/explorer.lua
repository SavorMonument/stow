return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{ "<leader>e", false },
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({
					source = "filesystem",
					toggle = true,
					reveal = true,
				})
			end,
			desc = "Toggle Neo-tree (reveal on open)",
		},
	},
	opts = {
		close_if_last_window = true,
		window = {
			mappings = {
				["<cr>"] = "open_with_window_picker",
				["<esc>"] = "",
				["c"] = "copy_to_clipboard",
				["z"] = "",
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_ignored = false,
				hide_hidden = false,
			},
			follow_current_file = {
				enabled = false,
			},
		},
	},
	dependencies = {
		"s1n7ax/nvim-window-picker",
	},
}
