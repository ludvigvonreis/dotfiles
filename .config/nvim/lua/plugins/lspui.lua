return {
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		event = "LspAttach",
		opts = {
			hover = {
				border = "rounded",
			},
			rename = {
				border = "rounded",
			},
			code_action = {
				border = "rounded",
			},
			diagnostic = {
				border = "rounded",
			},
			inlay_hint = {
				enable = false,
			},
		},
		keys = {
			{
				"K",
				"<cmd>LspUI hover<CR>",
				desc = "Hover Docs",
			},
			{
				"gd",
				"<cmd>LspUI definition<CR>",
				desc = "Goto Definition",
			},
			{
				"gD",
				"<cmd>LspUI declaration<CR>",
				desc = "Goto Declaration",
			},
			{
				"gr",
				"<cmd>LspUI reference<CR>",
				desc = "Goto References",
			},
			{
				"gI",
				"<cmd>LspUI implementation<CR>",
				desc = "Goto Implementation",
			},
			{
				"<leader>D",
				"<cmd>LspUI type_definition<CR>",
				desc = "Type Definition",
			},
			{
				"<leader>rn",
				"<cmd>LspUI rename<CR>",
				desc = "Rename",
			},
			{
				"<leader>ca",
				"<cmd>LspUI code_action<CR>",
				desc = "Code Action",
			},
			{ "<leader>e", "<cmd>LspUI diagnostic<CR>", desc = "Show diagnostic under cursor" },
		},
	},
}
