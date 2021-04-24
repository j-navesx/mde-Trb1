create or replace procedure delete_friend (
    p_FIT_FRIEND_ID in FRIENDS_LIST.FIT_FRIEND_ID%type,
    p_FIT_USER_ID in FRIENDS_LIST.FIT_USER_ID%type
) is
begin
    delete from FRIENDS_LIST
    where FIT_FRIEND_ID = p_FIT_FRIEND_ID and FIT_USER_ID = p_FIT_USER_ID;
end;