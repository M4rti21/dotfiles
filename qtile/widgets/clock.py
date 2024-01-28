from libqtile import widget


class ToggleClock(widget.Clock):
    defaults = [
        (
            "short_format",
            " %H:%M",
        ),
        (
            "long_format",
            "󰃭 %d/%m/%Y",
        ),
    ]

    def __init__(self, **config):
        widget.Clock.__init__(self, **config)
        self.add_defaults(ToggleClock.defaults)
        self.format = self.short_format

    def mouse_enter(self, *args, **kwargs):
        self.format = self.long_format
        self.bar.draw()

    def mouse_leave(self, *args, **kwargs):
        self.format = self.short_format
        self.bar.draw()
