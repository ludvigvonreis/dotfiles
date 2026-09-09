return {{
    "folke/which-key.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup()

        -- Document existing key chains
        require("which-key").add({{
            "<leader>q",
            group = "[Q]uit / Session"
        }, {
            "<leader>c",
            group = "[C]ode",
            icon = ""
        }, {
            "<leader>d",
            group = "[D]ocument"
        }, {
            "<leader>s",
            group = "[S]earch"
        }, {
            "<leader>w",
            group = "[W]orkspace"
        }, {
            "<leader>t",
            group = "[T]oggle"
        }, {
            "<leader>b",
            group = "[B]uffer"
        }, {
            "<leader>r",
            group = "[R]ename"
        }})
    end
}}
