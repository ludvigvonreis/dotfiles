-- Telescope bindings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sk", builtin.keymaps, {
    desc = "[S]earch [K]eymaps"
})
vim.keymap.set("n", "<leader>f", builtin.find_files, {
    desc = "Search [F]iles"
})
vim.keymap.set("n", "<leader>g", builtin.current_buffer_fuzzy_find, {
    desc = "Search by [G]rep"
})
vim.keymap.set("n", "<leader><leader>", builtin.buffers, {
    desc = "Find open buffers"
})
vim.keymap.set("n", "<leader>sn", function()
    builtin.find_files({
        cwd = vim.fn.stdpath("config")
    })
end, {
    desc = "[S]earch [N]eovim files"
})
