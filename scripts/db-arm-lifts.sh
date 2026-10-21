#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 18:21:25
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="dumb bell arm lifts"
reps="${20:-20}"
delay="${5:-3.6}"

show_setup "20 pound $name" $reps $delay

start_countdown

for ((i = 1; i <= reps; i++))
do
    do_rep $i $delay
done

play_ping

say $name exercise complete

log_results "$name" $reps $delay

