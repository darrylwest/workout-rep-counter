#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 16:55:08
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="dumb bell squats"
reps="${20:-20}"
delay="${5:-3.6}"

show_setup "20 pound $name" $reps $delay

start_countdown

for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
done

play_ping

say $name exercise complete

log_results "$name" $reps $delay

