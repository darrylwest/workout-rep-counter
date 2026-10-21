#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 17:04:32
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="dumbbell overhead"
reps="${20:-20}"
delay="${5:-3.2}"

show_setup "$name" $reps $delay

start_countdown

for ((i = 1; i <= reps; i++))
do
    do_rep $i $delay
done

play_ping

say $name exercise complete

log_results "$name" $reps $delay

