-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>q", ":qa!<CR>", { desc = "[Q]uit nvim without saving" })

-- NvimTree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" }) -- open/close
vim.keymap.set("n", "<leader>nr", ":NvimTreeRefresh<CR>", { desc = "Refresh File Tree" }) -- refresh

vim.keymap.set("c", "<cr>", function()
	if vim.fn.pumvisible() == 1 then
		return "<c-y>"
	end
	return "<cr>"
end, { expr = true })

vim.keymap.set("n", "<A-up>", "ddkP") -- Move line up
vim.keymap.set("n", "<A-down>", "ddp") -- Move line down
