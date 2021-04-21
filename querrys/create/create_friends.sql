create or replace procedure create_friends(
    ifit_user_id  INTEGER,
    ifriends_id   INTEGER
) as
begin
    insert into friends_list (fit_user_id,friends_id)
    values (ifit_user_id,ifriends_id);
end;