create or replace procedure create_user_activity(
    ifit_user_id  INTEGER
) as
begin
    insert into user_activity (
        fit_user_id,
        act_date,
        begin_date,
        paid
    )
    values (
        ifit_user_id,
        TO_DATE(sysdate,'YYYY-MM-DD'),
        (SELECT SYSTIMESTAMP FROM dual),
        (SELECT premium from fit_user where id = ifit_user_id)
    );
end;

create or replace trigger update_user_activity_trg
    after update of active
    on fit_user
    referencing new as fit_user
    for each row   
begin
    
end;