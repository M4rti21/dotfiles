return {
    "bluz71/vim-moonfly-colors",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "xiyaowong/transparent.nvim"
    },
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme moonfly")

        vim.g.transparent_groups = vim.list_extend(
            vim.g.transparent_groups or {},
            { "ExtraGroup" }
        )

        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "gray" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "gray" })
    end
}
