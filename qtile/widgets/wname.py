from libqtile import hook
from libqtile.widget.base import _TextBox

class WName(_TextBox):
    """Displays the name of the window that currently has focus"""
    short_name = False

    def __init__(self, **config):
        _TextBox.__init__(self, **config)
        self.short_name = config.get("short_name", False)

    def _configure(self, qtile, bar):
        _TextBox._configure(self, qtile, bar)
        hook.subscribe.client_name_updated(self.hook_response)
        hook.subscribe.focus_change(self.hook_response)
        hook.subscribe.float_change(self.hook_response)
        hook.subscribe.current_screen_change(self.hook_response_current_screen)

    def remove_hooks(self):
        hook.unsubscribe.client_name_updated(self.hook_response)
        hook.unsubscribe.focus_change(self.hook_response)
        hook.unsubscribe.float_change(self.hook_response)
        hook.unsubscribe.current_screen_change(self.hook_response_current_screen)

    def hook_response(self):
        window = self.qtile.current_screen.group.current_window
        if window is None:
            name = ""
        else:
            if self.short_name:
                name = self.qtile.current_screen.group.current_window._wm_class[1]
            else:
                name = self.qtile.current_screen.group.current_window.name
        title = str(name.title()).lower()
        self.update(title)

    def hook_response_current_screen(self):
        if self.for_current_screen:
            self.hook_response()

    def finalize(self):
        self.remove_hooks()
        _TextBox.finalize(self)
