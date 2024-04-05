return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        -- nnoremap <silent>[b :BufferLineCycleNext<CR>
        -- nnoremap <silent>b] :BufferLineCyclePrev<CR>
        vim.keymap.set("n", "<leader>h", vim.cmd.BufferLineCyclePrev, { desc = 'Cycle Buffer Tab Prev' })
        vim.keymap.set("n", "<leader>l", vim.cmd.BufferLineCycleNext, { desc = 'Cycle Buffer Tab Next' })
        require("bufferline").setup({
            options = {
                show_close_icon = false,
                show_buffer_close_icon = false,
                indicator = {
                    icon = '▎',
                    style = "icon"
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local indicator = ""
                    for err, num in pairs(diagnostics_dict) do
                        if err == "error" then
                            indicator = indicator .. "󰅚 " .. num .. " "
                        elseif err == "warning" then
                            indicator = indicator .. " " .. num .. " "
                        end
                    end
                    return indicator
                end
            }
        })
    end
}
