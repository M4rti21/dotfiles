return {
	-- dir = "~/Projects/compi.nvim",
	"m4rti21/compi.nvim",
	config = function()
		local compi = require("compi")
		compi.setup({
			compile = {
				tex = "texi2pdf -c -q %f",
				ms = "groff -ms %f -T pdf > %b.pdf",
				go = "go build",
				templ = "templ generate",
				c = "cc %f",
			},
			run = {
				go = "go run .",
				js = "bun %f",
				ts = "bun %f",
				py = "python %f",
				html = "$BROWSER %f",
			},
			compnrun = {
				go = "go run .",
				c = "cc %f && ./a.out",
			},
		})
		vim.keymap.set("n", "<leader>c", compi.compile, { desc = "[c]ompile" })
		vim.keymap.set("n", "<leader>R", compi.compnrun, { desc = "compile and [R]un" })
		vim.keymap.set("n", "<leader>r", compi.run, { desc = "[r]un" })
	end,
}
