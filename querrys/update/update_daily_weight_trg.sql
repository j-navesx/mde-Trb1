create or replace trigger update_daily_weight_trg
    after update of weight
    on profile
    referencing new as profile
    for each row   
declare
    
begin
    update DAILY_STATUS set
        weight = :profile.weight
    where 
        fit_user_id = :profile.fit_user_id and status_date = (select sysdate from dual);
end;