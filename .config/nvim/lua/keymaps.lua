-- Telescope bindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {
	desc = "[F]ind [K]eymaps",
})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {
	desc = "[F]ind [F]iles",
})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
	desc = "[F]ind Live [G]rep",
})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {
	desc = "Find open buffers",
})
vim.keymap.set("n", "<leader>fk", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, {
	desc = "[F]ind Neovim config",
})

vim.keymap.set("n", "<leader>cd", function()
	local root = vim.fs.root(0, ".git")
	if root then
		vim.cmd("lcd " .. vim.fn.fnameescape(root))
		vim.notify("Changed root to " .. root, vim.log.levels.INFO)
	else
		vim.notify("No .git root found", vim.log.levels.WARN)
	end
end, { desc = "Move path to root of project" })

vim.keymap.set("n", "<leader>x", function()
	local file = vim.fn.expand("%") -- Get the current file name
	local first_line = vim.fn.getline(1) -- Get the first line of the file
	if string.match(first_line, "^#!/") then -- If first line contains shebang
		local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
		vim.cmd("!chmod +x " .. escaped_file) -- Make the file executable
		vim.cmd("vsplit") -- Split the window vertically
		vim.cmd("terminal " .. escaped_file) -- Open terminal and execute the file
		vim.cmd("startinsert") -- Enter insert mode, recommended by echasnovski on Reddit
	else
		vim.cmd("echo 'Not a script. Shebang line not found.'")
	end
end, { desc = "Execute current file in terminal (if it's a script)" })

vim.api.nvim_create_user_command("Kitty", function(opts)
	local dir = vim.fn.expand("%:p:h")
	if dir == "" or vim.fn.isdirectory(dir) == 0 then
		dir = vim.fn.getcwd()
	end
	local cmd = { "kitty", "--directory", dir }
	if opts.args ~= "" then
		vim.list_extend(cmd, vim.split(opts.args, " ", { trimempty = true }))
	end
	vim.fn.jobstart(cmd, { detach = true })
end, { nargs = "*", desc = "Open kitty in the current file's directory" })
