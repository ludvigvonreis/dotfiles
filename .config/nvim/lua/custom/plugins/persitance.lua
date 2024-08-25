return {
{
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  -- stylua: ignore
  init = function ()

	vim.keymap.set('n', '<Leader>qs', function() require("persistence").load() end, { desc = "Restore Session"})
	vim.keymap.set('n', '<Leader>ql', function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session"})
	vim.keymap.set('n', '<Leader>qd', function() require("persistence").stop() end, { desc = "Don't Save Current Session"})
  end
}}
