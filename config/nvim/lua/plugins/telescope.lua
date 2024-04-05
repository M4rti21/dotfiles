return {

    "nvim-telescope/telescope.nvim",
    version = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    -- Common files
                    "/*.png",
                    "/*.jpg",
                    "/*.jpeg",
                    "/*.pdf",
                    "/*.ttf",
                    "/*.otf",
                    -- Projects
                    ".idea/*",
                    ".vscode/*",
                    ".vs/*",
                    "/*.vsconfig",
                    "/*.sln",
                    "node_modules/*",
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
        vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = '[/] Search in current buffer' })
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = '[P]roject [F]iles' })
        vim.keymap.set('n', '<leader>pw', builtin.live_grep, { desc = '[P]roject [W]ord' })

        vim.keymap.set('n', '<leader>vk', builtin.keymaps, { desc = '[V]iew [K]eymaps' })
        vim.keymap.set('n', '<leader>vw', builtin.grep_string, { desc = '[V]iew current [W]ord' })
        vim.keymap.set('n', '<leader>vd', builtin.diagnostics, { desc = '[V]iew [D]iagnostics' })
        vim.keymap.set('n', '<leader>vr', builtin.resume, { desc = '[V]iew [R]esume' })
        vim.keymap.set('n', '<leader>v.', builtin.oldfiles, { desc = '[V]iew Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,

}
