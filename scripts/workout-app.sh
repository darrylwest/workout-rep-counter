#!/usr/bin/env bash
# dpw@tiburon.local
# 2026-10-24 23:35:54
#

set -euo pipefail


fullbody1="db-squats floor-press-up db-bent-over-rows db-calf-raises db-overhead hip-thrust"
fullbody2="db-squats db-arm-lifts hip-thrust db-one-arm-pull lunge pushups sit-up curl"
core1="90-second-plank side-plank reverse-plank side-plank sit-up crunch single-leg-raise"
core2="90-second-plank tip-toe-hold bird-dogs sit-up crunch crab-press donkey-kicks leg-lifts"
upperbody=""
lowerbody="leg-raise"
mobility="plank bird-dogs down-dog-press reverse-plank deep-squat standing-donkey-kicks"

# dead-bugs

workout=$core2

scipt_list="fullbody1 upperbody core1 fullbody2 core2 lowerbody mobility"

show_sets() {
    printf "Workout List: $workout\n"
}

START_TIME=`date +"%s"`
run_script() {
    script=$1

    for ((i = 1; i <= 3; i++))
    do
        printf "Running $script, set: $i\n"

        ## alway return true to enable query quit on ctrl-c
        "scripts/${script}.sh" || true

        printf "Rest a minute or two: `date +%T`\n"
        sleep 10 || true

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
    E
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

for f in $workout
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

END_TIME=`date +"%s"`
elapsed=$(( END_TIME - START_TIME ))

printf "\n\nSets: $workout, $elapsed total seconds, $(( elapsed / 60 )) minutes..."
say "Workout session completed"

