return {
	"smithbm2316/centerpad.nvim",
	config = function()
		vim.keymap.set("n", "<leader>z", function()
			require("centerpad").toggle({ leftpad = 40, rightpad = 40 })
		end, { silent = true, noremap = true })
	end,
}
