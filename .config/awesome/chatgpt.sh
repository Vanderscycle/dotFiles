#!/bin/bash
# https://old.reddit.com/r/unixporn/comments/10w7p5z/rofi_chatgpt_rofi/
INPUT=$(rofi -dmenu -p "") if [[ -z $INPUT ]]; then exit 1 fi

zenity --progress --text="Waiting for an answer" --pulsate &

if [[ $? -eq 1 ]]; then exit 1 fi

PID=$!

ANSWER=$(~/.local/bin/sgpt "$INPUT" --no-animation --no-spinner) kill $PID zenity --info --text="$ANSWER" ```
