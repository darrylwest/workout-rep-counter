#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-22 15:27:54
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="bird dogs"
reps="${20:-30}"
delay="${5:-3.0}"

SET_CTX[id]=`txkey`
SET_CTX[name]=$name
SET_CTX[rep_target]=$reps
SET_CTX[rep_delay]=$delay
SET_CTX[rep_count]=0

show_setup "$name" $reps $delay

start_countdown

before_set

for ((i = 1; i <= reps; i++))
do
    do_vocab_rep $i $delay
    # TODO: when the set is 1/2 over, switch to other leg
done

set_complete