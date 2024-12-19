# VARIABLES !!!IMPORTANT!!!
import os

mod1 = "mod4"   # Super                                     # Primary mod key
mod2 = "mod1"   # Alt                                       # Secondary mod key
mod3 = "shift"                                              # Tertiary mod key
mod4 = "control"                                            # Quaternary mod key

primary_screen = 1                                          # Primary screen (used for the systray)
screen_count = 3                                            # Number of screens
workspace_per_screen = 3                                    # Number of workspaces per screen
default_layout = "columns"                                  # Default layout
base_dir = os.path.expanduser("~/.config/qtile/scripts/")   # Scripts directory
autostart_scripts = [
        "display_settings_x11.sh",
        "autostart.sh",
        ]

workspace_count = screen_count * workspace_per_screen       # DO NOT MODIFY!!!
