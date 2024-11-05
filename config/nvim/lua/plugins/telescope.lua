return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local fb_actions = telescope.extensions.file_browser.actions
		telescope.setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.5,
					},
					width = 0.8,
					height = 0.8,
				},
				-- borderchars = {
				-- prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
				-- results = { " " },
				-- preview = { " " },
				-- },
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			},
			pickers = {
				find_files = {
					hidden = false,
				},
			},
			extensions = {
				file_browser = {
					-- theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					grouped = true,
					mappings = {
						["n"] = {
							["%"] = fb_actions.create,
						},
					},
				},
			},
		})
		-- To get telescope-file-browser loaded and working with telescope,
		-- you need to call load_extension, somewhere after setup function:
		telescope.load_extension("file_browser")
		vim.keymap.set("n", "<space>pv", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Search in current buffer" })
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "[P]roject [F]iles" })
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "[P]roject [S]tring" })
		vim.keymap.set("n", "<leader>pe", builtin.diagnostics, { desc = "[P]roject [E]rrors (diagnostics)" })
		vim.keymap.set("n", "<leader>vk", builtin.keymaps, { desc = "[V]iew [K]eymaps" })
		vim.keymap.set("n", "<leader>vr", builtin.oldfiles, { desc = "[V]iew [R]ecent" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	end,
}
