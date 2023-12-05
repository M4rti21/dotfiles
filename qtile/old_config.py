#   qtile config by:
#   
#    ███╗   ███╗██╗  ██╗██████╗ ████████╗██╗
#    ████╗ ████║██║  ██║██╔══██╗╚══██╔══╝██║
#    ██╔████╔██║███████║██████╔╝   ██║   ██║
#    ██║╚██╔╝██║╚════██║██╔══██╗   ██║   ██║
#    ██║ ╚═╝ ██║     ██║██║  ██║   ██║   ██║
#    ╚═╝     ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝
#
#   github repo: https://github.com/M4rti21/dotconfig


import os
import subprocess

from libqtile import hook

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(["mod1"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack",),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Toggle between keyboard layouts"),
    # Run PROGRAMS
    Key([mod], "r", lazy.spawn("rofi -show run"), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "s", lazy.spawn("flameshot --gui"), desc="Flameshot take screenshot"),
]

colors = {
    "red": "#b54754",
    "darkred": "#512026",
    "green": "#a1b56c",
    "yellow": "#f7ca88",
    "blue": "#7cafc2",
    "magenta": "#ba8baf",
    "cyan": "#86c1b9",
    "black": "#181818",
    "white": "#d8d8d8",
    "gray": "#2e2e2e",
}


groups = []
group_names = ["1", "2", "3", "4", "5", "8"]
group_label = " "
group_layouts = ["columns", "columns", "columns", "columns", "columns", "columns"]

for i in range(len(group_names)):
    groups.append(Group(
        name=group_names[i],
        layout=group_layouts[i],
        label=group_label
    ))

    keys.extend([
        Key(
            [mod], groups[i].name, lazy.group[groups[i].name].toscreen(), 
            desc="Switch to group {}".format(groups[i].name)
        ),
        Key(
            [mod, "shift"], groups[i].name, lazy.window.togroup(groups[i].name, switch_group=True), 
            desc="Switch to & move focused window to group {}".format(groups[i].name)
        ),
    ])

margin_size = 4

borders = {
    "margin": margin_size,
    "single_margin": margin_size,
    "border_width": 4,
    "border_on_single": True,
    "border_focus": colors["red"],
    "border_normal": colors["black"],
}

layouts = [
    layout.Columns(**borders),
    layout.Max(**borders),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(**borders),
    # layout.Matrix(),
    # layout.MonadTall(**borders),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="BlexMono Nerd Font Medium",
    fontsize=14,
    padding=4,
    margin=1
)

extension_defaults = widget_defaults.copy()


panel_size = 32

groupbox_config = {
    "highlight_method": "line",
    "highlight_color": [colors["black"], colors["black"]],
    "inactive": colors["black"],
    "this_screen_border": colors["red"],
    "this_current_screen_border": colors["red"],
    "active": colors["white"],
    "other_current_screen_border": colors["red"],
    "other_screen_border": colors["darkred"],
    "margin_y": 4
}

spacer_len = 20

powerline = {
    "decorations": [
        PowerLineDecoration(path="arrow_left")
    ]
}

powerline_r = {
    "decorations": [
        PowerLineDecoration(path="arrow_right")
    ]
}

def window_name_parse(text):
    return text.split('-')[-1].strip()

def get_new_bar(is_primary):
    return {
        "widgets":[
            widget.CurrentLayoutIcon(
                scale=0.6, 
                background=colors["yellow"], 
                **powerline
            ), 
            widget.Spacer(length=10),
            widget.GroupBox(**groupbox_config),
            widget.Spacer(length=10, **powerline),
            widget.WindowName(
                parse_text=window_name_parse, 
                padding=10
            ),
            widget.Spacer(),
            widget.Spacer(background=colors["black"], **powerline_r),
            widget.CheckUpdates(
                fmt="󰇚 {}",
                display_format = "{updates}",
                no_update_string = "0",
                background=colors["green"],
                padding=15,
                update_interval = 1800,
                distro = "Arch_checkupdates",
                **powerline_r
            ),
            widget.KeyboardLayout(
                fmt="  {}", 
                configured_keyboards=['us', 'es'], 
                background=colors["yellow"],
                padding=15, 
                **powerline_r
            ),
            widget.Volume(
                emoji=False, 
                emoji_list=["󰝟", "󰕿", "󰖀", "󰕾"], 
                fmt="󰕾 {}", 
                background=colors["magenta"], 
                padding=15, 
                **powerline_r
            ),
            widget.Clock(
                format="󰅐 %H:%M", 
                background=colors["cyan"], 
                padding=15, 
                **powerline_r
            ),
            widget.Clock(
                format="󰃭 %d/%m/%Y", 
                background=colors["blue"], 
                padding=15
            ),
            widget.QuickExit(
                default_text="󰤆", 
                background=colors["red"], 
                padding=15
            ),
        ],
        "size": panel_size,
        "background":"black"
    }

screens = [
    Screen(top=bar.Bar(**get_new_bar(True), left=bar.Gap(4))),
    Screen(top=bar.Bar(**get_new_bar(False), left=bar.Gap(4))),
    Screen(top=bar.Bar(**get_new_bar(False), left=bar.Gap(4)))
]

@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    qtile.cmd_restart()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# AUTO START PROGRAMS
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.Popen([home])
