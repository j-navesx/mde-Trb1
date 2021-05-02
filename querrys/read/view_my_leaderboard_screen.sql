create or replace view my_leaderboard_screen
    as
    select 
        activities_template.name, 
        friends_leaderboard.place 
    from friends_leaderboard
        left join activities_template on activities_template.id = friends_leaderboard.totals_activities_template_id
    order by place
    
