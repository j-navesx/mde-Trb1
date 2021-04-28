create or replace view notification_screen
as
select
    notice.fit_user_id,
    activities_template.name,
    notice.date_hour,
    notice.title,
    notice.description
from notice
    full outer join exercises on exercises.ex_id = notice.exercises_ex_id
    full outer join activities_template on activities_template.id = exercises.activities_template_id  
where activities_template.id = (select activities_template_id from exercises where exercises.ex_id = notice.exercises_ex_id);