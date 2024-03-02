return {

    "nvim-telescope/telescope.nvim",
    version = "0.1.5",
    dependencies = { { "nvim-lua/plenary.nvim" } },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})
        telescope.setup {
            defaults = {
                file_ignore_patterns = { "node_modules/.*" },
            },
        }
    end

}
