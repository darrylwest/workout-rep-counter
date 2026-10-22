#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 00:00:39
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="right left balance"
reps="${20:-60}"
delay="${5:-10.0}"

printf "n - $n ; delay - $delay\n"

sleep 3

say $name

sleep 1

start_countdown

$ROOT/scripts/left-right-timer.sh -t 600 -l 60 -s R

say "$name" exercise complete

