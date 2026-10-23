#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-22 17:39:25
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="dumbbell one arm pull"
reps=20
delay=3.2
half_count=$(( reps / 2 + 1 ))

SET_CTX[id]=`txkey`
SET_CTX[name]=$name
SET_CTX[rep_target]=$reps
SET_CTX[rep_delay]=$delay
SET_CTX[rep_count]=0

# override event
before_rep() {
    count=$1

    if ((count == half_count))
    then
        play_vocab "switch-to-left"
        sleep 1
    fi
}

show_setup "$name" $reps $delay

# TODO create a callback for this: before_set()
play_vocab "switch-to-right"

start_countdown

# loop up
for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
done

SET_CTX[end_tm]=`date +"%s"`

afplay /System/Library/Sounds/Ping.aiff &

say $name exercise complete

log_results "$name" $reps $delay
logx_set

