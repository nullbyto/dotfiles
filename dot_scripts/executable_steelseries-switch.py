#!/usr/bin/env python3

import subprocess
import time
import re
import sys

HEADSET_SOURCE = "alsa_input.usb-SteelSeries_Arctis_Nova_7-00.mono-fallback"
FALLBACK_SOURCE = "alsa_input.usb-3142_fifine_Microphone-00.analog-stereo"

current_state = None

def is_headset_connected():
    try:
        result = subprocess.run(
            ["headsetcontrol", "--connected"],
            capture_output=True, text=True
        )
        return result.stdout.strip() == "true"
    except subprocess.CalledProcessError as e:
        print("Failed to run headsetcontrol:", e)
        return False

def get_input_node_id(target_name):
    try:
        result = subprocess.run(["pw-cli", "ls", "Node"],
                                capture_output=True, text=True, check=True)

        entries = result.stdout.splitlines()
        current_id = None
        for line in entries:
            # Match lines like: id 52, type PipeWire:Interface:Node/3
            match = re.match(r"^\s*id\s+(\d+),", line)
            if match:
                current_id = match.group(1)
            # Match lines like: node.name = "alsa_input.usb-Something"
            if target_name in line:
                return current_id
    except Exception as e:
        print("Error reading PipeWire nodes:", e)
    return None

def set_default_input(source_name):
    node_id = get_input_node_id(source_name)
    if node_id:
        subprocess.run(["wpctl", "set-default", node_id])
        print(f"Switched to input: {source_name} (ID: {node_id})")
    else:
        print(f"Could not find node for: {source_name}")

def handle_state():
    global current_state
    if is_headset_connected() and current_state != "headset":
        set_default_input(HEADSET_SOURCE)
        current_state = "headset"
    elif not is_headset_connected() and current_state != "fallback":
        set_default_input(FALLBACK_SOURCE)
        current_state = "fallback"

def main():
    if len(sys.argv) != 2:
        print("Error: must provide an option: watch|switch")
        exit(1)
    if sys.argv[1] == "switch":
        handle_state()
    elif sys.argv[1] == "watch":
        while True:
            handle_state()
            time.sleep(5)
    else:
        print("Error: must provide an option: watch|switch")

if __name__ == "__main__":
    main()

