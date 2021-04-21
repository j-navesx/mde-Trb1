create or replace procedure create_leaderboard(
    itotals_fit_user_id             INTEGER,
    itotals_activities_template_id  INTEGER
) as
begin
    insert into friends_leaderboard (
        totals_fit_user_id,
        totals_activities_template_id,
        place
    )
    values (
        itotals_fit_user_id,
        itotals_activities_template_id,
        1
    );
end;