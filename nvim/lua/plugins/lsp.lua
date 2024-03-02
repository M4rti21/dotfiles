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
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                            },
                        },
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
            -- should comment out empty or whitespace only lines
            comment_empty = true,
            -- trim empty comment whitespace
            comment_empty_trim_whitespace = true,
            -- Should key mappings be created
            create_mappings = true,
            -- Normal mode mapping left hand side
            line_mapping = "gcc",
            -- Visual/Operator mapping left hand side
            operator_mapping = "gc",
            -- text object mapping, comment chunk,,
            comment_chunk_text_object = "ic",
            -- Hook function to call before commenting takes place
            hook = nil,
        })
    end

}
