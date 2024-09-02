#!/usr/bin/sh

while [[ true ]]; do
    # This retarded shit checkes if steam fuckedup my xrandr settings (I USE FUCKING WAYLAND, WHY IS THAT EVEN A THING) and changes them back
    if  [[ $(xrandr -q | grep DP-1 | grep primary) == "" ]]; then
        $(xrandr --output DP-1 --pos 0x0 --primary --output HDMI-A-1 --pos 2560x0)
        echo "Primary display was unset at $(date +'%H:%M:%S')" # Also loggs back when this happen
    fi

    # This one checks if discord fuckedup my microphone volume (WHYYYYYYYYYYYYYY) and changes it back
    if [[ $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@) != "Volume: 1.00" ]]; then
        wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1
        echo "Volume was wrong at $(date +'%H:%M:%S')" # Also loggs back when this happen
    fi
    sleep 5 # Sleep and check back
done
