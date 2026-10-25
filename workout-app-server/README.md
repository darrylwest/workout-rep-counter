# Workout App Server

The _Workout App Server_ provides REST end points to run workout sets while writing results to various targets.
All inputs are through REST endpoints, detailed below.  The intent is to separate all logic from output generation
to enable real time UI consumers the ability to display status in various formats including:

* standard console output
* TUI console application
* Web Browser page

Outputs are also sent to logs and the workout database.

## Block Diagram

## REST API Endpoint Spec

**Consider replacing this with RPC**

* GET /workouts - return all active workout records
* GET /workout id - return the specified workout details
* POST /workout id - start a new workout specified by id as the spec
* DELETE /workout - set a workout's status as archived
* GET /set_configs - return all active set config records
* GET /set_config id - return the set_config
* POST /set_config attrs - insert a new configuration
* GET /workout_activity - returns a list of workout_activity records (latest day)
* GET /status - ready, running set id, set name
* GET /health - uptime, current status, other stats

Notes:

* all returned data is in JSON format
* all POST/PUT data is in JSON format

### API Use Case Examples

## Database

SQLite3

### DB Schema

#### workout_config

Reference lists of sets to be used for an entire workout session.  For example a _full body
workout_ would include legs, quads, sit ups, crunches, curls, lunges.  A _core_ workout 
might include sit ups, crunches, planks, pushups, lunges.

Attributes:

* id string - txkey _(e.g. **8D5CptznxOhl** a 12 character unique, time-based, sortable key)_
* date_created int - unix timestamp
* last_updated int - unix timestamp
* name string - the name of this workout, e.g., full body, easy, legs, upper body, stretching
* set_list string - a comma separated list of set_config ids for this workout session
* notes string - ad hoc notes
* difficulty int - 0 to 5 where 0 = extremely easy, 5 = extremely difficult, 3 = average
* last_run datetime - the last time this workout was used
* total_runs int - the total number of times this workout has been used
* status string - active, inactive, archived

#### set_config

Configurations for a single set, e.g., curl, crunch, pushup, etc

Attributes:

* id string - unique identifier (txkey)
* date_created int - unix timestamp
* last_updated int - unix timestamp
* name string - the name of this set, e.g., curls, situps, dumbbell overhead press
* target_reps int
* rep_delay double
* target_sets int - defaults to 3 sets
* set_delay int - defaults to 180 (3 minutes)
* difficulty int - 0 to 5 where 0 = extremely easy, 5 = extremely difficult, 3 = average
* muscle_group string - describes the muscles that this rep exercises
* notes string - how to configure, lists of videos for tips on how to use
* status string - active, inactive, archived

#### workout_activity

Workout details for each set of reps updated in real time.  Each time a set is run to completion, 
either descretely or in a group of sets, a record is created to log the activity 

Attributes:

* id string - unique set identifier used by endpoints
* date_created int - unix timestamp
* last_updated int - unix timestamp
* set_config_id string - points to the set_config entry
* set_name string - the short name
* rep_target int - copied from current config
* rep_delay double - copied from current config
* set_number int - the current set number, or 0 if this was run outside of a workout session
* workout_id string - the id of the workout or empty string if not running in a session
* start_tm int - unix timestamp
* end_tm int - unix timestamp
* status string - active, completed, aborted

###### 2026.10.24 | dpw

