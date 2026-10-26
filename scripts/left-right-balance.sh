#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 00:00:39
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="right left balance"
reps="${1:-60}"
delay="${2:-10.0}"

printf "n - $reps ; delay - $delay\n"

sleep 1

say "prepare for $name exercise"

sleep 2

start_countdown

# enable an iteration callback fired each 1 second

$ROOT/scripts/left-right-timer.sh -t 600 -l 60 -s R

# log the results?

say "$name" exercise complete


