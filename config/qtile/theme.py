# THEME SETTINGS

font_family = "MartianMono Nerd Font"
font_weight = "Medium"
font_size = 12
border_size = 2
inner_gap = 4
outter_gap = 4
panel_size = 21
panel_top = False
widget_padding = 8
widget_margin = 0

panel_margin = []

if panel_top:
    panel_margin = [0, 0, outter_gap, 0]
else:
    panel_margin = [outter_gap, 0, 0, 0]

colors = dict(
        background = "#000000",
        foreground = "#bdbdbd",
        disabled = "#323437",
        accent = "#cc2850",
        )

borders = dict(
        margin = inner_gap,
        single_margin = inner_gap,
        border_width = border_size,
        border_on_single = True,
        border_focus = colors["accent"],
        border_normal = colors["disabled"],
        )

widget_defaults = dict(
        font = font_family + " " + font_weight,
        fontsize = font_size,
        padding = widget_padding,
        margin = widget_margin,
        foreground= colors["foreground"]
        )

sp_size = dict(
        opacity= 1,
        width= 0.6,
        height= 0.6,
        x= 0.2,
        y= 0.2,
)
