return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				bash = { "shfmt" },
				css = { "prettierd" },
				java = { "astyle" },
				go = { "gofmt" },
				php = { "pint" },
				c = { "clang-format" },
				cs = { "csharpier" },
				html = { "prettierd" },
				json = { "prettierd" },
				sh = { "shfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
		vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
	end,
}
