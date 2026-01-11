return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		config = function()
			vim.api.nvim_set_hl(0, "Normal", { bg = "#212733" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "#212733" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#212733" })
		end,
	},
}
