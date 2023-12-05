import subprocess

options = ["Reboot", "Shutdown", "Logout"]

selected_option = subprocess.run(
    ['dmenu', '-p', 'Select an option:'],
    input='\n'.join(options),
    stdout=subprocess.PIPE,
    encoding='utf-8'
).stdout.strip()

if selected_option == "Reboot":
    subprocess.run(['sudo', 'reboot'])
elif selected_option == "Shutdown":
    subprocess.run(['sudo', 'shutdown', 'now'])
elif selected_option == "Logout":
    subprocess.run(['qtile-cmd', '-o', 'cmd', '-f', 'shutdown'])
