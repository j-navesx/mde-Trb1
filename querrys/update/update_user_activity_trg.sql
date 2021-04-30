create or replace trigger update_user_activity_trg
    before update of active
    on fit_user
    referencing new as new old as old
    for each row  
declare
    PRAGMA AUTONOMOUS_TRANSACTION;
    exp_date         transaction.t_date%type;
    transaction_date transaction.t_date%type;
begin
    if :new.active = 1 and :old.active = 0
    then
        create_user_activity(:new.id);
    else
        if :new.active = 0 and :old.active = 1
        then
            update user_activity 
            set end_date = (SELECT SYSTIMESTAMP FROM dual)
            where fit_user_id = :new.id
            and end_date is null;
        end if;
    end if;
    COMMIT;
end;