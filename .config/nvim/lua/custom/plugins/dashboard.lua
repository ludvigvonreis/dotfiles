return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	config = function()
		require('dashboard').setup {
			theme = 'hyper',
			config = {

				footer = {},
			},
		}
	end,
	dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
