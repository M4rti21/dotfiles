from libqtile import widget


def format_date():
    return "󰃭 %d/%m/%Y"


def format_time():
    return " %H:%M"


class ToggleClock(widget.Clock):
    state = True

    def __init__(self, **config):
        widget.Clock.__init__(self, **config)
        self.mouse_callbacks = {'Button1': self.toggle}
        self.format = format_time()

    def toggle(self):
        self.state = not self.state
        if self.state:
            self.format = format_time()
        else:
            self.format = format_date()
        self.bar.draw()
