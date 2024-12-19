return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup({
			settings = {
				save_on_toggle = false,
				save_on_change = true,
			},
		})

		vim.keymap.set("n", "<leader>M", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon ^[M]arks" })
		vim.keymap.set("n", "<leader>m", function()
			harpoon:list():add()
		end, { desc = "Harpoon [M]ark File" })

		vim.keymap.set("n", "<A-f>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<A-d>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<A-s>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<A-a>", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<A-h>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<A-;>", function()
			harpoon:list():next()
		end)
	end,
}
