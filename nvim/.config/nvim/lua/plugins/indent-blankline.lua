return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	config = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
			indent = {
				char = "▏",
				smart_indent_cap = false,
			},
		})
	end,
}
