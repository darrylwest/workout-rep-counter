#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-22 15:27:54
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

SET_CTX[id]=`txkey`
SET_CTX[name]="bird dogs"
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=0
SET_CTX[rep_target]=20
SET_CTX[rep_delay]=4.2
SET_CTX[rep_count]=0

# if the set number is passed in, then set it

run_set
