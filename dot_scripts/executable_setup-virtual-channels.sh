#!/bin/bash

# make sure module its not loaded so we don't get duplicate sinks
pactl unload-module module-null-sink

pactl load-module module-null-sink sink_name=MasterChannel sink_properties=device.description="Master-Channel"
pactl load-module module-null-sink sink_name=GameChannel sink_properties=device.description="Game-Channel"
pactl load-module module-null-sink sink_name=ChatChannel sink_properties=device.description="Chat-Channel"

# set default sink
pactl set-default-sink MasterChannel

sleep 2

# Route virtual sinks to master sink
pw-link GameChannel:monitor_FL MasterChannel:playback_FL 2>/dev/null
pw-link GameChannel:monitor_FR MasterChannel:playback_FR 2>/dev/null

pw-link ChatChannel:monitor_FL MasterChannel:playback_FL 2>/dev/null
pw-link ChatChannel:monitor_FR MasterChannel:playback_FR 2>/dev/null

# Link all output devices to the master sink
for node in $(pw-link -i | grep "playback" | grep "alsa_output" | grep "FL" | cut -d " " -f1); do
  pw-link MasterChannel:monitor_FL "$node" 2>/dev/null
done
for node in $(pw-link -i | grep "playback" | grep "alsa_output" | grep "FR" | cut -d " " -f1); do
  pw-link MasterChannel:monitor_FR "$node" 2>/dev/null
done

