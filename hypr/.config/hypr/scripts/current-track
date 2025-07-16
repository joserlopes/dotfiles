#!/bin/env bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null
then
    echo "Error: playerctl is not installed. Please install it to use this script."
    exit 1
fi

# Check if notify-send is installed
if ! command -v notify-send &> /dev/null
then
    echo "Error: notify-send is not installed. Please install it to use this script."
    exit 1
fi

# Get the current playback status
STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" != "Playing" ]; then
    notify-send "Playback Paused" "No active playback."
    exit 0
fi

# Get the current playing track, artist, album, album art URL, current position, and total length
TRACK=$(playerctl metadata title 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)
ALBUM=$(playerctl metadata album 2>/dev/null)
ALBUM_ART_URL=$(playerctl metadata mpris:artUrl 2>/dev/null)
CURRENT_POSITION=$(playerctl position 2>/dev/null | awk '{print int($1)}') # Convert to integer
TOTAL_LENGTH=$(playerctl metadata mpris:length 2>/dev/null | awk '{print int($1)}') # Convert to integer

# Convert current position and total length from microseconds (if necessary) to minutes:seconds
if [ "$TOTAL_LENGTH" -gt 0 ]; then
    TOTAL_LENGTH_MS=$((TOTAL_LENGTH / 1000000))
    TOTAL_MINUTES=$((TOTAL_LENGTH_MS / 60))
    TOTAL_SECONDS=$((TOTAL_LENGTH_MS % 60))
    FORMATTED_TOTAL_LENGTH=$(printf "%d:%02d" $TOTAL_MINUTES $TOTAL_SECONDS)
else
    FORMATTED_TOTAL_LENGTH="N/A"
fi

if [ "$CURRENT_POSITION" -ge 0 ]; then
    CURRENT_MINUTES=$((CURRENT_POSITION / 60))
    CURRENT_SECONDS=$((CURRENT_POSITION % 60))
    FORMATTED_CURRENT_POSITION=$(printf "%d:%02d" $CURRENT_MINUTES $CURRENT_SECONDS)
else
    FORMATTED_CURRENT_POSITION="N/A"
fi

# Check if a track is currently being played
if [ -z "$TRACK" ] || [ -z "$ARTIST" ]; then
    notify-send "No track is currently being played."
    exit 0
fi

# Download the album art if available
if [ -n "$ALBUM_ART_URL" ]; then
    TEMP_IMAGE=$(mktemp --suffix=.png)
    curl -s "$ALBUM_ART_URL" -o "$TEMP_IMAGE"
else
    TEMP_IMAGE=""
fi

# Display the track, album, artist, and time information using notify-send with album art
if [ -n "$TEMP_IMAGE" ]; then
    notify-send -i "$TEMP_IMAGE" "Currently Playing" "Track: $TRACK\nAlbum: $ALBUM\nArtist: $ARTIST\nTime: $FORMATTED_CURRENT_POSITION / $FORMATTED_TOTAL_LENGTH"
    rm "$TEMP_IMAGE" # Remove the temporary image after use
else
    notify-send "Currently Playing" "Track: $TRACK\nAlbum: $ALBUM\nArtist: $ARTIST\nTime: $FORMATTED_CURRENT_POSITION / $FORMATTED_TOTAL_LENGTH"
fi
