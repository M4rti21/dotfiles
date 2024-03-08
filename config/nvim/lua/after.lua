--colorscheme
vim.cmd("colorscheme moonfly")

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#323437" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#bdbdbd" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#323437" })

vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
