#!/usr/bin/env bash
# dpw@larkspur.local
# 2026-10-22 13:20:00
#

#!/usr/bin/env bash
#
# exercise-timer.sh - timed exercise helper with alternating left/right laps
#
# Usage: ./exercise-timer.sh [-t TARGET] [-l LAP_SECONDS] [-s L|R]
#   -t TARGET       target total time: seconds (300) or mm:ss (5:00). Default 5:00
#   -l LAP_SECONDS  optional auto-lap every N seconds (otherwise lap manually)
#   -s L|R          side to start on. Default L
#
# Keys:  SPACE / ENTER = lap (switch side)   p = pause/resume   q = quit
#        The timer pauses automatically when the target time is reached;
#        press p to keep going past it, or q to finish.
#
# Requires bash 4+ for sub-second key polling (falls back to 1s on older bash).

# A timed read that expires returns non-zero by design, so make sure errexit
# (set -e) is off even if the calling environment turned it on.
set +e +u

TARGET=300
AUTO_LAP=60
SIDE="RIGHT"

parse_time() {
  local t="$1"
  if [[ "$t" =~ ^([0-9]+):([0-9]{1,2})$ ]]; then
    echo $(( 10#${BASH_REMATCH[1]} * 60 + 10#${BASH_REMATCH[2]} ))
  elif [[ "$t" =~ ^[0-9]+$ ]]; then
    echo $(( 10#$t ))
  else
    echo "Invalid time: $t" >&2; exit 1
  fi
}

while getopts "t:l:s:h" opt; do
  case $opt in
    t) TARGET=$(parse_time "$OPTARG") ;;
    l) AUTO_LAP=$(parse_time "$OPTARG") ;;
    s) up=$(printf '%s' "$OPTARG" | tr '[:lower:]' '[:upper:]')
       case "$up" in L|LEFT) SIDE="LEFT" ;; R|RIGHT) SIDE="RIGHT" ;;
         *) echo "-s must be L or R" >&2; exit 1 ;; esac ;;
    h|*) sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
  esac
done

if [[ ! -t 0 || ! -t 1 ]]; then
  echo "exercise-timer.sh must be run in an interactive terminal." >&2
  exit 1
fi

# Key-poll interval: fractional timeouts need bash 4+
POLL=0.2
read -t 0.01 -n 0 <<< "" 2>/dev/null || POLL=1

fmt() { printf "%02d:%02d" $(( $1 / 60 )) $(( $1 % 60 )); }

# ANSI helpers
BOLD=$'\e[1m'; DIM=$'\e[2m'; RESET=$'\e[0m'
GREEN=$'\e[32m'; CYAN=$'\e[36m'; YELLOW=$'\e[33m'; RED=$'\e[31m'

cleanup() {
  tput cnorm 2>/dev/null
  stty echo 2>/dev/null
  echo
}
trap cleanup EXIT
trap 'exit 130' INT TERM

now() { date +%s; }

START=$(now)
LAP_START=$START
PAUSED=0
PAUSE_BEGIN=0
PAUSED_TOTAL=0
LAP_PAUSED=0
LAP_NUM=1
LAPS=()          # "N|SIDE|seconds"
BELLED=0
TARGET_PAUSE=0   # 1 while paused automatically because the target was reached

other_side() { [[ "$1" == "LEFT" ]] && echo "RIGHT" || echo "LEFT"; }

end_lap() {
  local lap_secs=$1
  LAPS+=("$LAP_NUM|$SIDE|$lap_secs")
  SIDE=$(other_side "$SIDE")
  LAP_NUM=$(( LAP_NUM + 1 ))
  LAP_START=$(now)
  LAP_PAUSED=0
  printf '\a'
}

