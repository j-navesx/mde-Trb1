create or replace view recent_exercises_screen
    as
    select 
        exercises.fit_user_id,
        activities_template.name,
        exercises.begin_date,
        exercises.duration,
        exercises.steps,
        exercises.distance,
        exercises.calories
    from exercises
        left join activities_template on activities_template.id = exercises.activities_template_id
        order by begin_date desc