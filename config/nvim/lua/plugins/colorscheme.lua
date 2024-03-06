return {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "norcalli/nvim-colorizer.lua",
        "xiyaowong/transparent.nvim"
    },

    config = function()
        vim.cmd("colorscheme moonfly")

        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#323437" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#bdbdbd" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#323437" })

        local colorizer = require("colorizer")
        colorizer.setup()

        vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
    end

}
