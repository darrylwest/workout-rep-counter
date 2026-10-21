#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-20 23:04:33
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="leg lifts"
reps="${20:-30}"
delay="${5:-3.5}"

show_setup "$name" $reps $delay

start_countdown

for ((i = 1; i <= reps; i++))
do
    do_rep $i $delay
done

play_ping

show_complete "$name"

log_results "$name" $reps $delay
