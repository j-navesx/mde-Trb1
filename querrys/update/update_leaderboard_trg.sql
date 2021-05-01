create or replace trigger update_leaderboard_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
begin
    update_leaderboard (:ex.fit_user_id, :ex.activities_template_id);
end;