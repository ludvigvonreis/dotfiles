return {
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require('bufferline').setup {
				options = {
					themable = true,
					offsets = {
						{
							filetype = 'NvimTree',
							text = 'NvimTree',
							separator = true,
							text_align = 'left',
						},
					},
				},
			}
		end,
	},
}
