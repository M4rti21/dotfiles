return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("harpoon").setup({
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = { "harpoon" },
                mark_branch = false,
            }
        })

        require("telescope").load_extension('harpoon')

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set('n', '<leader>M', ui.toggle_quick_menu, { desc = 'Harpoon ^[M]arks' })
        vim.keymap.set('n', '<leader>m', mark.add_file, { desc = 'Harpoon [M]ark File' })

        vim.keymap.set("n", "<A-f>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<A-d>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<A-s>", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<A-a>", function() ui.nav_file(4) end)
    end
}
