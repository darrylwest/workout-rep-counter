# Workout Rep Counter


## Description

## Phase 1

### Command Line

Initially, the application will be run from the command line using something like:

`bun run rep-app <exercise_name>`

This runs a single set of reps for the specified exercise_name.  Results are logged the the database.

### Reports

Markdown reports are create by reading the activity or history tables.  Reports are launched from the command line.

### Database Schema

SQLite3 DB includes these tables, rep_config and rep_activity
 
#### rep_config

Configurations for each exercise

#### rep_activity

all tracked activity.

## Phase 2

## UI Design

### Static Web Page

* reads remote json config
* saves activity in local database store
* hosted at github pages?

### Web Service

* reads from server database (sqlite3) ; can convert from static json file
* writes to server database (sqlite3)
* typescript

## To Do

* [x] generate a full vocabulary library to enable using afplay Amy @ 1.3
* [ ] replace all "say" commands with afplay
* [ ] create a sets-app to run n named sets for an exercise with delays specified between reps
* [ ] create a exercise-app to run named group of set-apps
* [ ] append results to file
* [ ] use tput or other tui to write numbers
* [ ] add random rep tips to help with breathing, muscle concentration, and other rep specific tips (squats: knees behind feet; jkk
* [ ] complete functional specs (clean up with claud)
* [ ] create bun implementation plan (claud)
* [ ] generate bun code (claud)
* [ ] integrate into AI prompt/response to exercise questions
* [ ] speech to text to issue short commands like start, pause, stop, skip, resume, etc as commands to exercise-app
* [ ] expand speech to text to send prompt to AI

## References

* [bun programming](https://bun.com/) the bun language
* [piper generator](https://tts.ai/voices/piper/) text2voice to .wav (.mp3's don't work with afplay)
* [mac speech to text](https://github.com/ljh-sh/maclisten)

###### 2026.10.21

