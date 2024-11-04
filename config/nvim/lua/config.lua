-- GLOBALS
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "^./"
vim.g.netrw_hide = 1
-- vim.g.netrw_liststyle  = 3

vim.g.netrw_rm_cmd = "trash-put"
vim.g.netrw_rmdir_cmd = "trash-put"
vim.g.netrw_rmf_cmd = "rm -f"

-- OPT
vim.opt.colorcolumn = "81"
vim.opt.wrap = false

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 10
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect"
vim.opt.termguicolors = true

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true

-- vim.opt.cmdheight      = 0

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- CMD
vim.cmd.highlight({ "Error", "guibg=red" })
vim.cmd.highlight({ "VirtColumn", "guibg=WHITE" })
vim.cmd.highlight({ "SignColumn", "guibg=NONE" })
vim.cmd.highlight({ "BufferLineFill", "guibg=NONE" })
vim.cmd.highlight({ "FoldColumn", "guibg=NONE" })
vim.cmd.highlight({ "FoldColumn", "guibg=NONE" })
vim.cmd.highlight({ "ColorColumn ", "guibg=NONE" })
vim.cmd.highlight({ "Cursor", "cterm=bold guibg=white guifg=black" })

vim.o.guicursor = "n-v-c:block-Cursor"
vim.o.guicursor = vim.o.guicursor .. ",i:ver25-iCursor"

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- local tailwind_group = vim.api.nvim_create_augroup("Tailwind", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     callback = function()
--         local filetype = vim.fn.expand("%:e")
--         if filetype == "tsx" then
--             vim.cmd [[TailwindSort]]
--         end
--     end,
--     group = tailwind_group,
--     pattern = "*",
-- })
