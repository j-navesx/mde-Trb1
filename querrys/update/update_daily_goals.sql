create or replace procedure update_daily_goals (
    idaily_cals in DAILY_GOALS.DAILY_CALS%type,
    idaily_steps in DAILY_GOALS.DAILY_STEPS%type, 
    ifit_user_id in DAILY_GOALS.FIT_USER_ID%type
) is
begin
    update DAILY_GOALS set
    DAILY_CALS = idaily_cals,
    DAILY_STEPS = idaily_steps
    where FIT_USER_ID = ifit_user_id;
end;