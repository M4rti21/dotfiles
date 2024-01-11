from datetime import datetime 
from libqtile.widget import base

class LookAway(base._TextBox):

    interval = 1

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults({
            "update_interval": 1,  # Update interval in seconds
        })
        self.text = ""
        self.start

    def timer_setup(self):
        now = datetime.now()
        if now.minute <= 14:
            self.text = "󰈈"
        else:
            self.text = ""
        self.bar.draw()

    def start(self):
        self.text = ""
        self.bar.draw()
        self.timeout_add(self.interval, self.timer_setup)

