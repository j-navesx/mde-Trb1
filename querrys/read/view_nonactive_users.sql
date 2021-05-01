create or replace view nonactive_users
    as
    select
        fit_user.id,
        profile.name,
        fit_user.active,
        user_activity.begin_date, 
        user_activity.end_date
    from fit_user
        full outer join profile on profile.fit_user_id = fit_user.id
        full outer join user_activity on user_activity.fit_user_id = profile.fit_user_id
    where fit_user.active = 0
    order by user_activity.end_date desc, fit_user.id