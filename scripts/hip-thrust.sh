#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 16:49:40
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="hip thrust"
reps="${20:-20}"
delay="${5:-4.5}"

show_setup "$name" $reps $delay

start_countdown

for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
    # TODO: when the set is 1/2 over, switch to other leg
done

play_ping

say $name exercise complete

log_results "$name" $reps $delay


exit $?

