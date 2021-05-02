create or replace view home_screen
    as
    select 
        profile.fit_user_id,
        profile.name, 
        daily_status.steps, 
        daily_goals.daily_steps, 
        profile.weight,
        extract(minute from duration) duration, 
        exercises.distance, 
        exercises.calories, 
        to_char(exercises.begin_date,'yyyy-mm-dd') begin_date
        from profile
        full outer join daily_status on daily_status.fit_user_id = profile.fit_user_id
        full outer join daily_goals on daily_goals.fit_user_id = daily_status.fit_user_id
        full outer join exercises on exercises.fit_user_id = daily_goals.fit_user_id
    where exercises.ex_id = (select max(ex_id) from exercises where fit_user_id = profile.fit_user_id) or exercises.ex_id is null