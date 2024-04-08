return {
    {
        "nvim-tree/nvim-web-devicons",
        "xiyaowong/transparent.nvim"
    },
    {
        "bluz71/vim-moonfly-colors",
        name = "moonfly",
        lazy = false,
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
    },
    {
        "navarasu/onedark.nvim",
        name = "onedark",
        lazy = false,
        priority = 1000,
        config = function()
            local onedark = require('onedark')
            onedark.setup {
                style = 'warm'
            }
            onedark.load()
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    }

}
