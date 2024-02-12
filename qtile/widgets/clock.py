from libqtile import widget


class ToggleClock(widget.Clock):
    defaults = [
        (
            "short_format",
            "%H:%M",
        ),
        (
            "long_format",
            "%d/%m/%Y",
        ),
    ]
    short = True

    def __init__(self, **config):
        widget.Clock.__init__(self, **config)
        self.add_defaults(ToggleClock.defaults)
        self.format = self.short_format
        self.mouse_callbacks = {"Button1": self.toggle}

    def toggle(self):
        self.short = not self.short
        if self.short:
            self.set_short()
        else:
            self.set_long()

    def set_long(self):
        self.format = self.long_format
        self.bar.draw()

    def set_short(self):
        self.format = self.short_format
        self.bar.draw()
