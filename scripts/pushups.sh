#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-20 21:15:34
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="push ups"
reps="${20:-15}"
delay="${5:-3.5}"

SET_CTX[id]=`txkey`
SET_CTX[name]=$name
SET_CTX[rep_target]=$reps
SET_CTX[rep_delay]=$delay
SET_CTX[rep_count]=0

show_setup "$name" $reps $delay

start_countdown

# loop up
for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
done

play_ping

say $name exercise complete

log_results "$name" $reps $delay
logx_set
