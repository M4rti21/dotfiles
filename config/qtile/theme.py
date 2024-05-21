# THEME SETTINGS

font_family = "MartianMono Nerd Font"
font_weight = "Regular"
font_size = 10
border_size = 1
inner_gap = 0
outter_gap = 0
panel_size = 1
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
        fg      = "#f1f1f1",
        fg2     = "#919191",

        bg      = "#1e1e1e",
        bg1     = "#242424",
        bg2     = "#343434",
        bg3     = "#919191",
        
        black   = "#000000",
        disabled = "#303030",
        border  = "#343434",
        
        accent  = "#d71921",
        accent2 = "#770000",
        
        danger  = "#ed333b",
        success = "#33d17a",
        warning = "#f8e45c",
        info    = "#3584e4"
        )

bar_color = colors["black"]

borders = dict(
        margin = inner_gap,
        single_margin = inner_gap,
        border_width = border_size,
        border_on_single = False,
        border_focus = colors["fg2"],
        border_normal = colors["disabled"],
        )

widget_defaults = dict(
        font = font_family + " " + font_weight,
        fontsize = font_size,
        padding = widget_padding,
        margin = widget_margin,
        foreground= colors["fg"]
        )

sp_size = dict(
        opacity= 1,
        width= 0.6,
        height= 0.6,
        x= 0.2,
        y= 0.2,
)
