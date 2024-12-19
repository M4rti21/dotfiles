import theme
import variables
from widgets.caps import Caps
from widgets.clock import ToggleClock
from libqtile import widget
from libqtile.lazy import lazy

workspace_count = variables.workspace_count
screen_count = variables.screen_count
primary_screen = variables.primary_screen

def get_bar(index):
    return {
            "size" : theme.panel_size,
            "margin" : theme.panel_margin,
            "background" : theme.bar_color + theme.opaccity,
            "widgets" : [
                widget.GroupBox(
                    font=theme.font_family,
                    highlight_method="text",
                    highlight_color=[theme.bar_color, theme.bar_color],
                    inactive=theme.colors["disabled"],
                    this_screen_border=theme.colors["fg"],
                    this_current_screen_border=theme.colors["accent"],
                    active=theme.colors["fg"],
                    other_current_screen_border=theme.colors["disabled"],
                    other_screen_border=theme.colors["disabled"],
                    scroll=False,
                    padding=1,
                    margin_y=1,
                    disable_drag=True,
                    use_mouse_wheel=False,
                    )
                ],
            }
