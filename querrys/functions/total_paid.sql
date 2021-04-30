create or replace function total_paid(
    begin_date date, 
    end_date date
    )
    return INTEGER
    is
        total_val INTEGER;
    begin
        select sum(value)
        into total_val
        from (
            select value
            from transaction
            where t_date 
            between begin_date and end_date
        );
        
        return total_val;
    end;