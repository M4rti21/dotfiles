--colorscheme
vim.cmd("colorscheme moonfly")

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#949494" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#f0f0f0" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#949494" })

vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
