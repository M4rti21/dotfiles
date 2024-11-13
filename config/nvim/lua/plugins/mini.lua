return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup()
		require("mini.move").setup()
		require("mini.animate").setup({
			cursor = {
				enable = false,
			},
			scroll = {
				enable = true,
			},
			resize = {
				enable = false,
			},
			open = {
				enable = false,
			},
			close = {
				enable = false,
			},
		})
	end,
}
