#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 11:52:40
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="planks"
reps="${20:-9}"
delay="${5:-10}"

seconds=$((reps * delay))

# show_setup "$name" $reps $delay
show_message "$seconds second $name"
say "$seconds second $name"

# time to prepare...
# sleep 3

start_countdown

started=`date +"%s"`
elapsed=0

# loop down
for ((t = $seconds; t > 0; t -= 10))
do
    do_rep $t $delay

    now=`date +"%s"`
    elapsed=$((now - started))
    printf "$elapsed seconds\n"
done

play_ping

say $seconds second $name exercise complete

log_results "$name" $reps $delay
