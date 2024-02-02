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
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = true },
    { "github/copilot.vim" },
    { -- status bar
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    { "m4xshen/autoclose.nvim" },      -- auto close brackets
    { "norcalli/nvim-colorizer.lua" }, -- color highlight
    -- lsp
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
    {
        'stevearc/conform.nvim',
        opts = {},
    },
    {
        'nvim-java/nvim-java',
        dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            {
                'williamboman/mason.nvim',
                opts = {
                    registries = {
                        'github:nvim-java/mason-registry',
                        'github:mason-org/mason-registry',
                    },
                },
            }
        },
    },
    { "terrortylor/nvim-comment" },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
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
require("plugin.colorizer")
