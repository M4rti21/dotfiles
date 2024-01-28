# THEME SETTINGS

system_font = "GeistMono Nerd Font Bold"

colors = {
    "background":       "#080808",
    "foreground":       "#bdbdbd",
    "disabled":         "#323437",
    "accent":           "#cc2850",

    "black":            "#323437",
    "white":            "#c6c6c6",
    "red":              "#ff5454",
    "yellow":           "#e3c78a",
    "green":            "#8cc85f",
    "cyan":             "#81cabe",
    "blue":             "#80a0ff",
    "magenta":          "#cf87e8"
}

panel_size = 24
gap_size = 1

borders = {
    "margin": gap_size,
    "single_margin": gap_size,
    "border_width": 2,
    "border_on_single": True,
    "border_focus": colors["accent"],
    "border_normal": colors["disabled"],
}

widget_defaults = dict(
    font=system_font,
    fontsize=14,
    padding=10,
    margin=0,
    foreground=colors["foreground"]
)

sp_size = {
    "width": 0.6,
    "height": 0.6,
    "x": 0.2,
    "y": 0.2,
    "opacity": 1
}

