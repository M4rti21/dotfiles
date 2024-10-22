return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "lua-format" },
                python = { "isort", "black" },
                javascript = { "deno_fmt" },
                typescript = { "deno_fmt" },
                bash = { "shfmt" },
                css = { "stylelint" },
                java = { "astyle" },
                go = { "gofmt" },
                php = { "pint" },
                c = { "clang-format" },
                cs = { "csharpier" },
                html = { "htmlbeautifier" },
                sh = { "shfmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                conform.format({ bufnr = args.buf })
            end,
        })

        vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
}
