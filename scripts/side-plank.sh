#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-25 13:50:40
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

SET_CTX[id]=`txkey`
SET_CTX[name]="side plank"
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=0
SET_CTX[rep_target]=1
SET_CTX[rep_delay]=40
SET_CTX[rep_count]=0

# if the set number is passed in, then set it

SIDE="right"

# re-implement run set to fix the iterator
run_plank_set() {
    reps=${SET_CTX[rep_target]}
    delay=${SET_CTX[rep_delay]}
    name=${SET_CTX[name]}

    show_message "Exercise : $name" # say which side...
    say "$name, $SIDE side"
    sleep 2

    start_countdown

    set_start_time

    # just a guess...
    sleep_time=9.6

    for ((i == 1; i <= 4; i++)) {
        sleep $sleep_time

        t=$((i * 10))

        say "$t seconds" &
        show_message "$t seconds"

        # TODO : use the real time to determine the next required sleep time
    }

    sleep 1.5

    set_complete
}

# start on left side
run_plank_set
# switch to right
SIDE="left"
say "switch to the $SIDE side."
sleep 10

run_plank_set

