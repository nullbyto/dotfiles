#!/usr/bin/env python3

import subprocess
import sys
import json
import time
import pathlib
import os

home = pathlib.Path().home()
shade_file_path = home / ".config/hyprshade/shaders/blue-light-filter.glsl"
night_light_shader = "blue-light-filter"
DEFAULT_TEMP = 3400.0


def save_state(state: bool):
    state_dir = os.path.join(os.path.expanduser("~"), ".local", "state")
    file_path = os.path.join(state_dir, "hyprshade_state")

    with open(file_path, "w") as f:
        f.write("1" if state else "0")

    print(f"State saved to {file_path}: {state}")

def load_state(default=False) -> bool:
    state_dir = os.path.join(os.path.expanduser("~"), ".local", "state")
    file_path = os.path.join(state_dir, "hyprshade_state")

    try:
        with open(file_path, "r") as f:
            content = f.read().strip().lower()
            if content == "1":
                return True
            elif content == "0":
                return False
            else:
                print(f"Warning: Invalid state value in {file_path!r}, defaulting to {default}")
    except Exception as e:
        print(f"Error reading state file: {e}, defaulting to {default}")

    return default

def read_temp() -> float:
    temp = 0.0
    with open(shade_file_path, "r") as shade_file:
        lines = shade_file.readlines()
        for line in lines:
            if "temperature =" in line:
                # get temp int from line
                temp = float(line.split(" ")[-1].strip()[:-1])
                break

    return temp

def write_temp(temp: float):
    with open(shade_file_path, "r") as shade_file:
        lines = shade_file.readlines()
    with open(shade_file_path, "w") as shade_file:
        for idx, line in enumerate(lines):
            if "temperature =" in line:
                line_ls = line.split(" ")
                line_ls[-1] = f"{temp};\n"
                line = " ".join(line_ls)
                lines[idx] = line
                break
        shade_file.writelines(lines)

def hyprshade_enabled():
    current = subprocess.check_output(["hyprshade", "current"]).decode().strip()
    if current == night_light_shader:
        return True
    else:
        return False

def toggle_nightlight():
    if hyprshade_enabled():
        disable_nightlight()
    else:
        enable_nightlight()

def enable_nightlight():
    cmd = ["hyprshade", "on", night_light_shader]
    subprocess.run(cmd)
    print("Nightlight ON")
    save_state(True)

def disable_nightlight():
    cmd = ["hyprshade", "off"]
    subprocess.run(cmd)
    print("Nightlight OFF")
    save_state(False)

def adjust_temp(delta):
    temp = read_temp()

    current_temp = temp

    new_temp = int(current_temp) + delta
    if new_temp < 1000.0:
        print("Temp can't be below 1000K.")
    elif new_temp > 5000.0:
        print("Temp can't exceed 5000K.")
    else:
        write_temp(new_temp)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} [toggle|up|down|reset|check|info]")
        sys.exit(1)

    action = sys.argv[1]
    if action == "toggle":
        toggle_nightlight()
    elif action == "up":
        adjust_temp(200.0)
        enable_nightlight()
    elif action == "down":
        adjust_temp(-200.0)
        enable_nightlight()
    elif action == "reset":
        write_temp(DEFAULT_TEMP)
        enable_nightlight()
    elif action == "info":
        time.sleep(0.1)
        icon = ""
        text = ""
        if hyprshade_enabled():
            curr_temp = int(read_temp())

            text += str(curr_temp)
        else:
            text += "Off"

        output = {"text": f"{icon} {text}",
                  "tooltip": f"{text}",
                  "class": "custom-nightlight"}

        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()
    elif action == "check":
        if load_state():
            enable_nightlight()
        else:
            disable_nightlight()
    else:
        print("Invalid action. Use 'toggle', 'up', 'down', 'check' or 'info'.")
