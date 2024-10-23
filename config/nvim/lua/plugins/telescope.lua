return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "descending",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.5,
					},
					width = 0.8,
					height = 0.8,
				},
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
				file_ignore_patterns = {
					-- Common files
					"/*.png",
					"/*.jpg",
					"/*.jpeg",
					"/*.pdf",
					"/*.ttf",
					"/*.otf",
					"/*.woff",
					"/*.woff2",
					"/*.webp",
					"/*.mp3",
					"/*.mp4",
					"/*.mkv",
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
		})

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
