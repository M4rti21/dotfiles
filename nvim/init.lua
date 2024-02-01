vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = { import = "plugins" }

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
require("plugin.colorizer")
