--colorscheme
vim.cmd("colorscheme moonfly")

vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    { "ExtraGroup" }
)

-- API
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "gray" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "gray" })
