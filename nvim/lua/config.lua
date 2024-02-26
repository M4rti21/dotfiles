vim.cmd([[colorscheme moonfly]])

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#323437" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#bdbdbd" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#323437" })

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

vim.o.wrap = false


-- set tab indent to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true
