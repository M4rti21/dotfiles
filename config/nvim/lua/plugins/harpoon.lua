return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("harpoon").setup({
            global_settings = {
                -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
                save_on_toggle = false,

                -- saves the harpoon file upon every change. disabling is unrecommended.
                save_on_change = true,

                -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
                enter_on_sendcmd = false,

                -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
                tmux_autoclose_windows = false,

                -- filetypes that you want to prevent from adding to the harpoon list menu.
                excluded_filetypes = { "harpoon" },

                -- set marks specific to each git branch inside git repository
                mark_branch = false,

                -- enable tabline with harpoon marks
                tabline = false,
                tabline_prefix = "   ",
                tabline_suffix = "   ",
            }
        })

        require("telescope").load_extension('harpoon')

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set('n', '<leader>u', ui.toggle_quick_menu, { desc = '[H]arpoon' })
        vim.keymap.set('n', '<leader>m', mark.add_file, { desc = 'Harpoon [M]ark File' })

        vim.keymap.set("n", "<leader>f", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<leader>d", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<leader>s", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<leader>a", function() ui.nav_file(4) end)
    end
}
