#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-24 16:07:02
#

set -euo pipefail

scripts="scripts/db-squats.sh scripts/floor-press-up.sh scripts/db-bent-over-rows.sh scripts/db-calf-raises.sh scripts/db-overhead.sh scripts/hip-thrust.sh"
alternates="scripts/db-arm-lifts.sh scripts/db-one-arm-pull.sh scripts/lunge.sh scripts/pushups.sh scripts/sit-up.sh scripts/curl.sh"

show_sets() {
    printf "Workout List: $scripts\n"
}

run_script() {
    script=$1

    for ((i = 1; i <= 3; i++))
    do
        printf "Running $script, set: $i\n"

        ## alway return true to enable query quit on ctrl-c
        $f || true

        printf "Rest a minute or two: `date +%T`\n"
        sleep 10

        if (( $i < 3 ))
        then
            read -r -p "[R]un $script set, or [S]kip? " response

            case "${response,,}" in
              s|skip)
                echo "Skipping $f\n"
                break
                ;;
              *)
                printf "ok...\n"
                ;;
            esac
        fi
    done

    clear
}

query_quit() {
    printf "\n\n"
    read -r -p "[C]continue or [E]xit: " response
    
    case "${response,,}" in
        e|exit)
            printf "\nbye bye!\n"
            exit 130
            ;;
        *)
            printf "continue...\n"
            ;;
    esac
}

trap query_quit INT

for f in $scripts
do
    clear

    show_sets
    printf "\n**** Script: $f ****\n"
    while true
    do
        # show the day's progress so far
        read -r -p "[R]un $f or [S]kip? or [E]xit: " response

        case "${response,,}" in
          r|run)
            run_script $f
            break
            ;;
          s|skip)
            echo "Skipping $f\n"
            break
            ;;
          e|exit)
            echo "bye\n"
            exit 0
            ;;
          *)
            echo "Invalid choice: '$response', please try again..."
            ;;
        esac
    done
done
