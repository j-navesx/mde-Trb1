create or replace view user_paid_screen
    as
    select 
        fit_user.id,
        profile.name,
        profile.premium
    from fit_user
        left join profile on profile.fit_user_id = fit_user.id
        order by profile.premium desc, fit_user.id