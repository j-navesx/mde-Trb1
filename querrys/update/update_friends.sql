create or replace procedure update_friends (
    iaccepted in FRIENDS_LIST.ACCEPTED%type,
    ifit_user_id in FRIENDS_LIST.FIT_USER_ID%type,
    ifit_user_id1 in FRIENDS_LIST.FIT_USER_ID1%type
) is
begin
    update FRIENDS_LIST set
    accepted = iaccepted
    where fit_user_id1 = ifit_user_id1 and fit_user_id = ifit_user_id;
    
    update FRIENDS_LIST set
    accepted = iaccepted
    where fit_user_id1 = ifit_user_id and fit_user_id = ifit_user_id1;
end;