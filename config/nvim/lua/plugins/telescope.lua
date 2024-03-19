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
        vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = '[/] Search in current buffer' })
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = '[P]roject [F]iles' })
        vim.keymap.set('n', '<leader>pw', builtin.live_grep, { desc = '[P]roject [W]ord' })

        vim.keymap.set('n', '<leader>lk', builtin.keymaps, { desc = '[L]ist [K]eymaps' })
        vim.keymap.set('n', '<leader>lw', builtin.grep_string, { desc = '[L]ist current [W]ord' })
        vim.keymap.set('n', '<leader>ld', builtin.diagnostics, { desc = '[L]ist [D]iagnostics' })
        vim.keymap.set('n', '<leader>lr', builtin.resume, { desc = '[L]ist [R]esume' })
        vim.keymap.set('n', '<leader>l.', builtin.oldfiles, { desc = '[L]ist Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,

}
