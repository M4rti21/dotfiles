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

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.clipboard = 'unnamedplus'        -- Sync clipboard between OS and Neovim.
vim.o.completeopt = 'menuone,noselect' -- Completion options
vim.o.termguicolors = true             -- True color support

vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history

vim.o.tabstop = 4                      -- Number of spaces tabs count for
vim.o.shiftwidth = 4                   -- Size of an indent
vim.o.expandtab = true                 -- Use spaces instead of tabs
