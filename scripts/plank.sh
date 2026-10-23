#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 11:52:40
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

SET_CTX[id]=`txkey`
SET_CTX[name]="90 second planks"
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=0
SET_CTX[rep_target]=${1:-1} # override the rep target with cmd arg[1]
SET_CTX[rep_delay]=90
SET_CTX[rep_count]=0

# if the set number is passed in, then set it

# re-implement run set to fix the iterator
run_plank_set() {
    reps=${SET_CTX[rep_target]}
    delay=${SET_CTX[rep_delay]}
    name=${SET_CTX[name]}

    show_message "Exercise : $name"
    say "$name"
    sleep 2

    start_countdown

    set_start_time

    # just a guess...
    sleep_time=9.6

    for ((i == 1; i <= 9; i++)) {
        sleep $sleep_time

        t=$((i * 10))

        say "$t seconds" &
        show_message "$t seconds"

        # TODO : use the real time to determine the next required sleep time
    }

    sleep 1.5

    set_complete
}

run_plank_set
