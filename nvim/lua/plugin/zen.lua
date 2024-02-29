require("zen-mode").setup(
    {
        window = {
            backdrop = 1,
            width = 120,
            height = 1,
        },
        plugins = {
            options = {
                laststatus = 3, -- turn off the statusline in zen mode "3 == enabled"
            },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win)
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
        end,
    }
)
