create or replace procedure delete_activities (
    p_ID in ACTIVITIES_TEMPLATE.ID%type
) is
    begin
    delete from ACTIVITIES_TEMPLATE
    where ID = p_ID;
end;
