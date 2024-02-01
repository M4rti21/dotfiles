local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy")
local plugins = {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.5",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/neodev.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
		},
	},
	{ "bluz71/vim-moonfly-colors", as = "moonfly", lazy = true },
	{ "github/copilot.vim" },
	{ "stevearc/conform.nvim" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{ "numToStr/Comment.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{ "terrortylor/nvim-comment" },
	{ "m4xshen/autoclose.nvim" },
}

local opts = {}

require("lazy").setup(plugins, opts)

require("remap")
require("config")

-- import plugin configs
require("plugin.autoclose")
require("plugin.conform")
require("plugin.lsp")
require("plugin.lualine")
require("plugin.nvim_comment")
require("plugin.telescope")
require("plugin.treesitter")
