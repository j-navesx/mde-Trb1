create or replace view transactions_screen
    as
    select
        transaction.fit_user_id,
        profile.name, 
        transaction.tr_id,
        transaction.value,        
        to_char(transaction.t_date,'YYYY-MM-DD') as t_date
    from transaction
        left join profile on profile.fit_user_id = transaction.fit_user_id
    where transaction.t_date between sysdate-7 and sysdate    
    order by transaction.t_date desc
    
