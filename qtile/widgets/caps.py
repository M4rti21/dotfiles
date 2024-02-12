import re
import subprocess

from libqtile.widget import base

class Caps(base.ThreadPoolText):
    """Really simple widget to show the current Caps/Num Lock state."""

    defaults = [("update_interval", 0.5, "Update Time in seconds.")]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(self.defaults)

    def get_indicators(self):
        """Return a list with the current state of the keys."""
        try:
            output = self.call_process(["xset", "q"])
        except subprocess.CalledProcessError as err:
            output = err.output
            return []
        if output.startswith("Keyboard"):
            indicators = re.findall(r"(Caps|Num)\s+Lock:\s*(\w*)", output)
            caps = indicators[0][1] == "on"
            nlck = indicators[1][1] == "on"
            return [caps, nlck] 

    def poll(self):
        """Poll content for the text box."""
        indicators = self.get_indicators()
        status = ""
        if not indicators:
            return status
        if indicators[0] == True:
            status+="A"
        if indicators[1] == True:
            status+="L"
        return status

