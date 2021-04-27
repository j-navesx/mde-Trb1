create or replace trigger update_user_activity_trg
    after update of active
    on fit_user
    referencing new as new old as old
    for each row   
begin
    if :new.active = 1 and :old.active = 0
    then
        create_user_activity(:new.fit_user_id);
    else
        if :new.active = 0 and :old.active = 1
        then
            update user_activity set
                end_date = (SELECT SYSTIMESTAMP FROM dual)
            where id = :new.id;
        end if;
    end if;
end;