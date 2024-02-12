# THEME SETTINGS

system_font = "GeistMono Nerd Font SemiBold"
system_font = "ComicShannsMono Nerd Font Mono Bold"

colors = dict(
        background = "#080808",
        foreground = "#bdbdbd",
        disabled = "#323437",
        accent = "#cc2850",
        )

panel_size = 24
gap_size = 1

borders = dict(
        margin = gap_size,
        single_margin = gap_size,
        border_width = 2,
        border_on_single = True,
        border_focus = colors["accent"],
        border_normal = colors["disabled"],
        )

widget_defaults = dict(
        font = system_font,
        fontsize = 18,
        padding = 8,
        margin = 0,
        foreground = colors["foreground"]
        )

sp_size = dict(
        width = 0.6,
        height = 0.6,
        x = 0.2,
        y = 0.2,
        opacity = 1
        )
