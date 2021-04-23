create or replace procedure create_friends(
    ifit_user_id     INTEGER,
    ifit_friend_id   INTEGER
) as
begin
    insert into friends_list (fit_user_id,fit_friend_id)
    values (ifit_user_id,ifit_friend_id);
end;