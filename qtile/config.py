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
import custom_widgets as cw

from libqtile import hook
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from qtile_extras import widget as xwidget

# COMMANDS

mod = "mod4"
alt = "mod1"

terminal = guess_terminal("kitty") or "alacritty"

commands = {
    "runner": "rofi -show drun -show-icons",
    "network": terminal + " -e nmtui",
    "taskmgr": terminal + " -e btop",
    "volume": "pavucontrol",
    "screenshot": "flameshot gui",
}

# HELPER FUNCTIONS
@lazy.window.function
def float_to_front(window):
    if window.floating:
        window.cmd_bring_to_front()
    else:
        window.cmd_bring_to_front()
        window.cmd_disable_floating()


# KEYBINDINGS
keys = [
    # Qtile
    Key([alt, "shift"], "Tab", lazy.next_screen()), # CHANGE WHENEVER

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
    Key([mod], "Return", lazy.spawn(terminal)),  # Launch terminal
    Key([mod], "r", lazy.spawn(commands["runner"])),  # Rofi prompt
    Key([mod, "shift"], "s", lazy.spawn(commands["screenshot"])),  # Take a screenshot
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button1", float_to_front(lazy.window)),
]

groups = []
group_count = 6
group_layout = "columns"

for i in range(group_count):
    groups.append(Group(
        name=str(i + 1),
        layout=str(group_layout),
        label=""
    ))
    keys.extend([
        Key([mod], groups[i].name, lazy.group[groups[i].name].toscreen()),  # Switch to group
        Key([mod, "shift"], groups[i].name, lazy.window.togroup(groups[i].name, switch_group=False)),
        # Move focused window to group
    ])

widget_defaults = dict(
    font=theme.system_font,
    fontsize=14,
    padding=10,
    margin=0,
    foreground=theme.colors["foreground"]
)

groups.append(ScratchPad('sp', [
    DropDown('vol', commands["volume"], **theme.sp_size),     # Volume
    DropDown('net', commands["network"], **theme.sp_size),    # Network
    DropDown('tsk', commands["taskmgr"], **theme.sp_size),    # System Monitor
]))

    
def sp_key(key, code):
    return Key([mod], key, lazy.group['sp'].dropdown_toggle(code))


keys.extend([
    sp_key("v", "vol"),
    sp_key("b", "tsk"),
])

layouts = [
    layout.Columns(**theme.borders),
    layout.Max(**theme.borders),
]

# FLOATING WINDOW RULES "xprop"
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='unityhub'),
        Match(wm_class='Unity'),
        Match(wm_class='Welcome to PyCharm'),
        Match(wm_class='Welcome to Android Studio'),
        Match(title="osu!"),
    ],
    **theme.borders
)


def get_bar(index):
    systray = [cw.systray()] if index == 2 else []
    return {
        "widgets": [
            cw.layout(),
            cw.workspaces(),
            cw.spacer(),
            cw.window_name(),
            cw.spacer(),
            *systray,
            cw.caps(),
            cw.keyboard(),
            cw.scratchpad("󰈀", "net"),
            cw.volume(),
            cw.clock()
        ],
        "size": theme.panel_size,
        "background": theme.colors["background"],
        "margin": [theme.gap_size, 0, 0, 0],
        "gaps": {
            "left": bar.Gap(theme.gap_size),
            "right": bar.Gap(theme.gap_size),
            "top": bar.Gap(theme.gap_size)
        }
    }

screens = [
    Screen(bottom=bar.Bar(**get_bar(0))),
    Screen(bottom=bar.Bar(**get_bar(1))),
    Screen(bottom=bar.Bar(**get_bar(2)))
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

