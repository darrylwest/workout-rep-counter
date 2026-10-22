#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 01:43:19
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="curls"
reps=20
delay=3.8

SET_CTX[id]="100"
SET_CTX[name]=$name
SET_CTX[rep_target]=$reps
SET_CTX[rep_delay]=$delay
SET_CTX[rep_count]=0

# logx_set

# override event
start_rep() {
    count=$1

    if ((count == reps))
    then
        play_vocab "last-one"
    fi
}

show_setup "$name" $reps $delay

start_countdown

# loop up
SET_CTX[start_tm]=`date +"%s"`

for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
done

SET_CTX[end_tm]=`date +"%s"`

afplay /System/Library/Sounds/Ping.aiff &

say $name exercise complete

log_results "$name" $reps $delay
logx_set

