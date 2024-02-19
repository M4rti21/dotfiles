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

import os
import subprocess
import theme
from typing import List
from classes import ScrPad
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

# VARIABLES !!!IMPORTANT!!!
mod1 = "mod4"   # Super                                     # Primary mod key
mod2 = "mod1"   # Alt                                       # Secondary mod key
mod3 = "shift"                                              # Tertiary mod key
mod4 = "control"                                            # Quaternary mod key

primary_screen          = 1                                 # Primary screen (used for the systray)
screen_count            = 3                                 # Number of screens
workspace_per_screen    = 3                                 # Number of workspaces per screen
default_layout          = "columns"                         # Default layout
base_dir = os.path.expanduser("~/.config/qtile/scripts/")   # Scripts directory
autostart_scripts = [
        "display_settings_x11.sh",
        "autostart.sh",
        ]
workspace_count = screen_count * workspace_per_screen       # DO NOT MODIFY!!!


# PROGRAMS
terminal    = guess_terminal("alacritty") or "xterm"
runner      = "rofi -show drun -show-icons"
ss_select   = "flameshot gui"
ss_full     = "flameshot full"

# SCRATCHPADS 
sps: List[ScrPad] =[
        # volume control
        ScrPad(
            name = "pavucontrol",
            key = "v",
            is_flatpak = False,
            flatpak = "",
            ),
        # music player
        ScrPad(
            name = "spotify",
            key = "m",
            is_flatpak = True,
            flatpak = "flatpak run com.spotify.Client",
            ),
        # task manager
        ScrPad(
            name = terminal + " -e btop",
            key = "b",
            is_flatpak = False,
            flatpak = "",
            ),
        # network manager
        ScrPad(
            name = terminal + " -e nmtui",
            key = "n",
            is_flatpak = False,
            flatpak = "",
            ),
        # password manager
        ScrPad(
            name = "bitwarden",
            key = "p",
            is_flatpak = True,
            flatpak = "flatpak run com.bitwarden.desktop",
            ),
        ]

# QTILE CONFIG
dgroups_key_binder = None                   # (None | "M") 
dgroups_app_rules = []                      # (List of rules)
auto_fullscreen = True                      # (True | False)
bring_front_click = "floating_only"         # (True | False | "floating_only")
cursor_warp = False                         # (True | False)
floats_kept_above = True                    # (True | False)
follow_mouse_focus = False                  # (True | False)
focus_on_window_activation = "smart"        # ("urgent" | "focus" | "smart" | "never")
reconfigure_screens = True                  # (True | False)
auto_minimize = False                       # (True | False)
wl_input_rules = None                       # (None | List of rules)
wmname = "LG3D"                             # Just use LG3D because it makes Java apps work :/

# QTILE ARRAYS (DO NOT MODIFY)
keys    = []
mouse   = []
groups  = []
screens = []
layouts = []

