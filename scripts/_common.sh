#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 12:54:48
#


# Shared helpers for the startup/stop/clobber scripts. Not meant to be run
# directly - source it.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# DB_PATH="${COMPANION_DB:-$ROOT/data/repcount.db}"
#

show_count() {
    i=$1

    printf "\a"
    figlet -f chunky $i
}

show_message() {
    msg=$1
    figlet -f chunky -w 160 $msg
}

do_rep() {
    count=$1
    delay=$2

    show_count $count
    say $count &

    sleep $delay
}

show_setup() {
    show_message "Exercise : $1"
    show_message "Rep count: $2"
    show_message "Delay....: $3"

    say "$1, $2 reps"

    sleep 3
}

start_countdown() {
    for ((i = 5; i > 1; i--))
    do
        show_count $i

        sleep 1
    done

    figlet -f chunky begin... 

    sleep 1
}

play_ping() {
    afplay /System/Library/Sounds/Ping.aiff &
}

show_complete() {
    name=$1

    afplay /System/Library/Sounds/Ping.aiff &
    say $name exercise complete
}


log_results() {
    name=$1
    reps=$2
    delay=$3

    now=`date +"%Y-%m-%d %H:%M"`
    
    printf "$now | $reps $name, $delay delay\n"
}
