import sys
import subprocess
import time

def print_message():
    print('the key I was pressed')

# Method 1: Using keyboard module
try:
    import keyboard
except ImportError:
    # If keyboard module is not installed, use Method 2
    pass
else:
    def on_key(event):
        if event.name == 'i' or event.name == 'I':
            print_message()

    keyboard.on_press(on_key)
    keyboard.start()

# Method 2: Using subprocess and xdotool (if keyboard module is not installed)
while True:
    try:
        # Get the state of the I key using xdotool
        result = subprocess.run(['xdotool', 'get_key_state', 'I'], capture_output=True, text=True)
        if 'Down' in result.stdout or 'down' in result.stdout:
            print_message()
    except FileNotFoundError:
        # If xdotool is not installed, skip this method
        pass
    time.sleep(0.1)

# Keep the script running
while True:
    time.sleep(1)
