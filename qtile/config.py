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
from libqtile import hook
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget as xwidget

# COMMANDS

mod = "mod4"
alt = "mod1"

terminal = guess_terminal("alacritty")

commands = {
    "runner": "rofi -combi-modi run,games -show combi -combi-hide-mode-prefix -display-combi search:",
    "logout": "rofi -show power-menu -modi power-menu:rofi-power-menu",
    "updates": terminal + " -e checkupdates && sudo pacman -Syu && sudo yay -Syu",
    "network": terminal + " -e nmtui",
    "taskmgr": terminal + " -e btop",
    "volume": "pavucontrol",
    "screenshot": "flameshot gui",
    "passwd": "bitwarden-desktop",
}

# HELPER FUNCTIONS
@lazy.window.function
def float_to_front(window):
    if window.floating:
        window.cmd_bring_to_front()
    else:
        window.cmd_bring_to_front()
        window.cmd_disable_floating()


def get_icon(name):
    return "~/.config/qtile/icons/" + name + ".svg"


# KEYBINDINGS
keys = [
    # Qtile
    Key([mod, "control"], "r", lazy.reload_config()),                           # Reload the config
    Key([mod, "control"], "q", lazy.shutdown()),                                # Shutdown Qtile
    Key([mod, "shift"], "q", lazy.spawn(commands["logout"])),                   # Logout menu
    Key([mod], "h", lazy.layout.left()),                                        # Move focus to left
    # Switch between windows
    Key([mod], "l", lazy.layout.right()),                                       # Move focus to rightR
    Key([mod], "j", lazy.layout.down()),                                        # Move focus down
    Key([mod], "k", lazy.layout.up()),                                          # Move focus up
    Key([alt], "Tab", lazy.group.next_window(), float_to_front()),              # Move window focus to other window
    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),                       # Move window to the left
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),                      # Move window to the right
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),                       # Move window down
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),                         # Move window up
    # Resize windows
    Key([mod, "control"], "h", lazy.layout.grow_left()),                        # Grow window to the left
    Key([mod, "control"], "l", lazy.layout.grow_rightt()),                      # Grow window to the right
    Key([mod, "control"], "j", lazy.layout.grow_down()),                        # Grow window down
    Key([mod, "control"], "k", lazy.layout.grow_up()),                          # Grow window up
    Key([mod], "n", lazy.layout.normalize()),                                   # Reset all window sizes
    # Layout controls
    Key([mod], "Tab", lazy.next_layout()),                                      # Toggle between layouts
    # Window controls
    Key([mod], "w", lazy.window.kill()),                                        # Kill focused window
    Key([mod], "f", lazy.window.toggle_fullscreen()),                           # Toggle fullscreen on the focused window
    Key([mod], "t", lazy.window.toggle_floating()),                             # Toggle floating on the focused window
    # Controls
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard()),         # Toggle between keyboard layouts
    # Run programs
    Key([mod], "Return", lazy.spawn(terminal)),                                 # Launch terminal
    Key([mod], "r", lazy.spawn(commands["runner"])),                            # Rofi prompt
    Key([mod, "shift"], "s", lazy.spawn(commands["screenshot"])),               # Take a screenshot
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button1", lazy.window.bring_to_front()),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6"]
group_layout = "columns",

for i in range(len(group_names)):
    groups.append(Group(
        name=group_names[i],
        layout=str(group_layout), 
        label=group_names[i]
    ))
    keys.extend([
        Key([mod], groups[i].name, lazy.group[groups[i].name].toscreen()),                              # Switch to group
        Key([mod, "shift"], groups[i].name, lazy.window.togroup(groups[i].name, switch_group=True)),    # Switch & move focused window to group
    ])

# THEME SETTINGS

system_font = "Geist Bold"

colors = {
    "base": "#000000",
    "text": "#eeefef",
    "overlay": "#0f0f0f",
    "disabled": "#363736",
    "accent": "#CC2850",

    "black": "#000000",
    "white": "#eeefef",
    "red": "#df6464",
    "orange": "#ed9e56",
    "yellow": "#edcf58",
    "green": "#c5d05d",
    "cyan": "#81cabe",
    "blue": "#8cb7e0",
    "magenta": "#cfabdf"
}

