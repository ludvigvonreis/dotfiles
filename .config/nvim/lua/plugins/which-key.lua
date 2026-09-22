return {
	{
		"folke/which-key.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{
					"<leader>q",
					group = "Session",
				},
				{
					"<leader>c",
					group = "[C]ode",
					icon = "",
				},
				{
					"<leader>d",
					group = "[D]ocument",
				},
				{
					"<leader>f",
					group = "[F]ind",
				},
				{
					"<leader>w",
					group = "[W]orkspace",
				},
				{
					"<leader>t",
					group = "[T]oggle",
				},
				{
					"<leader>r",
					group = "[R]ename",
				},
			})
		end,
	},
}
