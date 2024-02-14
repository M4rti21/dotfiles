# THEME SETTINGS

system_font = "MartianMono Nerd Font Medium"
font_size = 12
panel_size = 24
gap_size = 1
border_size = 3
widget_padding = 8

colors = {
        "background": "#080808",
        "foreground": "#bdbdbd",
        "disabled": "#323437",
        "accent": "#cc2850",
        }

borders = {
        "margin" : gap_size,
        "single_margin" : gap_size,
        "border_width" : border_size,
        "border_on_single" : True,
        "border_focus" : colors["accent"],
        "border_normal" : colors["disabled"],
        }

widget_defaults = {
        "font" : system_font,
        "fontsize" : font_size,
        "padding" : widget_padding,
        "margin" : 0,
        "foreground" : colors["foreground"]
        }

sp_size = {
        "width" : 0.6,
        "height" : 0.6,
        "x" : 0.2,
        "y" : 0.2,
        "opacity" : 1
        }
