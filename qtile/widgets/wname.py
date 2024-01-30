from libqtile import hook
from libqtile.widget import base

class WName(base._TextBox):
    """Displays the name of the window that currently has focus"""

    defaults = [
        ("for_current_screen", True, ""),
        ("empty_group_string"," ", ""),
        ("format", "{name}", "format of the text"),
        ("parse_text", None, ""),
    ]

    def __init__(self, **config):
        base._TextBox.__init__(self, **config)
        self.add_defaults(self.defaults)

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        hook.subscribe.client_name_updated(self.hook_response)
        hook.subscribe.focus_change(self.hook_response)
        hook.subscribe.float_change(self.hook_response)
        hook.subscribe.current_screen_change(self.hook_response_current_screen)

    def remove_hooks(self):
        hook.unsubscribe.client_name_updated(self.hook_response)
        hook.unsubscribe.focus_change(self.hook_response)
        hook.unsubscribe.float_change(self.hook_response)
        hook.unsubscribe.current_screen_change(self.hook_response_current_screen)

    def hook_response(self, *args):
        window = self.qtile.current_screen.group.current_window
        if window is None:
            name = ""
        else:
            name = self.qtile.current_screen.group.current_window._wm_class[1]
        title = str(name.title()).lower()
        self.update(title)

    def hook_response_current_screen(self, *args):
        if self.for_current_screen:
            self.hook_response()

    def finalize(self):
        self.remove_hooks()
        base._TextBox.finalize(self)
