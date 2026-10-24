-- workout-schema.sql
-- Create a small SQLite workout database and populate it with sample data.
-- Run with: sqlite3 workout.db < workout.sql

PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

DROP TABLE IF EXISTS workout_activity;
DROP TABLE IF EXISTS workout_config;
DROP TABLE IF EXISTS set_config;

CREATE TABLE set_config (
    id            TEXT PRIMARY KEY,
    date_created  INTEGER NOT NULL,
    last_updated  INTEGER NOT NULL,
    name          TEXT NOT NULL,
    target_reps   INTEGER NOT NULL CHECK (target_reps > 0),
    rep_delay     REAL NOT NULL DEFAULT 1.0 CHECK (rep_delay >= 0),
    target_sets   INTEGER NOT NULL DEFAULT 3 CHECK (target_sets > 0),
    set_delay     INTEGER NOT NULL DEFAULT 180 CHECK (set_delay >= 0),
    difficulty    INTEGER NOT NULL DEFAULT 3 CHECK (difficulty BETWEEN 0 AND 5),
    muscle_group  TEXT NOT NULL DEFAULT '',
    notes         TEXT NOT NULL DEFAULT '',
    status        TEXT NOT NULL DEFAULT 'active'
                  CHECK (status IN ('active', 'inactive', 'archived'))
);

CREATE TABLE workout_config (
    id            TEXT PRIMARY KEY,
    date_created  INTEGER NOT NULL,
    last_updated  INTEGER NOT NULL,
    name          TEXT NOT NULL,
    set_list      TEXT NOT NULL DEFAULT '',
    notes         TEXT NOT NULL DEFAULT '',
    difficulty    INTEGER NOT NULL DEFAULT 3 CHECK (difficulty BETWEEN 0 AND 5),
    last_run      TEXT, -- ISO 8601 datetime, e.g. 2026-10-22T09:30:00Z
    total_runs    INTEGER NOT NULL DEFAULT 0 CHECK (total_runs >= 0),
    status        TEXT NOT NULL DEFAULT 'active'
                  CHECK (status IN ('active', 'inactive', 'archived'))
);

CREATE TABLE workout_activity (
    id             TEXT PRIMARY KEY,
    date_created   INTEGER NOT NULL,
    last_updated   INTEGER NOT NULL,
    set_config_id  TEXT NOT NULL REFERENCES set_config(id),
    set_name       TEXT NOT NULL,
    rep_target     INTEGER NOT NULL CHECK (rep_target > 0),
    rep_delay      REAL NOT NULL CHECK (rep_delay >= 0),
    set_number     INTEGER NOT NULL DEFAULT 0 CHECK (set_number >= 0),
    workout_id     TEXT NOT NULL DEFAULT '',
    start_tm       INTEGER NOT NULL,
    end_tm         INTEGER,
    status         TEXT NOT NULL DEFAULT 'active'
                   CHECK (status IN ('active', 'completed', 'aborted')),
    CHECK (end_tm IS NULL OR end_tm >= start_tm)
);

CREATE INDEX idx_workout_activity_set_config_id
    ON workout_activity(set_config_id);
CREATE INDEX idx_workout_activity_workout_id
    ON workout_activity(workout_id);
CREATE INDEX idx_workout_activity_start_tm
    ON workout_activity(start_tm);

COMMIT;

