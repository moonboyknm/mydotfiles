# Bash script to toggle between refresh rates on my ideapad gaming 3 laptop 
# if I type rr then it will switch between refresh rates.

#!/bin/bash

# Path to hyprland config file
CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

# Check if file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file not found at $CONFIG_FILE"
    exit 1
fi

# Read the current state of the file
line19=$(sed -n '19p' "$CONFIG_FILE")
line21=$(sed -n '21p' "$CONFIG_FILE")

# Determine which line is commented and which is active
if [[ "$line19" == "#"* ]]; then
    # 19 is commented, so we want to activate 120Hz
    # Remove comment from line 19
    sed -i '19s/^#//' "$CONFIG_FILE"
    # Add comment to line 21
    sed -i '21s/^/#/' "$CONFIG_FILE"
    echo "120Hz Activated :)"
else
    # 19 is active, so we want to activate 60Hz
    # Add comment to line 19
    sed -i '19s/^/#/' "$CONFIG_FILE"
    # Remove comment from line 21
    sed -i '21s/^#//' "$CONFIG_FILE"
    echo "60Hz Activated :)"
fi

# Restart Hyprland to apply changes
hyprctl reload
