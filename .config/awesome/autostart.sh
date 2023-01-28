#!/bin/sh

run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run "picom" -b
run nitrogen --restore

# run "" &
