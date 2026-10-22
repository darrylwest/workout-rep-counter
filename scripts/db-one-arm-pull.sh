#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-22 17:39:25
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="dumbbell one arm pull"
reps=20
delay=3.2

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


