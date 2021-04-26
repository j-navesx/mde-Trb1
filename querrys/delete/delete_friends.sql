create or replace procedure delete_friend (
    ifit_user_id1 in FRIENDS_LIST.FIT_USER_ID1%type,
    ifit_user_id in FRIENDS_LIST.FIT_USER_ID%type
) is
begin
    delete from FRIENDS_LIST
    where fit_user_id1 = ifit_user_id1 and fit_user_id = ifit_user_id;
end;