#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 01:43:19
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="curls"
reps=20
delay=3.8


# override event
start_rep() {
    count=$1

    if ((count == 1))
    then
        play_vocab "right"
    fi
    if ((count == 11))
    then
        play_vocab "left"
    fi

    if ((count == reps))
    then
        play_vocab "last-one"
    fi

}

show_setup "$name" $reps $delay

start_countdown

# loop up
for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
done

afplay /System/Library/Sounds/Ping.aiff &

say $name exercise complete

log_results "$name" $reps $delay

