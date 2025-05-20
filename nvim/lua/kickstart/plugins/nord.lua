return {
	{
		'rmehri01/onenord.nvim',
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- vim.cmd.colorscheme 'onedarkpro'
			-- vim.o.termguicolors = false -- For some reason this is required to display themes correctly. Super weird

			-- You can configure highlights by doing something like:
			vim.cmd.hi 'Comment gui=none'
		end,
	},
	{
		priority = 1000,
		'olimorris/onedarkpro.nvim',
		init = function()
			-- Load the colorscheme here.
			vim.cmd.colorscheme 'onedark'
			-- vim.o.termguicolors = false -- For some reason this is required to display themes correctly. Super weird

			-- You can configure highlights by doing something like:
			vim.cmd.hi 'Comment gui=none'
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
