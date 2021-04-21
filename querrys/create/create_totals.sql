create or replace procedure create_totals(
    ifit_user_id             INTEGER,
    iactivities_template_id  INTEGER
) as
begin
    insert into totals (
        fit_user_id,
        activities_template_id,
        distance,
        calories
    )
    values (
        ifit_user_id,
        iactivities_template_id,
        0,
        0
    );
end;