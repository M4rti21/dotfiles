--colorscheme
vim.cmd("colorscheme moonfly")

vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    { "ExtraGroup" }
)

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#949494" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#f0f0f0" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#949494" })

vim.cmd.highlight({ "Error", "guibg=red" })
vim.cmd.highlight({ "VirtColumn", "guibg=#949494" })
vim.cmd.highlight({ "SignColumn", "guibg=NONE" })
vim.cmd.highlight({ "BufferLineFill", "guibg=NONE" })
vim.cmd.highlight({ "FoldColumn", "guibg=NONE" })
vim.cmd.highlight({ "FoldColumn", "guibg=NONE" })
vim.cmd.highlight({ "ColorColumn ", "guibg=NONE" })
