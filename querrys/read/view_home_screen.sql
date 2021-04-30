create or replace view home_screen
    as
    select 
        profile.fit_user_id,
        profile.name, 
        daily_status.steps, 
        daily_goals.daily_steps, 
        profile.weight,
        exercises.duration, 
        exercises.distance, 
        exercises.calories, 
        exercises.begin_date
        from profile
        full outer join daily_status on daily_status.fit_user_id = profile.fit_user_id
        full outer join daily_goals on daily_goals.fit_user_id = daily_status.fit_user_id
        full outer join exercises on exercises.fit_user_id = daily_goals.fit_user_id
    where exercises.ex_id = (select max(ex_id) from exercises) or exercises.ex_id is null