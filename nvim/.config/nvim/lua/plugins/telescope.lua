return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
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
					n = { ["q"] = actions.close },
				},
				file_ignore_patterns = {
					-- Projects
					".idea/*",
					".vscode/*",
					".vs/*",
					"/*.vsconfig",
					"/*.sln",
					"node_modules/*",
					".git/*",
					-- Unity
					"Library/*",
					"Logs/*",
					"Packages/*",
					"Temp/*",
					"/*.unity",
					"/*.meta",
					"/*.prefab",
					"/*.asset",
					"/*.shader",
					"/*.mat",
					"/*.cache",
					"/*.cginc",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
		})
		local pf_cmd = ":Telescope find_files find_command=rg,--ignore,--hidden,--files,-u<CR>"
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Search in current buffer" })
		vim.keymap.set("n", "<leader>pf", pf_cmd, { desc = "[P]roject [F]iles" })
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "[P]roject [S]tring" })
		-- vim.keymap.set("n", "<leader>pe", builtin.diagnostics, { desc = "[P]roject [E]rrors (diagnostics)" })
		vim.keymap.set("n", "<leader>vk", builtin.keymaps, { desc = "[V]iew [K]eymaps" })
		vim.keymap.set("n", "<leader>vr", builtin.oldfiles, { desc = "[V]iew [R]ecent" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	end,
}
