create or replace procedure delect_user (
    p_ID in FIT_USER.ID%type
) is
begin
    delete from FIT_USER
    where ID = p_ID;
end;