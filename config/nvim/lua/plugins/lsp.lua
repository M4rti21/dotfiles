return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require('cmp_nvim_lsp').default_capabilities();
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        local function on_attach_callback(client, bufnr)
            require('folding').on_attach()
        end
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
            },
            automatic_installation = true,
            handlers = {
                -- default handler
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = on_attach_callback,
                        capabilities = capabilities
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
                    })
                end
            }
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local builtin = require('telescope.builtin')
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
                map('gr', builtin.lsp_references, '[G]oto [R]eferences')
                map('gi', builtin.lsp_implementations, '[G]oto [I]mplementation')
                map('gt', builtin.lsp_type_definitions, 'Type [D]efinition')
                --map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
                map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
            end
        })
    end
}
