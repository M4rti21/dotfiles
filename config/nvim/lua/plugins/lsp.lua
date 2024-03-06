return {

    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "stevearc/conform.nvim",
        "terrortylor/nvim-comment",
    },

    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities();
        local lspconfig = require("lspconfig")
        require("mason").setup()
        require("mason-lspconfig").setup()
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

        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "deno" },
                typescript = { "deno" },
                bash = { "beautysh" },
                css = { "stylelint" },
                java = { "astyle" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })

        vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

        require("nvim_comment").setup({
            -- Linters prefer comment and line to have a space in between markers
            marker_padding = true,
            comment_empty = true,
            comment_empty_trim_whitespace = true,
            create_mappings = true,
            line_mapping = "gcc",
            operator_mapping = "gc",
            comment_chunk_text_object = "ic",
            hook = nil,
        })
    end

}
