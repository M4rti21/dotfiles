return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		keymap = {
			["<Tab>"] = { "accept", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-b>"] = { "scroll_documentation_down", "fallback" },
			["<C-f>"] = { "scroll_documentation_up", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		},
		highlight = {
			use_nvim_cmp_as_default = false,
		},
		nerd_font_variant = "normal",
		windows = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 50,
				update_delay_ms = 50,
			},
			ghost_text = {
				enabled = true,
			},
		},
	},
}
