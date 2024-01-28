import theme

from libqtile import widget
from qtile_extras import widget as xwidget
from libqtile.lazy import lazy

from widgets.clock import ToggleClock
from widgets.wname import WName
from widgets.caps import Caps
from widgets.lookaway import LookAway

def sp_run(code):
    return lazy.group['sp'].dropdown_toggle(code) 

def systray():
    return widget.WidgetBox(
        widgets=[
            widget.TextBox(text="[", padding=0),
            widget.Systray(icon_size=16),
            widget.TextBox(text=" ]", padding=0),
        ],
        text_closed="",
        text_open="",
        close_button_location='right',
    )


def scratchpad(icon, code):
    return widget.TextBox(
        text=icon,
        mouse_callbacks={'Button1': sp_run(code)}
    )

def updates():
    return widget.CheckUpdates(
        fmt="󰇚 {}",
        display_format="{updates}",
        no_update_string="0",
        update_interval=1800,
        distro="Arch_checkupdates",
        colour_have_updates=theme.colors["foreground"],
        colour_no_updates=theme.colors["foreground"],
    )

def layout():
    return widget.CurrentLayoutIcon(
        scale=0.75,
        use_mask=True, 
        foreground=theme.colors["foreground"]
    )

def workspaces():
    return widget.GroupBox(
        highlight_method="line",
        highlight_color=[theme.colors["background"], theme.colors["background"]],
        inactive=theme.colors["disabled"],
        this_screen_border=theme.colors["accent"],
        this_current_screen_border=theme.colors["accent"],
        active=theme.colors["foreground"],
        other_current_screen_border=theme.colors["disabled"],
        other_screen_border=theme.colors["disabled"],
        padding=4,
        margin_y=4,
        disable_drag=True,
        font=theme.system_font,
    )

def window_name():
    return WName()

def spacer():
    return widget.Spacer()

def caps():
    return Caps()

def keyboard():
    return widget.KeyboardLayout(
        configured_keyboards=['us', 'es']
    )

def clock():
    return ToggleClock()

def volume():
    return widget.Volume(
        fmt="󰕾 {}",
        emoji=False,
        mouse_callbacks={'Button1': sp_run('vol')},
    )
