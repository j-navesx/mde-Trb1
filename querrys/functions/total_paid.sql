create or replace function total_paid(
    ifit_user_id fit_user.id%type,
    begin_date  date, 
    end_date    date
    )
    return transaction.value%type
    is
        total_val transaction.value%type;
    begin
        select sum(value)
        into total_val
        from (
            select value
            from transaction
            where t_date 
            between begin_date and end_date
            and fit_user_id = ifit_user_id
        );
        
        if total_val is null
        then
            return 0;
        end if;
        
        return total_val;
    end;