#   qtile config by:
#
#    ███╗   ███╗██╗  ██╗██████╗ ████████╗██╗
#    ████╗ ████║██║  ██║██╔══██╗╚══██╔══╝██║
#    ██╔████╔██║███████║██████╔╝   ██║   ██║
#    ██║╚██╔╝██║╚════██║██╔══██╗   ██║   ██║
#    ██║ ╚═╝ ██║     ██║██║  ██║   ██║   ██║
#    ╚═╝     ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝
#
#   github repo: https://github.com/M4rti21/dotfiles

import subprocess
import theme
from widgets.caps import  Caps
from widgets.clock import ToggleClock
from libqtile import hook, widget
from libqtile import bar
from libqtile.layout.max import Max
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# PROGRAMS
terminal = guess_terminal("alacritty")

# HELPER FUNCTIONS
@lazy.window.function
def float_to_front(window):
    window.cmd_bring_to_front()

groups = []

# KEYBINDINGS
mod = "mod4"
alt = "mod1"

keys = [
        Key([mod, "control"], "r", lazy.reload_config()),  # Reload the config
        Key([mod, "control"], "q", lazy.shutdown()),  # Shutdown Qtile
        Key([mod], "h", lazy.layout.left()),  # Move focus to left
        # Switch between windows
        Key([mod], "l", lazy.layout.right()),  # Move focus to right
        Key([mod], "j", lazy.layout.down()),  # Move focus down
        Key([mod], "k", lazy.layout.up()),  # Move focus up
        Key([alt], "Tab", lazy.group.next_window(), float_to_front()),  # Move window focus to other window
        # Move windows
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),  # Move window to the left
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),  # Move window to the right
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),  # Move window down
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),  # Move window up
        # Resize windows
        Key([mod, "control"], "h", lazy.layout.grow_left()),  # Grow window to the left
        Key([mod, "control"], "l", lazy.layout.grow_right()),  # Grow window to the right
        Key([mod, "control"], "j", lazy.layout.grow_down()),  # Grow window down
        Key([mod, "control"], "k", lazy.layout.grow_up()),  # Grow window up
        # Layout controls
        Key([mod], "Tab", lazy.next_layout()),  # Toggle between layouts
        # Window controls
        Key([mod], "w", lazy.window.kill()),  # Kill focused window
        Key([mod], "f", lazy.window.toggle_fullscreen()),  # Toggle fullscreen on the focused window
        Key([mod], "t", lazy.window.toggle_floating()),  # Toggle floating on the focused window
        # Controls
        Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard()),  # Toggle between keyboard layouts
        # Run programs
        Key([mod], "r", lazy.spawn("rofi -show drun -show-icons")),  # Rofi prompt
        Key([mod], "Return", lazy.spawn(terminal)),  # Launch terminal
        Key([mod, "shift"], "s", lazy.spawn("flameshot gui")),  # Take a screenshot
        Key([mod, "control"], "s", lazy.spawn("flameshot full")),  # Take a screenshot
        # Scratchpads
        Key([mod], "v", lazy.group['sp'].dropdown_toggle("pavucontrol"))
        ]

mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([mod], "Button1", float_to_front(lazy.window)),
        ]

for name in ["1", "2", "3", "4", "5", "6", "7", "8", "9"]:
    def go_to_group(name):
        def f(qtile):
            if name in ["1", "4", "7"]:
                qtile.cmd_to_screen(0)
            elif name in ["2", "5", "8"]:
                qtile.cmd_to_screen(1)
            elif name in ["3", "6", "9"]:
                qtile.cmd_to_screen(2)
            qtile.groups_map[name].cmd_toscreen()
        return f

    groups.append(Group(
        name=name,
        layout="columns",
        label=name
        ))

    keys.extend([
        Key([mod], name, lazy.function(go_to_group(name))),
        Key([mod, 'shift'], name, lazy.window.togroup(name)),
        ])

groups.append(ScratchPad('sp', [
    DropDown('vol', "pavucontrol", **theme.sp_size),
    ]))

widget_defaults = theme.widget_defaults

layouts = [
        Columns(**theme.borders),
        Max(**theme.borders),
        ]

