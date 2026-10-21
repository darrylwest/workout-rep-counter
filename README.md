# Rep Counter


## Description


## UI Design

none for phase 1

## Database Schema

JSON db?

SQLite3 DB includes these tables, rep_config and rep_activity, rep_history
 
### rep_config

Configurations for each exercise

### rep_activity

activity for a single day

### rep_history

History of exercise activity, times, counts, etc.

## Static Web Page

* reads remote json config
* saves activity in local database store
* hosted at github pages?

## Web Service

* reads from server database (sqlite3) ; can convert from static json file
* writes to server database (sqlite3)
* typescript

## References

* [piper generator](https://tts.ai/voices/piper/) generate a small vocabulary of numbers, start, stop, etc.; Amy, 1.5x

###### 2026.10.20

