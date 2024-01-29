local noice = require("noice")
local lualine = require("lualine")
local notify = require("notify")

noice.setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			cmdline = { pattern = "^:", icon = "", lang = "vim", title = "cmd" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", title = "search" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", title = "search" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "bash", title = "filter" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖", title = "help" },
			lua = {
				pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
				icon = "",
				lang = "lua",
				title = "lua",
			},
		},
	},
	views = {
		cmdline_popup = {
			position = {
				row = "50%",
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
		},
	},
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

lualine.setup({
	sections = {
		lualine_x = {
			{
				noice.api.statusline.mode.get,
				cond = noice.api.statusline.mode.has,
				color = { fg = "#323437" },
			},
		},
	},
})

notify.setup({
	background_colour = "NotifyBackground",
	fps = 30,
	level = 2,
	minimum_width = 50,
	render = "minimal",
	stages = "static",
	timeout = 1000,
	top_down = true,
})
