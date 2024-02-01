vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/neodev.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
	use({ "bluz71/vim-moonfly-colors", as = "moonfly" })
	use({ "github/copilot.vim" })
	use({ "stevearc/conform.nvim" })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({ "numToStr/Comment.nvim", opts = {} })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({ "terrortylor/nvim-comment" })
	use({ "m4xshen/autoclose.nvim" })
end)
