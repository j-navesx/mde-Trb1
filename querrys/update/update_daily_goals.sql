create or replace procedure create_daily_goals(
    ifit_user_id  INTEGER,
    idaily_steps  NUMBER,
    idaily_cals   NUMBER
) as
begin
    insert into daily_goals (fit_user_id,daily_steps,daily_cals)
    values (ifit_user_id,idaily_steps,idaily_cals);
end;