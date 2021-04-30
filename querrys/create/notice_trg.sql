create or replace trigger notice_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
declare
    age         number(3);
    max_bpm     number(3);
    user_bday   profile.bday%type;
begin
    select bday
    into user_bday
    from profile
    where fit_user_id = :ex.fit_user_id;

    age := round((to_date(sysdate, 'YY-MM-DD') - user_bday)/365.25,0);
    max_bpm := 220 - age;
    
    if :ex.avg_bpm >= 0.76*max_bpm and :ex.avg_bpm <= 0.86*max_bpm
    then
        create_notice (:ex.ex_id, :ex.fit_user_id, 'kinda alto mas meh', 'placeholder', 'placeholder');
    end if;
    
    if :ex.avg_bpm >= 0.87*max_bpm and :ex.avg_bpm < max_bpm
    then
        create_notice (:ex.ex_id, :ex.fit_user_id, 'oi isso não esta bom', 'placeholder', 'placeholder');
    end if;
    
    if :ex.avg_bpm >= max_bpm
    then
        create_notice (:ex.ex_id, :ex.fit_user_id, 'vai para o hospital rapido', 'placeholder', 'placeholder');
    end if;
end;