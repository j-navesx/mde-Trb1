create or replace procedure create_exercises(
    iactivities_template_act_id  INTEGER,
    ifit_user_id                 INTEGER
) as
begin
    insert into exercises (activities_template_act_id,fit_user_id,begin_date)
    values (iactivities_template_act_id,ifit_user_id,(SELECT SYSTIMESTAMP FROM dual));
end;

