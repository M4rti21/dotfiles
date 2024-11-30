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
				-- c = { "clang-format" },
				cs = { "csharpier" },
				html = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				sh = { "shfmt" },
				toml = { "taplo" },
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
		vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
	end,
}
