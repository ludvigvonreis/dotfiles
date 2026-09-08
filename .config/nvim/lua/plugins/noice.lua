return { -- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#232833", -- match your Normal bg
		},
	},
}
