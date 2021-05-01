create or replace view user_paid_screen
    as
    select 
        fit_user.id,
        profile.name,
        fit_user.premium
    from fit_user
        left join profile on profile.fit_user_id = fit_user.id
        order by fit_user.premium desc, fit_user.id