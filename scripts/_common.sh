#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 12:54:48
#


# Shared helpers for the startup/stop/clobber scripts. Not meant to be run
# directly - source it.

set -euo pipefail

VERSION="26.10.23"

# context for this set of reps
declare -A SET_CTX
SET_CTX[id]=0
SET_CTX[name]=""
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=1
SET_CTX[rep_target]=2
SET_CTX[rep_delay]=2.0
SET_CTX[rep_count]=0
SET_CTX[start_tm]=0
SET_CTX[end_tm]=0

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FONT="chunky"
# FONT="thin"

# DB_PATH="${COMPANION_DB:-$ROOT/data/repcount.db}"
#

# WARN: time zone issues with this
now() {
    date +"%s"
}

before_set() {
    SET_CTX[start_tm]=$(now)
}

before_rep() {
    # do nothing...
    count=$1
}

after_rep() {
    # do nothing...
    count=$1
}

show_count() {
    i=$1

    afplay /System/Library/Sounds/Tink.aiff &

    figlet -f "$FONT" $i
}

show_message() {
    msg=$1
    figlet -f "$FONT" -w 280 $msg
}

# replace this with when vocab is complete
play() {
    say $count &
}

play_vocab() {
    file="$ROOT/vocabulary/$1.wav"

    afplay $file
}

do_rep() {
    count=$1
    delay=$2

    # fire a start_rep(count) event

    show_count $count
    play $count

    sleep $delay
    
    # fire a end_rep(count) event
}

do_vocab_rep() {
    count=$1
    delay=$2

    SET_CTX[rep_count]=$count

    # fire a before_rep(count) event
    before_rep $count
    
    show_count $count
    play_vocab $count

    sleep $delay

    # fire a end_rep(count) event
    after_rep $count
}

show_setup() {
    name=${SET_CTX[name]}
    reps=${SET_CTX[rep_target]}
    delay=${SET_CTX[rep_delay]}

    show_message "Exercise  : $name"
    show_message "Rep count : $reps"
    show_message "Delay     : $delay"

    say "$name set, with $reps reps"

    sleep 3
}

start_countdown() {
    for ((i = 5; i > 1; i--))
    do
        show_count $i
        play_vocab $i &

        sleep 1
    done

    figlet -f "$FONT" "begin..."
    play_vocab "begin" &

    sleep 1
}

play_ping() {
    afplay /System/Library/Sounds/Ping.aiff &
}

show_complete() {
    name=$1

    play_ping
    say $name set complete
}

log_set_results() {
    for f in id name rep_target rep_delay rep_count start_tm end_tm
    do
        printf "$f=${SET_CTX[$f]}, "
    done

    st=${SET_CTX[start_tm]}
    et=${SET_CTX[end_tm]}

    elapsed=$((et - st))

    printf "seconds=$elapsed\n"
}

set_complete() {
    SET_CTX[end_tm]=$(now)

    play_ping

    name=${SET_CTX[name]}

    say "$name exercise set is complete."

    log_set_results
}

run_set() {
    show_setup
    start_countdown

    before_set
    # loop up
    for ((i = 1; i <= reps; i++))
    do
        do_vocab_rep $i $delay
    done

    set_complete

}