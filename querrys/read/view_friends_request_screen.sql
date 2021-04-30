create or replace view friends_request_screen
    as
    select
        friends_list.fit_user_id1,
        fit_user.username,
        profile.name
    from friends_list
        full outer join fit_user on fit_user.id = friends_list.fit_user_id
        full outer join profile on profile.fit_user_id = fit_user.id
    where friends_list.accepted is null