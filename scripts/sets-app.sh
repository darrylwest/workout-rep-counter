#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-22 15:45:46
#

set -euo pipefail

# pass in the script to run 
#
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

file=$1
set_count=3
sleep_time=120

set_started=`date +"%s"

printf "file: $file"

for ((i = 1; i <= $set_count; i++))
do
    say "start set number ${i}.."

    $file >> my.log

    say "set number ${i} completed.."
    sleep 120
done

set_ended=`date +"%s"
elapsed=$((set_ended - set_started))

printf "Sets complete..."
say "${set_count} sets completed in ${elapsed} second."