# FLOATING WINDOW RULES "xprop"
floating_layout = Floating(
        float_rules=[
            *Floating.default_float_rules,
            Match(wm_class='confirm'),
            Match(wm_class='dialog'),
            Match(wm_class='download'),
            Match(wm_class='error'),
            Match(wm_class='file_progress'),
            Match(wm_class='notification'),
            Match(wm_class='splash'),
            Match(wm_class='toolbar'),
            ],
        **theme.borders
        )

def get_bar(index):
    systray = []
    if index == 0:
        systray = [
                widget.WidgetBox(
                    widgets=[
                        widget.TextBox(text="[", padding=0),
                        widget.Systray(icon_size=16),
                        widget.TextBox(text=" ]", padding=0),
                    ],
                text_closed="",
                text_open="",
                close_button_location='right',
                )
            ]

    visible_groups = []

    if index == 0:
        visible_groups = ["1", "4", "7"]
    elif index == 1:
        visible_groups = ["2", "5", "8"]
    elif index == 2:
        visible_groups = ["3", "6", "9"]

    pannel = {
            "size" : theme.panel_size,
            "margin" : [theme.gap_size, 0, 0, 0],
            "background" : theme.colors["background"],
            "widgets" : [
                widget.CurrentLayoutIcon(
                    scale=0.75,
                    use_mask=True,
                    foreground=theme.colors["foreground"],
                    ),
                widget.GroupBox(
                    visible_groups=visible_groups,
                    highlight_method="line",
                    highlight_color=[theme.colors["background"], theme.colors["background"]],
                    inactive=theme.colors["disabled"],
                    this_screen_border=theme.colors["foreground"],
                    this_current_screen_border=theme.colors["accent"],
                    active=theme.colors["foreground"],
                    other_current_screen_border=theme.colors["disabled"],
                    other_screen_border=theme.colors["disabled"],
                    scroll=False,
                    borderwidth=2,
                    padding=4,
                    margin_y=4,
                    disable_drag=True,
                    use_mouse_wheel=False,
                    ),
                widget.WindowName(format="{name}"),
                widget.Spacer(),
                *systray,
                Caps(),
                widget.KeyboardLayout(
                    configured_keyboards=['us', 'es cat'],
                    display_map={'us': 'ENG', 'es cat': 'CAT'},
                    ),
                widget.Volume(
                    fmt=" {}",
                    emoji=False,
                    emoji_list=["󰸈", "󰕿", "󰖀", "󰕾"],
                    mouse_callbacks={'Button1': lazy.group['sp'].dropdown_toggle("vol") } 
                    ),
                ToggleClock(),
                widget.QuickExit(
                    default_text="",
                    countdown_format="{}",
                    countdown_start=4,
                    ),
                widget.Spacer(length=theme.widget_padding),
                ],
            }
    return pannel

screens = [
        Screen(
            bottom=bar.Bar(**get_bar(0)),
            left=bar.Gap(theme.gap_size),
            right=bar.Gap(theme.gap_size),
            top=bar.Gap(theme.gap_size),
            ),
        Screen(
            bottom=bar.Bar(**get_bar(1)),
            left=bar.Gap(theme.gap_size),
            right=bar.Gap(theme.gap_size),
            top=bar.Gap(theme.gap_size),
            ),
        Screen(
            bottom=bar.Bar(**get_bar(2)),
            left=bar.Gap(theme.gap_size),
            right=bar.Gap(theme.gap_size),
            top=bar.Gap(theme.gap_size),
            ),
        ]

dgroups_key_binder = None
dgroups_app_rules = []

auto_fullscreen = True                  # (True | False)
bring_front_click = "floating_only"     # (True | False | "floating_only")
cursor_warp = False                     # (True | False)
floats_kept_above = True                # (True | False)
follow_mouse_focus = False              # (True | False)
focus_on_window_activation = "smart"    # ("urgent" | "focus" | "smart" | "never")
reconfigure_screens = True              # (True | False)
auto_minimize = False                   # (True | False)
wl_input_rules = None
wmname = "LG3D"

# AUTO START PROGRAMS
@hook.subscribe.startup_once
def autostart():
    base_dir = "/home/m4rti/.config/qtile/scripts/"
    subprocess.run(base_dir + "display_settings.sh")
    subprocess.run(base_dir + "autostart.sh")
