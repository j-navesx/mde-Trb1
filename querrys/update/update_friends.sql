create or replace procedure update_friends (
    ifit_user_id in FRIENDS_LIST.FIT_USER_ID%type,
    ifit_user_id1 in FRIENDS_LIST.FIT_USER_ID1%type
) is
begin
    update FRIENDS_LIST set
    accepted = 1
    where fit_user_id1 = ifit_user_id and fit_user_id = ifit_user_id1;
    
    insert into friends_list (fit_user_id,fit_user_id1,accepted)
    values (ifit_user_id,ifit_user_id1,1);
end;