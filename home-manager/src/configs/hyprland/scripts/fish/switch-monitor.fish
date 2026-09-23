# select the monitor
set monitors (hyprctl monitors -j | jq '.[] | .name' | sed -e 's@"@@g')
set monitor (echo -e $monitors | string split ' ' | rofi -dmenu -p "Select Monitor")
if test -z "$monitor"
    return
end

# choose the resolution
set resolutions (hyprctl monitors -j | jq ".[] | select(.name == \"$monitor\") | .availableModes | join(\"\n\")" | sed -e 's@"@@g')
set resolution (echo -e $resolutions | rofi -dmenu -p "Select Resolution")
if test -z "$resolution"
    return
end

# choose position
set positions auto auto-left auto-right auto-up auto-down
set position (echo $positions | string split ' ' | rofi -dmenu -p "Select Position")
if test -z "$position"
    return
end


# set scale
set scales (seq 1 10)
set scale (echo $scales | string split ' ' | rofi -dmenu -p "Select Scale")
if test -z "$scale"
    return
end

# apply the config
set cmd (echo "hyprctl keyword monitor $monitor,$resolution,$position,$scale");
echo $cmd # for debugging purpose

eval $cmd # first try
sleep 0.1
eval $cmd # second try
