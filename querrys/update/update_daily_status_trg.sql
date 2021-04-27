create or replace trigger update_daily_status_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
declare
    is_completed daily_status.completed%type;
    new_distance daily_status.distance%type;
    new_calories daily_status.calories%type;
    new_steps    daily_status.steps%type;
    goal_cals    daily_goals.daily_cals%type;
    goal_steps   daily_goals.daily_steps%type;
begin
    select
        daily_steps,
        daily_cals
    into
        goal_steps,
        goal_cals
    from DAILY_GOALS
    where 
        fit_user_id = :ex.fit_user_id;

    select
        distance,
        calories,
        steps,
        completed
    into
        new_distance,
        new_calories,
        new_steps,
        is_completed
    from DAILY_STATUS
    where 
        fit_user_id = :ex.fit_user_id and status_date = (select sysdate from dual);
        
    new_distance := new_distance + :ex.distance;
    new_calories := new_calories + :ex.calories;
    new_steps := new_steps + :ex.steps;
    
    if is_completed = 0
    then
        if new_steps >= goal_steps and new_calories >= goal_cals
        then
            is_completed := 1;
        end if;
    end if;
    
    update DAILY_STATUS set
        distance = new_distance,
        calories = new_calories,
        steps = new_steps,
        completed = is_completed
    where 
        fit_user_id = :ex.fit_user_id and status_date = (select sysdate from dual);
end;