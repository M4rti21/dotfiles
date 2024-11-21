return {
	{ "nvim-tree/nvim-web-devicons" },
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_enable_bold = true
			vim.g.gruvbox_material_better_performange = true
			vim.g.gruvbox_material_transparent_background = true
			vim.g.gruvbox_material_background = "medium"
			vim.cmd("colorscheme gruvbox-material")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			-- vim.cmd("colorscheme rose-pine-moon")
		end,
	},
}
