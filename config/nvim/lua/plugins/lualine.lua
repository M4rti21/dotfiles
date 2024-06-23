return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local function show_macro_recording()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
                return ""
            else
                return "Recording @" .. recording_register
            end
        end

        local lualine = require("lualine")
        lualine.setup({
            options = {
                icons_enabled = true,
                -- theme = {
                --     normal = {
                --         a = { fg = "0", bg = "3" },
                --         b = { fg = colors.white, bg = colors.gray },
                --         c = { fg = colors.white, bg = colors.transparent },
                --     },
                --     command = { a = { fg = colors.black, bg = colors.yellow } },
                --     insert = { a = { fg = colors.black, bg = colors.green } },
                --     visual = { a = { fg = colors.black, bg = colors.magenta } },
                --     replace = { a = { fg = colors.black, bg = colors.red } },
                --     inactive = {
                --          a = { fg = colors.white, bg = colors.black },
                --          b = { fg = colors.white, bg = colors.black },
                --      }
                -- },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "macro-recording",
                        fmt = show_macro_recording,
                    },
                    "diagnostics",
                    "diff"
                },
                lualine_x = { "location" },
                lualine_y = { "filename" },
                lualine_z = { "progress" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "diagnostics", "diff" },
                lualine_x = { "location" },
                lualine_y = { "filename" },
                lualine_z = { "progress" },
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })


        vim.api.nvim_create_autocmd("RecordingEnter", {
            callback = function()
                lualine.refresh({
                    place = { "statusline" },
                })
            end,
        })

        vim.api.nvim_create_autocmd("RecordingLeave", {
            callback = function()
                local timer = vim.loop.new_timer()
                timer:start(
                    50,
                    0,
                    vim.schedule_wrap(function()
                        lualine.refresh({
                            place = { "statusline" },
                        })
                    end)
                )
            end,
        })
    end
}
