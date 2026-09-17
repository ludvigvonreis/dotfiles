return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			options = { "buffers", "curdir", "tabpages", "winsize", "folds" },
		},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore session for current directory",
			},
			{
				"<leader>qS",
				function()
					require("persistence").select()
				end,
				desc = "Select a session to load",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't save current session",
			},
		},
	},
}
