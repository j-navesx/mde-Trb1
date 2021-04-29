create or replace view transactions_screen
as
select
    transaction.fit_user_id,
    profile.name, 
    transaction.tr_id,
    transaction.value,        
    transaction.t_date
from transaction
    left join profile on profile.fit_user_id = transaction.fit_user_id;
