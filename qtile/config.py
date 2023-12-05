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
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from qtile_extras.widget.decorations import BorderDecoration

mod = "mod4"
terminal = guess_terminal("alacritty")

commands = {
    "runner": "rofi -combi-modi run,games -show combi -display-combi search:",
    "updates": terminal + " -e checkupdates && sudo pacman -Syu && sudo yay -Syu",
    "network": terminal + " -e nmtui",
    "taskmgr": terminal + " -e btop",
    "screenshot": "shutter -s",
}

colors = {
    "red": "#d71921",
    "orange": "#F48E3F",
    "yellow": "#FFD700",
    "green": "#00881C",
    "blue": "#0076FF",
    "cyan": "#40E0D0",
    "magenta": "#FF88A6",
    "black": "#1b1b1d",
    "white": "#f1f1f1",
    "gray": "#929292",
    "darkgray": "#5f5f5f",
}

def get_icon(name):
    return "~/.config/qtile/icons/" + name + ".svg";

system_font = "GT Walsheim Pro Bold"

panel_size = 32
margin_size = 4

keys = [
    # Qtile
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(["mod1"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Resize windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_rightt(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    
    # Layout controls
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Window controls
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Toggle between keyboard layouts"),

    # Run programs
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawn(commands["runner"]), desc="Rofi prompt"),
    Key([mod, "shift"], "s", lazy.spawn(commands["screenshot"]), desc="Take a screenshot"),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6"]
group_layout = "columns",

for i in range(len(group_names)):
    groups.append(Group(name=group_names[i], layout=group_layout, label=group_names[i]))

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

borders = {
    "margin": margin_size,
    "single_margin": margin_size,
    "border_width": 2,
    "border_on_single": True,
    "border_focus": colors["red"],
    "border_normal": colors["black"],
}

layouts = [
    layout.Columns(**borders),
    layout.Max(**borders),
    # layout.Stack(num_stacks=2, **borders),
    # layout.Bsp(**borders),
    # layout.Matrix(**borders),
    # layout.MonadTall(**borders),
    # layout.MonadWide(**borders),
    # layout.RatioTile(**borders),
    # layout.Tile(**borders),
    # layout.TreeTab(**borders),
    # layout.VerticalTile(**borders),
    # layout.Zoomy(**borders),
]

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
        Match(title="osu!"),
        Match(wm_class="pavucontrol"),
    ],
    **borders
)

widget_defaults = dict(
    # font="BlexMono Nerd Font Medium",
    font=system_font,
    fontsize=14,
    padding=10,
    margin=1,
    foreground=colors["white"]
)

extension_defaults = widget_defaults.copy()

dec = {
    "border_width": [0, 0, 0, 0],
    "padding_x": 5,
    "padding_y": None,
}


def get_new_bar(screen_id): 
    
    def window_name_parse(text):
        # return text.split('-')[-1].strip()
        return text.strip()

    inner_widgets = [
        widget.Systray(
            icon_size=16,
            decorations=[
                BorderDecoration(
                    colour=colors["red"],
                    **dec
                )
            ]
        ),
        widget.Spacer(
            length=10
        ),
        widget.Image(
            filename=get_icon("download"),
            margin=10,
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["updates"])},
        ),
        widget.CheckUpdates(
            fmt="{}",
            display_format="{updates}",
            no_update_string="0",
            update_interval=1800,
            distro="Arch_checkupdates",
            colour_have_updates=colors["white"],
            colour_no_updates=colors["white"],
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["updates"])},
        ),
        widget.Spacer(
            length=10
        ),
        widget.Image(
            filename=get_icon("amd"),
            margin=10,
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["taskmgr"])},
        ),
        widget.CPU(
            format="{load_percent}%",
            update_interval=5,
            padding=0,
            margin=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["taskmgr"])},
        ),
        widget.Spacer(
            length=10
        ),
        widget.Image(
            filename=get_icon("nvidia"),
            margin=10,
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["taskmgr"])},
        ),
        widget.NvidiaSensors(
            format="{temp} °C",
            padding=0,
            margin=0,
            update_interval=5,
            mouse_callbacks={'Button1': lazy.spawn(commands["taskmgr"])},
        ),
        widget.Spacer(
            length=10
        ),
        widget.Image(
            filename=get_icon("ram"),
            margin=10,
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["network"])},
        ),
        widget.Memory(
            measure_mem='G',
            format="{MemUsed:.0f} / {MemTotal:.0f} G",
            padding=0,
            margin=0,
            update_interval=5,
        ),
        widget.Spacer(
            length=10
        ),
        widget.Image(
            filename=get_icon("network"),
            margin=10,
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["network"])},
        )
    ]

    if screen_id == 2 or screen_id == 3:
        del inner_widgets[0]

    show_widgetbox = not screen_id == 3;

    this_widgets = [
        widget.CurrentLayoutIcon(
            scale=0.6,
            foreground=colors["white"],
        ),
        widget.GroupBox(
            highlight_method="line",
            highlight_color=[colors["black"], colors["black"]],
            inactive=colors["gray"],
            this_screen_border=colors["red"],
            this_current_screen_border=colors["red"],
            active=colors["white"],
            other_current_screen_border=colors["darkgray"],
            other_screen_border=colors["darkgray"],
            padding=4,
            margin_y=4,
            disable_drag=True,
            font=system_font
        ),
        widget.WindowName(
            parse_text=window_name_parse,
            for_current_screen=True,
            format="{name}"
        ),
        # widget.Spacer(),
        widget.WidgetBox(
            widgets=inner_widgets,
            fmt="{}",
            text_closed="",
            text_open="",
            close_button_location='right',
            start_opened=show_widgetbox,
        ),
        widget.Image(
            filename=get_icon("search"),
            margin=10,
            padding=0,
            mouse_callbacks={'Button1': lazy.spawn(commands["runner"])},
        ),
        widget.KeyboardLayout(
            fmt="{}",
            configured_keyboards=['us', 'es'],
        ),
        widget.Volume(
            fmt="{}",
            emoji=False,
            emoji_list=["󰝟", "󰕿", "󰖀", "󰕾"],
            mouse_callbacks={'Button1': lazy.spawn("pavucontrol")},
        ),
        widget.Clock(
            format="%d/%m/%y",
        ),
        widget.Clock(
            format="%H:%M",
        ),
        widget.Spacer(
            length=5
        ),
        widget.Image(
            filename=get_icon("power"),
            margin=10,
            background=colors["red"],
            mouse_callbacks={'Button1': lazy.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu")}
        )
    ]

    return {
        "widgets": this_widgets,
        "size": panel_size,
        "background":colors["black"],
        "margin":[0, 0, margin_size, 0]
    }


gaps = {
    "left":bar.Gap(margin_size),
    "right":bar.Gap(margin_size),
    "bottom":bar.Gap(margin_size)    
}

screens = [
    Screen(top=bar.Bar(**get_new_bar(1)), **gaps),
    Screen(top=bar.Bar(**get_new_bar(2)), **gaps),
    Screen(top=bar.Bar(**get_new_bar(3)), **gaps)
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []

# If a window requests to be fullscreen, it is automatically fullscreened.
# (True | False)
auto_fullscreen = True

# When clicked, should the window be brought to the front or not.
# (True | False | "floating_only")R
bring_front_click = "floating_only"

# If true, the cursor follows the focus as directed by the keyboard, warping to the center of the focused window. 
# When switching focus between screens, If there are no windows in the screen, the cursor will warp to the center of the screen.
# (True | False)
cursor_warp = False

# Floating windows are kept above tiled windows (Currently x11 only. Wayland support coming soon.)
# (True | False)
floats_kept_above = True

# Controls whether or not focus follows the mouse around as it moves across windows in a layout.
# (True | False)
follow_mouse_focus = False

# Behavior of the _NET_ACTIVATE_WINDOW message sent by applications.
# ("urgent" | "focus" | "smarti" | "never")
focus_on_window_activation = "smart"

# Controls whether or not to automatically reconfigure screens when there are changes in randr output configuration.
# (True | False)
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing focus, should we respect this or not?
# (True | False)
auto_minimize = False 

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
