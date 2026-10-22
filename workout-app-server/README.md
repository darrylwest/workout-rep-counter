# Workout App Server

The _Workout App Server_ provides REST end points to run workout sets while writing results to various targets.
All inputs are through REST endpoints, detailed below.  The intent is to separate all logic from output generation
to enable real time UI consumers the ability to display status in various formats including:

* standard console output
* TUI console application
* Web Browser page

Outputs are also sent to logs and the workout database.

## Block Diagram

## Database

### DB Schema

#### workout_config

Lists the sets to be used for an entire workout session.

Attributes:

* id string - txkey
* date_created datetime - millis
* last_updated datetime - millis
* name string - the key name used for endpoints
* set_list string - a list of set_config ids for this workout session
* notes string - ad hoc
* last_run datetime - the last time this workout was used
* status string - active, inactive, archived

#### set_config

Configurations for a single set, e.g., curl, crunch, pushup, etc

Attributes

* id string - unique identifier (txkey)
* date_created datetime - millis
* last_updated datetime - millis
* name string (no spaces) - the key name used for endpoints
* long_name string - the display name
* target_reps int
* rep_delay double
* target_sets int
* set_delay double
* difficulty int - 0 to 5 where 0 = extremely easy, 5 = extremely difficult, 3 = average
* muscle_group string - describes the muscles that this rep exercises
* notes string - how to configure, lists of videos for tips on how to use
* status string - active, inactive, archive

#### set_results

Workout details for each set of reps updated in real time.  When a set is run either descretely or in a group of sets, a record
is created to 

Attributes

* id string - unique set identifier used by endpoints
* date_created datetime - millis
* last_updated datetime - millis
* set_id string - points to the set_config entry
* set_name string - the short name
* rep_target int - copied from current config
* rep_delay double - copied from current config
* set_number int - the current set number, or 0 if this was run outside of a workout session
* workout_id string - the id of the workout or empty string if not running in a session
* start_tm datetime - millis
* end_tm datetime - millis
* status string - active, complete


###### 2026.10.22