draw() {
  local elapsed=$1 lap=$2 status=$3
  local remaining=$(( TARGET - elapsed ))
  local ecolor=$GREEN
  (( elapsed >= TARGET )) && ecolor=$RED

  local side_color=$CYAN
  [[ "$SIDE" == "RIGHT" ]] && side_color=$YELLOW

  printf '\e[H\e[J'   # home + clear screen
  printf '%s  EXERCISE TIMER%s\n' "$BOLD" "$RESET"
  printf '  ─────────────────────────────\n'
  printf '  Target:    %s%s%s  (%ss)\n' "$BOLD" "$(fmt "$TARGET")" "$RESET" "$TARGET"
  printf '  Elapsed:   %s%s%s  %s%6ss%s\n' "$ecolor" "$(fmt "$elapsed")" "$RESET" "$BOLD" "$elapsed" "$RESET"
  if (( remaining >= 0 )); then
    printf '  Remaining: %s  (%ss)\n' "$(fmt "$remaining")" "$remaining"
  else
    printf '  Remaining: %sOVER by %ss%s\n' "$RED" "$(( -remaining ))" "$RESET"
  fi
  printf '  ─────────────────────────────\n'
  printf '  Lap %s%d%s   Side: %s%s%s%s%s\n' "$BOLD" "$LAP_NUM" "$RESET" \
    "$BOLD" "$side_color" "$SIDE" "$RESET" "$RESET"
  printf '  Lap time:  %s%s%6ss%s\n' "$BOLD" "" "$lap" "$RESET"
  (( AUTO_LAP > 0 )) && printf '  %sAuto-lap every %ss%s\n' "$DIM" "$AUTO_LAP" "$RESET"
  printf '\n'
  if (( ${#LAPS[@]} > 0 )); then
    printf '  %sPrevious laps:%s\n' "$DIM" "$RESET"
    local start=$(( ${#LAPS[@]} > 5 ? ${#LAPS[@]} - 5 : 0 ))
    local i n s t
    for (( i = start; i < ${#LAPS[@]}; i++ )); do
      IFS='|' read -r n s t <<< "${LAPS[$i]}"
      printf '    #%-3d %-5s %5ss\n' "$n" "$s" "$t"
    done
    printf '\n'
  fi
  if [[ -n "$status" ]]; then printf '  %s%s%s\n' "$YELLOW" "$status" "$RESET"; fi
  printf '  %s[SPACE] lap   [p] pause   [q] quit%s\n' "$DIM" "$RESET"
}

summary() {
  local elapsed=$1
  printf '\e[H\e[J'
  printf '%s  SESSION SUMMARY%s\n' "$BOLD" "$RESET"
  printf '  ─────────────────────────────\n'
  printf '  Target: %s   Total: %s (%ss)\n\n' "$(fmt "$TARGET")" "$(fmt "$elapsed")" "$elapsed"
  local i n s t left=0 right=0
  for (( i = 0; i < ${#LAPS[@]}; i++ )); do
    IFS='|' read -r n s t <<< "${LAPS[$i]}"
    printf '    #%-3d %-5s %5ss\n' "$n" "$s" "$t"
    [[ "$s" == "LEFT" ]] && left=$(( left + t )) || right=$(( right + t ))
  done
  printf '\n  Left total:  %ss\n  Right total: %ss\n' "$left" "$right"
}

tput civis 2>/dev/null   # hide cursor
stty -echo 2>/dev/null

while true; do
  T=$(now)
  if (( PAUSED )); then
    elapsed=$(( PAUSE_BEGIN - START - PAUSED_TOTAL ))
    lap=$(( PAUSE_BEGIN - LAP_START - LAP_PAUSED ))
    status="⏸  PAUSED"
  else
    elapsed=$(( T - START - PAUSED_TOTAL ))
    lap=$(( T - LAP_START - LAP_PAUSED ))
    status=""
  fi

  # Auto-lap
  if (( ! PAUSED && AUTO_LAP > 0 && lap >= AUTO_LAP )); then
    end_lap "$lap"
    lap=0
  fi

  # Target reached: ring the bell and pause automatically (once).
  # Press p to resume past the target, or q to finish.
  if (( ! PAUSED && elapsed >= TARGET && ! BELLED )); then
    BELLED=1
    PAUSED=1
    TARGET_PAUSE=1
    PAUSE_BEGIN=$(( START + PAUSED_TOTAL + TARGET ))   # freeze exactly at the target
    elapsed=$TARGET
    lap=$(( PAUSE_BEGIN - LAP_START - LAP_PAUSED ))
    printf '\a\a\a'
  fi
  if (( PAUSED && TARGET_PAUSE )); then
    status="✔ TARGET REACHED..."
    exit 0
  elif (( elapsed >= TARGET )) && [[ -z "$status" ]]; then
    status="Past target — press q to finish"
  fi

  draw "$elapsed" "$lap" "$status"

  key=""
  rc=0
  IFS= read -rsn1 -t "$POLL" key || rc=$?
  (( rc != 0 )) && continue   # timeout (rc 1 on bash 3.2, >128 on 4+): just redraw
  case "$key" in
    q|Q)
      (( PAUSED )) || true
      # record the in-progress lap if it has any time
      (( lap > 0 )) && LAPS+=("$LAP_NUM|$SIDE|$lap")
      summary "$elapsed"
      exit 0
      ;;
    p|P)
      if (( PAUSED )); then
        d=$(( T - PAUSE_BEGIN ))
        PAUSED_TOTAL=$(( PAUSED_TOTAL + d ))
        LAP_PAUSED=$(( LAP_PAUSED + d ))
        PAUSED=0
        TARGET_PAUSE=0
      else
        PAUSED=1
        PAUSE_BEGIN=$T
      fi
      ;;
    ""|" ")
      # Enter or space (read returns empty string for Enter)
      if (( ! PAUSED )); then
        end_lap "$lap"
      fi
      ;;
  esac
done

