return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},

			messages = {
				enabled = false,
			},

			notify = {
				enabled = true,
			},

			popupmenu = {
				enabled = false,
			},

			lsp = {
				progress = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
				message = {
					enabled = false,
				},
			},

			health = {
				checker = false,
			},
		},

		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#232833",
		},
	},
}
