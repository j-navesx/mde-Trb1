create or replace view daily_status_screen
as
select     
    daily_status.fit_user_id,
    profile.name,
    daily_status.daily_id,
    daily_status.status_date,  
    daily_status.distance,     
    daily_status.steps,        
    daily_status.weight,       
    daily_status.calories,     
    daily_status.completed
from daily_status
    left join profile on profile.fit_user_id = daily_status.fit_user_id;