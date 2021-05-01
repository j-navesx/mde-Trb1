create or replace procedure update_leaderboard (
    itotals_fit_user_id in FRIENDS_LEADERBOARD.TOTALS_FIT_USER_ID%type,
    itotals_activities_template_id in FRIENDS_LEADERBOARD.TOTALS_ACTIVITIES_TEMPLATE_ID%type
) is
    aux_fit_user_calories TOTALS.CALORIES%type;
    aux_fit_friend_calories TOTALS.CALORIES%type;
    place_var FRIENDS_LEADERBOARD.place%type;
begin
    
    select calories
    into aux_fit_user_calories
    from totals 
    where fit_user_id = itotals_fit_user_id and activities_template_id = itotals_activities_template_id;
    
    place_var := 1;
    
    for aRow in (
    select fit_user_id1
    from friends_list
    where accepted = 1
    and fit_user_id = itotals_fit_user_id
    )
    LOOP
        select calories 
        into aux_fit_friend_calories
        from totals 
        where activities_template_id = itotals_activities_template_id 
        and fit_user_id = aRow.fit_user_id1;
        
        if 
            aux_fit_user_calories < aux_fit_friend_calories
        then
            place_var := place_var + 1;
        end if;
    END LOOP;
    
    update FRIENDS_LEADERBOARD set
    place = place_var
    where totals_fit_user_id = itotals_fit_user_id and totals_activities_template_id = itotals_activities_template_id;
end;