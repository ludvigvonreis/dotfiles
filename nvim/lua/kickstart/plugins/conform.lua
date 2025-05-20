return {
	{ -- Autoformat
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>f',
				function()
					require('conform').format { async = true, lsp_fallback = true }
				end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { 'stylua' },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { 'rustfmt', lsp_format = 'fallback' },
				-- Conform will run the first available formatter
				javascript = { 'prettierd', 'prettier', stop_after_first = true },

				c = {},
			},
			formatters = {
				clang_format = {
					prepend_args = { '--style=file', '--fallback-style=LLVM' },
				},
			},
		},
	},
}
-- vim: ts=3 sts=2 sw=2 et
