return {
    dir = "~/Projects/compi.nvim",
    config = function()
        local compi = require("compi")
        compi.setup({
            filetypes = {
                tex = "texi2pdf -c -q %f -o %b.groff",
                ms = "groff -ms %f -T pdf > %b.pdf",
                go = "go build",
                templ = "templ generate",
            }
        })
        vim.keymap.set("n", "<leader>c", compi.compile, { desc = "[C]ompile" })
    end
}
