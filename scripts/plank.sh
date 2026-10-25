#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-25 14:07:57
#

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/_common.sh"

SET_CTX[id]=`txkey`
SET_CTX[name]="plank"
SET_CTX[sets_target]=1
SET_CTX[sets_delay]=120
SET_CTX[sets_count]=0
SET_CTX[rep_target]=1
SET_CTX[rep_delay]=60
SET_CTX[rep_count]=0

say "hold plank until set is complete..."

run_set

