return {{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", {
        "L3MON4D3/LuaSnip",
        build = (vim.fn.has "win32" == 0 and vim.fn.executable "make" == 1) and "make install_jsregexp" or nil
    }, "saadparwaiz1/cmp_luasnip"},
    config = function()
        local cmp = require "cmp"
        local luasnip = require "luasnip"

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm {
                    select = true
                },
                ["<C-Space>"] = cmp.mapping.complete {},
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            },
            sources = {{
                name = "nvim_lsp"
            }, {
                name = "luasnip"
            }, {
                name = "path"
            }}
        }
    end
}}
