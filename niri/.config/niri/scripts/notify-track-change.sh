#!/bin/env bash

# Function to send a notification
notify_track_change() {
    # Introduce a small delay to ensure metadata is available
    sleep 0.2

    player_status=$(playerctl --player=playerctld status 2>/dev/null)
    if [ "$player_status" == "Playing" ] || [ "$player_status" == "Paused" ]; then
        title=$(playerctl --player=playerctld metadata title 2>/dev/null)
        artist=$(playerctl --player=playerctld metadata artist 2>/dev/null)
        album=$(playerctl --player=playerctld metadata album 2>/dev/null)
        art_url=$(playerctl --player=playerctld metadata mpris:artUrl 2>/dev/null)

        # Fallback for missing metadata
        title=${title:-"Unknown Title"}
        artist=${artist:-"Unknown Artist"}
        album=${album:-"Unknown Album"}

        # Notification with album art (if available)
        if [ -n "$art_url" ]; then
            notify-send -u low -i "$art_url" "$title" "Artist: $artist\nAlbum: $album"
        else
            notify-send -u low "$title" "Artist: $artist\nAlbum: $album"
        fi
    fi
}

# Monitor track changes
playerctl --player=playerctld metadata --format "{{title}}" --follow | while read -r line; do
    notify_track_change
done
