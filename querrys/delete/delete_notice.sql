create or replace procedure create_notice(
    iexercises_ex_id  INTEGER,
    ifit_user_id      INTEGER,
    ititle            VARCHAR2,
    idescription      VARCHAR2,
    ibrief            VARCHAR2
) as
begin
    insert into notice (exercises_ex_id,fit_user_id,date_hour,title,description,brief)
    values (iexercises_ex_id,ifit_user_id,(SELECT SYSTIMESTAMP FROM dual),ititle,idescription,ibrief);
end;