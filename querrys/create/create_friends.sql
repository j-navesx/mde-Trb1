create or replace procedure create_friends(
    ifit_user_id     INTEGER,
    ifit_user_id1    INTEGER
) as
begin
    insert into friends_list (fit_user_id,fit_user_id1)
    values (ifit_user_id,ifit_user_id1);
end;