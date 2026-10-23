#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-22 17:39:25
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

SET_CTX[id]=`txkey`
SET_CTX[name]="dumbbell one arm pull"
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=0
SET_CTX[rep_target]=20
SET_CTX[rep_delay]=3.2
SET_CTX[rep_count]=0

# override event
before_rep() {
    count=$1

    half_count=$(( reps / 2 + 1 ))

    if ((count == half_count))
    then
        play_vocab "switch-to-left"
        sleep 1
    fi
}

play_vocab "switch-to-right"

run_set