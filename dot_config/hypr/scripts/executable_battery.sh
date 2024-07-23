#!/usr/bin/env bash

notify() {
    notify-send -i battery-good-symbolic \
        -h string:x-canonical-private-synchronous:battery \
        "Battery" "$1" -t 4000
}

notify_critical() {
    notify-send -u critical -i battery-good-symbolic \
        -h string:x-canonical-private-synchronous:battery \
        "Battery very low. Please charge!" "$1" -t 4000
}

output=""
# Loop through all attached batteries and format the info
for battery in /sys/class/power_supply/BAT?*; do
    # If non-first battery, print a space separator.
    #[ -n "${capacity+x}" ] && printf " "
    [ -n "${capacity+x}" ] && output=" $output"

    capacity="$(cat "$battery/capacity" 2>&1)"
    if [ "$capacity" -gt 90 ]; then
        status=" "
    elif [ "$capacity" -gt 60 ]; then
        status=" "
    elif [ "$capacity" -gt 40 ]; then
        status=" "
    elif [ "$capacity" -gt 10 ]; then
        status=" "
    else
        status=" "
    fi

    # Sets up the status and capacity
    case "$(cat "$battery/status" 2>&1)" in
        Full) status=" " ;;
        Discharging)
            if [ "$capacity" -le 20 ]; then
                status=" $status"
                color=1
            fi
            if [ "$capacity" -eq 10 ]; then
                notify_critical "$(acpi -b | awk -F ': |, ' '{printf "%s\n%s\n", $2, $4}')"
            fi
            ;;
        Charging) status="󰚥 $status" ;;
        "Not charging") status=" " ;;
        Unknown) status="? $status" ;;
        *) exit 1 ;;
    esac
    output="$status $capacity%% $output"
done

# Prints the info
printf "$output" "$color"
