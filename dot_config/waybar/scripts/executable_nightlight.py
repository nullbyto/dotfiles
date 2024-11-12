#!/usr/bin/env python3

import subprocess
import sys
import json
import os
import time

temp_file_path = "/tmp/gammastep"
DEFAULT_TEMP = 3400
DIM_FACTOR = "0.5"

class Gamma():
    def __init__(self) -> None:
        self.temp: int = DEFAULT_TEMP
        self.dim: bool = False
        self.enabled: bool = False

def write_temp_file(new_temp):
    with open(temp_file_path, "w") as temp_file:
        temp_file.write(str(new_temp))

def write_gamma_file(gamma: Gamma):
    with open(temp_file_path, "w") as temp_file:
        json.dump(vars(gamma), temp_file)

def read_temp_file():
    with open(temp_file_path, "r") as temp_file:
        return temp_file.readline()

def read_gamma_file() -> Gamma:
    gamma = Gamma()
    with open(temp_file_path, "r") as temp_file:
        data = json.load(temp_file)
        gamma.temp = data["temp"]
        gamma.dim = data["dim"]
        gamma.enabled = data["enabled"]

        return gamma

def process_status(process_name):
    try:
        subprocess.check_output(["pgrep", process_name])
        return True
    except subprocess.CalledProcessError:
        return False

def toggle_gamma():
    if process_status("gammastep"):
        disable_gamma()
    else:
        enable_gamma()
    # try:
    #     subprocess.run(["pkill", "gammastep"], check=True)
    #     print("Nightlight OFF")
    # except:
    #     adjust_gamma(0)
    #     gamma = read_gamma_file()
    #     new_temp = gamma.temp
    #
    #     cmd = ["gammastep", "-O", str(new_temp)]
    #     if gamma.dim:
    #         cmd.extend(["-b", DIM_FACTOR])
    #
    #     subprocess.Popen(cmd)
    #     print("Nightlight ON")

def enable_gamma():
        adjust_gamma(0)
        gamma = read_gamma_file()
        new_temp = gamma.temp

        cmd = ["gammastep", "-O", str(new_temp)]
        if gamma.dim:
            cmd.extend(["-b", DIM_FACTOR])

        subprocess.Popen(cmd)
        print("Nightlight ON")

def disable_gamma():
        subprocess.run(["pkill", "gammastep"], check=True)
        print("Nightlight OFF")

def toggle_dim():
    try:
        gamma = read_gamma_file()
    except:
        gamma = Gamma()
        gamma.dim = False
        gamma.temp = DEFAULT_TEMP

    if gamma.dim:
        gamma.dim = False
    else:
        gamma.dim = True

    write_gamma_file(gamma)

def adjust_gamma(delta):
    try:
        gamma = read_gamma_file()
    except:
        gamma = Gamma()
        gamma.dim = False
        gamma.temp = DEFAULT_TEMP

    current_temp = gamma.temp

    new_temp = int(current_temp) + delta
    if new_temp < 1000:
        print("Temp can't be below 1000K.")
    elif new_temp > 5000:
        print("Temp can't exceed 5000K.")
    else:
        gamma.temp = new_temp
        gamma.enabled = True
        write_gamma_file(gamma)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python3 {sys.argv[0]} [toggle|up|down|info|dim]")
        sys.exit(1)

    if not os.path.exists(temp_file_path):
        write_gamma_file(Gamma())

    action = sys.argv[1]
    if action == "toggle":
        toggle_gamma()
    elif action == "up":
        adjust_gamma(200)
    elif action == "down":
        adjust_gamma(-200)
    elif action == "info":
        time.sleep(0.1)
        icon = ""
        text = ""
        dim = ""
        if process_status("gammastep"):
            gamma = read_gamma_file()
            curr_temp = gamma.temp
            if gamma.dim:
                dim = "(d)"

            text += str(curr_temp)
        else:
            text += "Off"

        output = {"text": f"{icon} {text}{dim}",
                  "tooltip": f"{text}{dim}",
                  "class": "custom-nightlight"}

        sys.stdout.write(json.dumps(output) + "\n")
        sys.stdout.flush()
    elif action == "dim":
        toggle_dim()
    else:
        print("Invalid action. Use 'toggle', 'up', 'down', 'info' or 'dim'.")
