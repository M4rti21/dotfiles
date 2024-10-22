local M = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { desc = desc })
end

return M
