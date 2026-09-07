return {{
    "olimorris/onedarkpro.nvim",
    priority = 1000,
	lazy = false,
	config = function()
		vim.cmd.colorscheme("onedark")
		local bg = "#212733"
		vim.api.nvim_set_hl(0, "Normal", { bg = bg })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = bg })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
		vim.api.nvim_set_hl(0, "LineNr", { bg = bg })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })

		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#232833" }) -- 1 shade off = opaque
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#232833" })
	end,
}}
