create or replace procedure create_transactions(
    ifit_user_id  INTEGER,
    ivalue        NUMBER
) as
begin
    insert into transaction (
        fit_user_id,
        value,
        t_date       
    )
    values (
        ifit_user_id,
        ivalue,
        (SELECT SYSTIMESTAMP FROM dual)
    );
end;