local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- map leader + / to search in current buffering using fzf
-- configure the window to be 80% of the screen
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
