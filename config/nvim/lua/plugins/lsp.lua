return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },

    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities();
        local lspconfig = require("lspconfig")
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
                        capabilities = capabilities
                    })
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
                    })
                end,
            },
        })
    end,
}