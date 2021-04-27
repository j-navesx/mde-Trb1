create or replace trigger update_totals_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
begin
    update TOTALS set
        distance = distance + :ex.distance,
        calories = calories + :ex.calories
    where 
        fit_user_id = :ex.fit_user_id 
        and activities_template_id = :ex.activities_template_id;
end;