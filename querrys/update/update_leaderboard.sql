create or replace procedure update_leaderboard (
    itotals_fit_user_id in FRIENDS_LEADERBOARD.TOTALS_FIT_USER_ID%type,
    itotals_activities_template_id in FRIENDS_LEADERBOARD.TOTALS_ACTIVITIES_TEMPLATE_ID%type
) is
begin
    update FRIENDS_LEADERBOARD set
    place = iplace
    where totals_fit_user_id = itotals_fit_user_id and totals_activities_template_id = itotals_activities_template_id;
    
    FOR aRow IN (
        SELECT distance
        FROM totals
        WHERE activities_template_id = itotals_activities_template_id
    )
    LOOP
        
    END LOOP;
end;