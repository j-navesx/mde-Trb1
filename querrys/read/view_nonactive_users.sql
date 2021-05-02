create or replace view nonactive_users
    as
    select
        fit_user.id,
        profile.name,
        fit_user.active,
        to_char(user_activity.begin_date) as begin_date, 
        to_char(user_activity.end_date) as end_date
    from fit_user
        full outer join profile on profile.fit_user_id = fit_user.id
        full outer join user_activity on user_activity.fit_user_id = profile.fit_user_id
    where fit_user.active = 0
    order by fit_user.id, user_activity.end_date desc