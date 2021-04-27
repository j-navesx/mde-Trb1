create or replace procedure create_daily_status(
    ifit_user_id  INTEGER
) as
begin
    insert into daily_status (
        status_date,
        fit_user_id,
        distance,
        steps,
        weight,
        calories,
        completed
    )
    values (
        (select sysdate from dual),
        ifit_user_id,
        0,
        0,
        0,
        0,
        0
    );
end;