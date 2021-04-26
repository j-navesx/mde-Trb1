create or replace procedure upd (
    idistance in DAILY_STATUS.DISTANCE%type,
    icompleted in DAILY_STATUS.COMPLETED%type,
    ifit_user_id in DAILY_STATUS.FIT_USER_ID%type,
    iweigth in DAILY_STATUS.WEIGTH%type,
    icalories in DAILY_STATUS.CALORIES%type,
    istep in DAILY_STATUS.STEPS%type
) is
begin
    update DAILY_STATUS set
    distance = idistance,
    completed = icompleted,
    weigth = iweigth,
    calories = icalories,
    step = istep
    where fit_user_id = ifit_user_id;
end;