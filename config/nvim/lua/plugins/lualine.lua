return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local colors = {
            transparent = "#00000000",
            black = "#080808",
            gray = "#323437",
            white = "#c6c6c6",
            red = "#ff5454",
            yellow = "#e3c78a",
            green = "#8cc85f",
            cyan = "#79dac8",
            blue = "#80a0ff",
            magenta = "#cf87e8",
        }

        local sessions = require('auto-session.lib');

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = {
                    normal = {
                        a = { fg = colors.black, bg = colors.blue },
                        b = { fg = colors.white, bg = colors.gray },
                        c = { fg = colors.white, bg = colors.black },
                    },
                    command = { a = { fg = colors.black, bg = colors.yellow } },
                    insert = { a = { fg = colors.black, bg = colors.green } },
                    visual = { a = { fg = colors.black, bg = colors.magenta } },
                    replace = { a = { fg = colors.black, bg = colors.red } },
                    inactive = {
                        a = { fg = colors.white, bg = colors.black },
                        b = { fg = colors.white, bg = colors.black },
                    },

                },
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
                lualine_c = { "diagnostics", "diff" },
                lualine_x = { "location", sessions.current_session_name },
                lualine_y = { "filename" },
                lualine_z = { "progress" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end
}
