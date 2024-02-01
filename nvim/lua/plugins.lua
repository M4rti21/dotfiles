return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.5",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":tsupdate",
	},
	{
		"vonheikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/neodev.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "l3mon4d3/luasnip" },
		},
	},
	{ "bluz71/vim-moonfly-colors", as = "moonfly", lazy = true },
	{ "github/copilot.vim" },
	{ "stevearc/conform.nvim" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "numtostr/comment.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{ "terrortylor/nvim-comment" },
	{ "m4xshen/autoclose.nvim" },
	{ "norcalli/nvim-colorizer.lua" },
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"muniftanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
	},
}
