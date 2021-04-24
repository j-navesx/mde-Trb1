create or replace procedure create_activities_template(
    iname           VARCHAR2,
    ical_step_mult  NUMBER,
    ical_dist_mutl  NUMBER,
    ical_time_mult  NUMBER
) as
begin
    insert into activities_template (name,cal_step_mult,cal_dist_mutl,cal_time_mult)
    values (iname,ical_step_mult,ical_dist_mutl,ical_time_mult);
end;