-- consider removing the current db and recreating
-- Run with: sqlite3 workout.db < workout.sql
--

-- Sample set configurations. IDs are illustrative 12-character txkeys.
BEGIN TRANSACTION;

INSERT INTO set_config
(id, date_created, last_updated, name, target_reps, rep_delay, target_sets,
 set_delay, difficulty, muscle_group, notes, status)
VALUES
('8D5CptznxOhl', 1792600000, 1792600000, 'Dumbbell Goblet Squat', 10, 2.5, 3,
 180, 3, 'Quadriceps, glutes', 'Keep chest upright; use a comfortable range of motion.', 'active'),
('8D5CptznxOhm', 1792600000, 1792600000, 'Dumbbell Overhead Press', 10, 2.0, 3,
 180, 3, 'Shoulders, triceps', 'Press smoothly; avoid arching the lower back.', 'active'),
('8D5CptznxOhn', 1792600000, 1792600000, 'Dumbbell Curl', 12, 2.0, 3,
 120, 2, 'Biceps', 'Keep elbows near your sides and avoid swinging.', 'active'),
('8D5CptznxOho', 1792600000, 1792600000, 'Crunch', 12, 1.5, 3,
 90, 2, 'Abdominals', 'Use controlled movement; avoid pulling on the neck.', 'active'),
('8D5CptznxOhp', 1792600000, 1792600000, 'Wall Push-up', 12, 2.0, 3,
 120, 2, 'Chest, shoulders, triceps', 'Adjust distance from wall to control difficulty.', 'active'),
('8D5CptznxOhq', 1792600000, 1792600000, 'Standing Calf Raise', 15, 1.5, 3,
 90, 2, 'Calves', 'Use a stable support for balance if needed.', 'active'),
('8D5CptznxOhr', 1792600000, 1792600000, 'Bird Dog', 8, 2.0, 2,
 90, 2, 'Core, back, glutes', 'Perform 8 repetitions per side with controlled movement.', 'active');

-- set_list contains comma-separated set_config IDs, as specified in the schema.
INSERT INTO workout_config
(id, date_created, last_updated, name, set_list, notes, difficulty, last_run, total_runs, status)
VALUES
('9E6DquaypIjm', 1792600100, 1792600100, 'Full Body',
 '8D5CptznxOhl,8D5CptznxOhm,8D5CptznxOhn,8D5CptznxOhp,8D5CptznxOhq',
 'General strength routine; adjust loads and repetitions to comfort.', 3,
 '2026-10-21T09:00:00Z', 12, 'active'),
('9E6DquaypIjn', 1792600100, 1792600100, 'Core and Balance',
 '8D5CptznxOho,8D5CptznxOhr,8D5CptznxOhq,8D5CptznxOhp',
 'Controlled core and balance session.', 2,
 '2026-10-22T09:15:00Z', 7, 'active'),
('9E6DquaypIjo', 1792600100, 1792600100, 'Upper Body',
 '8D5CptznxOhm,8D5CptznxOhn,8D5CptznxOhp',
 'Shoulders, arms, and chest.', 3,
 NULL, 0, 'active');

-- Sample activity records: two completed sets and one in-progress set.
-- workout_id is the workout_config ID for session activity; set_number is 1-based.
INSERT INTO workout_activity
(id, date_created, last_updated, set_config_id, set_name, rep_target, rep_delay,
 set_number, workout_id, start_tm, end_tm, status)
VALUES
('A1F7rswQmN01', 1792601000, 1792601120, '8D5CptznxOhl', 'Dumbbell Goblet Squat',
 10, 2.5, 1, '9E6DquaypIjm', 1792601000, 1792601120, 'completed'),
('A1F7rswQmN02', 1792601300, 1792601420, '8D5CptznxOhl', 'Dumbbell Goblet Squat',
 10, 2.5, 2, '9E6DquaypIjm', 1792601300, 1792601420, 'completed'),
('A1F7rswQmN03', 1792689300, 1792689300, '8D5CptznxOhn', 'Dumbbell Curl',
 12, 2.0, 0, '', 1792689300, NULL, 'active');

COMMIT;

-- Quick verification queries:
SELECT 'set_config rows' AS item, COUNT(*) AS count FROM set_config
UNION ALL
SELECT 'workout_config rows', COUNT(*) FROM workout_config
UNION ALL
SELECT 'workout_activity rows', COUNT(*) FROM workout_activity;

