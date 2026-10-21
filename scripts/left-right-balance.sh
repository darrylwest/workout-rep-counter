#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-21 00:00:39
#

set -eu

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

name="right left balance"
n="${20:-60}"
delay="${5:-10.0}"

printf "n - $n ; delay - $delay\n"

sleep 3

say $name

sleep 1

start_countdown

for ((i = 1; i <= n; i++))
do
    echo "$i"
    say $i &
    printf "\a"
    sleep "$delay"
done

say exercise set complete

