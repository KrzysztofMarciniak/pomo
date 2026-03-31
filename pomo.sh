#!/usr/bin/env bash

WORK=90
BREAK=26
LONG_BREAK=60
WORK_SEGMENTS=4

notify() {
    printf "\n[%s] %s\n" "$(date +%H:%M:%S)" "$1"
    printf "\a"
}

run_timer() {
    local minutes=$1
    local label=$2
    local seconds=$((minutes * 60))

    notify "START: $label (${minutes}m)"
    sleep "$seconds"
    notify "END: $label"
}

main() {
    local count=0

    while true; do
        count=$((count + 1))
        run_timer "$WORK" "WORK #$count"

        if [ $((count % WORK_SEGMENTS)) -eq 0 ]; then
            run_timer "$LONG_BREAK" "LONG BREAK"
        else
            run_timer "$BREAK" "BREAK"
        fi
    done
}

main