# KEYBINDINGS
keys.extend([
        # Qtile controls
        Key([mod1, mod4], "r", lazy.reload_config()),                                   # Reload the config
        Key([mod1, mod4], "q", lazy.shutdown()),                                        # Shutdown Qtile
        Key([mod1], "Tab", lazy.next_layout()),                                         # Toggle between layouts
        Key([mod2], "Tab", lazy.group.next_window(), lazy.window.bring_to_front()),     # Move window focus to other window
        # Switch between windows
        Key([mod1], "h", lazy.layout.left()),                   # Move focus to left
        Key([mod1], "l", lazy.layout.right()),                  # Move focus to right
        Key([mod1], "j", lazy.layout.down()),                   # Move focus down
        Key([mod1], "k", lazy.layout.up()),                                                                                                                                                                                                                                                              # Move focus up
        # Move windows
        Key([mod1, mod3], "h", lazy.layout.shuffle_left()),     # Move window to the left
        Key([mod1, mod3], "l", lazy.layout.shuffle_right()),    # Move window to the right
        Key([mod1, mod3], "j", lazy.layout.shuffle_down()),     # Move window down
        Key([mod1, mod3], "k", lazy.layout.shuffle_up()),       # Move window up
        # Resize window
        Key([mod1, mod4], "h", lazy.layout.grow_left()),        # Grow window to the left
        Key([mod1, mod4], "l", lazy.layout.grow_right()),       # Grow window to the right
        Key([mod1, mod4], "j", lazy.layout.grow_down()),        # Grow window down
        Key([mod1, mod4], "k", lazy.layout.grow_up()),          # Grow window up
        # Window controls
        Key([mod1], "w", lazy.window.kill()),                   # Kill focused window
        Key([mod1], "f", lazy.window.toggle_fullscreen()),      # Toggle fullscreen on the focused window
        Key([mod1], "t", lazy.window.toggle_floating()),        # Toggle floating on the focused window
        # Run programs
        Key([mod1], "r", lazy.spawn(runner)),                   # Rofi prompt
        Key([mod1], "Return", lazy.spawn(terminal)),            # Launch terminal
        Key([mod1, mod3], "s", lazy.spawn(ss_select)),          # Take a screenshot
        Key([mod1, mod4], "s", lazy.spawn(ss_full)),            # Take a screenshot
        # Extras
        Key([mod1], "space", lazy.widget["keyboardlayout"].next_keyboard()),    # Toggle between keyboard layouts
        ])

mouse.extend([
        Drag([mod1], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod1], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([mod1], "Button1", lazy.window.bring_to_front()),
        ])

# SCRATCHPADS
drop_downs = []
for sp in sps:
    if sp.is_flatpak:
        drop_downs.append(
            DropDown(sp.key, sp.flatpak, match=Match(wm_class=sp.name), **theme.sp_size),
            )
    else:
        drop_downs.append(
            DropDown(sp.key, sp.name, **theme.sp_size),
            )

    keys.append(Key([mod1], sp.key, lazy.group['sp'].dropdown_toggle(sp.key)))
        
groups.append(ScratchPad('sp', drop_downs))


# GROUPS
# This function is a helper to keep each group on its own screen for a multi monitor setup
def go_to_group(name):
    def f(qtile):
        screen_index = (int(name) - 1) % screen_count
        qtile.cmd_to_screen(screen_index)
        qtile.groups_map[name].cmd_toscreen()
    return f

# Create groups
for name in map(str, range(1, workspace_count + 1)):
    # Create a group
    groups.append(Group(
        name=name,
        layout=default_layout,
        label=name
    ))
    # Add keybindings for the group
    keys.extend([
        Key([mod1], name, lazy.function(go_to_group(name))),
        Key([mod1, 'shift'], name, lazy.window.togroup(name)),
    ])

layouts.extend([
        Columns(**theme.borders),
        Max(**theme.borders),
        ])

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
    if index + 1 == primary_screen:
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

    for i in range(workspace_count):
        if i % screen_count == index:
            visible_groups.append(str(i + 1))

    pannel = {
            "size" : theme.panel_size,
            "margin" : theme.panel_margin,
            "background" : theme.colors["background"],
            "widgets" : [
                widget.CurrentLayoutIcon(
                    scale=0.75,
                    use_mask=True,
                    foreground=theme.colors["foreground"],
                    ),
                widget.GroupBox(
                    font=theme.font_family,
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

if theme.panel_top:
    for i in range(screen_count):
        screens.append(
            Screen(
                top=bar.Bar(**get_bar(i)),
                left=bar.Gap(theme.outter_gap),
                right=bar.Gap(theme.outter_gap),
                bottom=bar.Gap(theme.outter_gap),
                )
            )
else:
    for i in range(screen_count):
        screens.append(
        Screen(
            top=bar.Gap(theme.outter_gap),
            left=bar.Gap(theme.outter_gap),
            right=bar.Gap(theme.outter_gap),
            bottom=bar.Bar(**get_bar(i)),
            )
        )

widget_defaults = theme.widget_defaults

# AUTO START PROGRAMS
@hook.subscribe.startup_once
def autostart():
    for script in autostart_scripts:
        subprocess.Popen([base_dir + script]) 
