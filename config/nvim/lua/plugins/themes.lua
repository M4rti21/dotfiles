return {
	{ "nvim-tree/nvim-web-devicons" },
	{
		"xiyaowong/transparent.nvim",
		config = function()
			vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_enable_bold = true
			vim.g.gruvbox_material_better_performange = true
			vim.g.gruvbox_material_transparent_background = true
			vim.g.gruvbox_material_background = "medium"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
