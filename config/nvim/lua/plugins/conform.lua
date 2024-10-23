return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                bash = { "shfmt" },
                css = { "prettierd", "prettier", stop_after_first = true },
                java = { "astyle" },
                go = { "gofmt" },
                php = { "pint" },
                c = { "clang-format" },
                cs = { "csharpier" },
                html = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                sh = { "shfmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            }
        })

        vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
    end
}
