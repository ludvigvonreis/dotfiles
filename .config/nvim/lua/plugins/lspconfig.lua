-- Standalone LSP setup: mason + mason-lspconfig + nvim-lspconfig + cmp
-- No kickstart abstractions — everything lives in this one file.
return {{
    "neovim/nvim-lspconfig",
    dependencies = {{
        "williamboman/mason.nvim",
        config = true
    }, "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim", "hrsh7th/cmp-nvim-lsp" -- gives lspconfig the extra capabilities cmp needs
    },
    config = function()
        -- 1. Keybindings: fire once per buffer, whenever any LSP attaches to it.
        --    (gd/gr/gI/K/rename/code_action are now handled by LspUI.nvim above —
        --    only keep what LspUI doesn't cover.)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my-lsp-attach", {
                clear = true
            }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, {
                        buffer = event.buf,
                        desc = "LSP: " .. desc
                    })
                end

                map("<leader>ds", vim.lsp.buf.document_symbol, "Document Symbols")
                map("<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace Symbols")

                -- Highlight references of the symbol under the cursor while it rests there
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local hl_group = vim.api.nvim_create_augroup("my-lsp-highlight", {
                        clear = false
                    })
                    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
                        buffer = event.buf,
                        group = hl_group,
                        callback = vim.lsp.buf.document_highlight
                    })
                    vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
                        buffer = event.buf,
                        group = hl_group,
                        callback = vim.lsp.buf.clear_references
                    })
                end

                -- Toggle inlay hints if the server supports them
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
                            bufnr = event.buf
                        })
                    end, "Toggle Inlay Hints")
                end
            end
        })

        -- 2. Capabilities: tell servers what cmp can do (snippet support, etc.)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- 3. Per-server config. Add a language by adding a key here.
        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        diagnostics = {
                            globals = {"vim"}
                        }
                    }
                }
            }
            -- pyright = {},
            -- clangd = {},
            -- rust_analyzer = {},
            -- gopls = {},
        }

        -- 4. Mason: install the servers + any extra CLI tools you want
        require("mason").setup()

        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, {"stylua" -- formatter, not an LSP server
        })
        require("mason-tool-installer").setup {
            ensure_installed = ensure_installed
        }

        require("mason-lspconfig").setup {
            handlers = {function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end}
        }
    end
}}
