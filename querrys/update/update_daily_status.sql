create or replace procedure create_daily_status(
    fit_user_id  INTEGER
) as
begin
    insert into daily_status (
        fit_user_id,
        distance,
        steps,
        weigth,
        calories,
        completed
    )
    values (
        ifit_user_id,
        0,
        0,
        0,
        0,
        0
    );
end;