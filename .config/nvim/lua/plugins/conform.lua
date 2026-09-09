return {{
    "stevearc/conform.nvim",
    event = {"BufWritePre"},
    cmd = {"ConformInfo"},
    keys = {{
        "<leader>F",
        function()
            require("conform").format {
                async = true,
                lsp_fallback = true
            }
        end,
        mode = "",
        desc = "Format buffer"
    }},
    opts = {
        notify_on_error = false,
        -- Auto-format on save. Falls back to the attached LSP's formatter
        -- if no dedicated formatter is configured below for the filetype.
        format_on_save = function(bufnr)
            -- Some languages don't have a well-standardized style; skip
            -- LSP-fallback formatting for them (add filetypes as needed).
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype]
            }
        end,
        formatters_by_ft = {
            lua = {"stylua"}
            -- python = { "black" },
            -- rust = { "rustfmt", lsp_format = "fallback" },
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
            -- typescript = { "prettierd", "prettier", stop_after_first = true },
        }
    }
}}
