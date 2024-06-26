return {
    {
        "bluz71/vim-moonfly-colors",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "xiyaowong/transparent.nvim"
        },
        name = "moonfly",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.transparent_groups = vim.list_extend(
                vim.g.transparent_groups or {},
                { "ExtraGroup" }
            )
            vim.g.moonflyTransparent = true
            vim.g.moonflyVirtualTextColor = true
            vim.g.moonflyCursorColor = false
            vim.g.moonflyUndercurls = true
            vim.g.moonflyUnderlineMatchParen = true
            vim.g.moonflyWinSeparator = 2
            vim.opt.fillchars = {
                horiz = '━',
                horizup = '┻',
                horizdown = '┳',
                vert = '┃',
                vertleft = '┫',
                vertright = '┣',
                verthoriz = '╋',
            }
            vim.cmd("colorscheme moonfly")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            -- Default options:
            require('kanagawa').setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = true,    -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {             -- add/modify theme and palette colors
                    palette = {},
                    theme = {
                        wave = {},
                        lotus = {},
                        dragon = {},
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    local c = colors.palette
                    return {
                        String = { fg = c.carpYellow },
                        Number = { fg = c.jujiWhite },
                        Float = { fg = c.jujiWhite },
                        Boolean = { fg = c.jujiWhite },

                        Error = { fg = c.autumnRed },
                        ErrorMsg = { fg = c.autumnRed },

                        DiagnosticError = { fg = c.autumnRed },
                        DiagnosticWarn = { fg = c.roninYellow },
                        DiagnosticInfo = { fg = c.springBlue },
                        DiagnosticHint = { fg = c.fujiGray },
                        DiagnosticOk = { fg = c.springGreen },

                        TelescopeTitle = { fg = c.fujiWhite, bold = true },
                        TelescopePromptBorder = { fg = c.fujiWhite, bg = "none" },
                        TelescopeResultsBorder = { fg = c.fujiWhite, bg = "none" },
                        TelescopePreviewBorder = { fg = c.fujiWhite, bg = "none" },
                        TelescopeSelection = { fg = c.sumiInk0, bg = c.fujiWhite },
                        -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },

                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },

                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
                theme = "dragon",    -- Load "wave" theme when 'background' option is not set
                background = {       -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus"
                },
            })

            -- setup must be called before loading
            vim.cmd("colorscheme kanagawa")
        end
    }
}