panel_size = 32
margin_size = 4

borders = {
    "margin": margin_size,
    "single_margin": margin_size,
    "border_width": 2,
    "border_on_single": True,
    "border_focus": colors["accent"],
    "border_normal": colors["disabled"],
}

widget_defaults = dict(
    font=system_font,
    fontsize=14,
    padding=10,
    margin=0,
    foreground=colors["text"]
)

sp_size = {
    "width": 0.6,
    "height": 0.6,
    "x": 0.2,
    "y": 0.2,
    "opacity": 1
}

gaps = {
    "left": bar.Gap(margin_size),
    "right": bar.Gap(margin_size),
    "bottom": bar.Gap(margin_size)
}


groups.append(ScratchPad('sp', [
    DropDown('vol', commands["volume"],**sp_size),      # Volume
    DropDown('net', commands["network"], **sp_size),    # Network
    DropDown('tsk', commands["taskmgr"], **sp_size),    # System Monitor
    DropDown('pwd', commands["passwd"], **sp_size),     # Passwords
]))

keys.extend([
    Key([mod], "v", lazy.group['sp'].dropdown_toggle('vol')),
    Key([mod], "n", lazy.group['sp'].dropdown_toggle('net')),
    Key([mod], "b", lazy.group['sp'].dropdown_toggle('tsk')),
    Key([mod], "p", lazy.group['sp'].dropdown_toggle('pwd')),

])

layouts = [
    layout.Columns(**borders),
    layout.Max(**borders),
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
        Match(title="osu!"),
    ],
    **borders
)


def get_new_bar(screen_id):
    inner_widgets = [
        widget.Systray(icon_size=16),
        widget.Spacer(length=10),
        xwidget.Image(
            filename=get_icon("download"),
            margin=10,
            padding=0,
            colour=colors["text"],
            mask=True,
            mouse_callbacks={'Button1': lazy.spawn(commands["updates"])},
        ),
        widget.CheckUpdates(
            display_format="{updates}",
            no_update_string="0",
            update_interval=1800,
            distro="Arch_checkupdates",
            colour_have_updates=colors["text"],
            colour_no_updates=colors["text"],
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["updates"])},
        ),
    ]

    if screen_id == 2 or screen_id == 3:
        del inner_widgets[0]

    this_widgets = [
        widget.CurrentLayoutIcon(scale=0.6,foreground=colors["text"]),
        widget.GroupBox(
            highlight_method="line",
            highlight_color=[colors["overlay"], colors["overlay"]],
            inactive=colors["disabled"],
            this_screen_border=colors["accent"],
            this_current_screen_border=colors["accent"],
            active=colors["text"],
            other_current_screen_border=colors["disabled"],
            other_screen_border=colors["disabled"],
            padding=4,
            margin_y=4,
            disable_drag=True,
            font=system_font
        ),
        widget.Spacer(),
        widget.Clock(format="%H:%M"),
        widget.Spacer(),
        widget.WidgetBox(
            widgets=inner_widgets,
            text_closed="",
            text_open="",
            close_button_location='right',
        ),
        widget.KeyboardLayout(configured_keyboards=['us', 'es']),
        widget.Volume(
            emoji=False,
            mouse_callbacks={'Button1': lazy.spawn(commands["volume"])},
        ),
        widget.Clock(format="%d-%m-%y"),
        widget.Spacer(length=5),
        xwidget.Image(
            filename=get_icon("power"),
            margin=10,
            colour=colors["base"],
            mask=True,
            background=colors["accent"],
            padding=2,
            mouse_callbacks={'Button1': lazy.spawn(commands["logout"])}
        )
    ]

    return {
        "widgets": this_widgets,
        "size": panel_size,
        "background": colors["overlay"],
        "margin": [0, 0, margin_size, 0],
    }

screens = [
    Screen(top=bar.Bar(**get_new_bar(1)), **gaps),
    Screen(top=bar.Bar(**get_new_bar(2)), **gaps),
    Screen(top=bar.Bar(**get_new_bar(3)), **gaps)
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


@hook.subscribe.screen_change
def restart_on_randr(qtile):
    qtile.cmd_restart()
