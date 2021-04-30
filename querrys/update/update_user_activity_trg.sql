create or replace trigger update_user_activity_trg
    after update of active
    on fit_user
    referencing new as new old as old
    for each row  
declare
    exp_date         transaction.t_date%type;
    transaction_date transaction.t_date%type;
    ifit_user_id     fit_user.id%type;
    user_premium     profile.premium%type;
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
    
    select 
        fit_user_id,
        premium
    into
        ifit_user_id,
        user_premium
    from profile
    where fit_user_id = :new.id;
    
    select max(t_date)
    into transaction_date
    from ( 
        select tr_id, t_date 
        from transaction
        where fit_user_id = ifit_user_id
    );
    
    if user_premium = 1
    then
        exp_date := ADD_MONTHS(transaction_date, 1);
        if to_date(exp_date,'YY-MM-DD') <= to_date(sysdate,'YY-MM-DD')
        then
            update profile
            set premium = 0
            where fit_user_id = ifit_user_id;
        end if;
    end if;
end;