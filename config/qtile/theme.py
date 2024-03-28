# THEME SETTINGS

font_family = "MartianMono Nerd Font"
font_weight = "Regular"
font_size = 10
border_size = 1
inner_gap = 0
outter_gap = 0
panel_size = 12
panel_top = False
widget_padding = 8
widget_margin = 0
opaccity = "ee"         # Opacity for the bar "00" to "ff 
panel_margin = []

if panel_top:
    panel_margin = [0, 0, outter_gap, 0]
else:
    panel_margin = [outter_gap, 0, 0, 0]

colors = dict(
        background = "#000000",
        foreground = "#f0f0f0",
        disabled = "#323437",
        dark = "#000000",
        accent = "#cc0000",
        )

bar_color = colors["dark"]

borders = dict(
        margin = inner_gap,
        single_margin = inner_gap,
        border_width = border_size,
        border_on_single = False,
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
