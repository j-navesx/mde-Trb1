create or replace procedure update_exercises (
    iex_id in EXERCISES.EX_ID%type,
    idistance in EXERCISES.DISTANCE%type,
    icalories in EXERCISES.CALORIES%type,
    iduration in EXERCISES.DURATION%type,
    isteps in EXERCISES.STEPS%type
) is
begin
    update EXERCISES set
    distance = idistance,
    calories = icalories,
    end_date = (SELECT SYSTIMESTAMP FROM dual),
    duration = iduration,
    steps = isteps
    where ex_id = iex_id;
end;

