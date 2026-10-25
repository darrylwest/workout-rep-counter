#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-25 14:05:09
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

SET_CTX[id]=`txkey`
SET_CTX[name]="down dog press"
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=0
SET_CTX[rep_target]=10
SET_CTX[rep_delay]=5.0
SET_CTX[rep_count]=0

# if the set number is passed in, then set it

run_set

