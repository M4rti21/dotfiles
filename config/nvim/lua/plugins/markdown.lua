return {
	-- {
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	-- },
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		lazy = true,
		ft = "markdown",
		config = function()
			local peek = require("peek")
			peek.setup({
				auto_load = true, -- whether to automatically load preview when
				close_on_bdelete = true, -- close preview window on buffer delete
				syntax = true, -- enable syntax highlighting, affects performance
				theme = "dark", -- 'dark' or 'light'
				update_on_change = true,
				app = "browser", -- 'webview', 'browser', string or a table of strings
				filetype = { "markdown" }, -- list of filetypes to recognize as markdown
				throttle_at = 200000, -- start throttling when file exceeds this
				throttle_time = "auto", -- minimum amount of time in milliseconds
			})
			-- vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
			-- vim.api.nvim_create_user_command("PeekClose", peek.close, {})
		end,
	},
}
