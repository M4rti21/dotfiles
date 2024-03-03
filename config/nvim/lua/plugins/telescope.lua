return {

    "nvim-telescope/telescope.nvim",
    version = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules/.*" },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {
            desc = '[/] Fuzzily search in current buffer'
        })

        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = '[P]roject [F]iles' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,

}
