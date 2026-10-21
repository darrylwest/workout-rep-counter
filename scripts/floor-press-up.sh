#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 17:00:28
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="dumbbell floor pressup"
reps="${20:-30}"
delay="${5:-3.8}"

show_setup "$name" $reps $delay

start_countdown

for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
done

play_ping

say $name exercise complete

log_results "$name" $reps $delay

