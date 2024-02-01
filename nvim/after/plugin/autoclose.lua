local autoclose = require("autoclose")
autoclose.setup({
	keys = {
		["<"] = { escape = true, close = true, pair = "<>", disabled_filetypes = {} },
		["["] = { escape = true, close = true, pair = "[]", disabled_filetypes = {} },
		["{"] = { escape = true, close = true, pair = "{}", disabled_filetypes = {} },
		['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = {} },
		["`"] = { escape = true, close = true, pair = "``", disabled_filetypes = {} },
	},
	options = {
		disabled_filetypes = { "text", "markdown" },
		disable_when_touch = false,
		touch_regex = "[%w(%[{]",
		pair_spaces = false,
		auto_indent = true,
		disable_command_mode = false,
	},
})
