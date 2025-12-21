return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = "gpt-5.1-codex",
			window = {
				layout = "float",
			},
			auto_insert_mode = false,
		},
	},
}
