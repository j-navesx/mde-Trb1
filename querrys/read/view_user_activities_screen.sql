create or replace view user_activities_screen
    as
    select  
        user_activity.fit_user_id,
        profile.name,
        user_activity.act_date,   
        to_char(user_activity.begin_date, 'YYYY-MM-DD') as begin_date, 
        to_char(user_activity.end_date, 'YYYY-MM-DD') as end_date,   
        user_activity.paid
    from user_activity
        left join profile on profile.fit_user_id = user_activity.fit_user_id
