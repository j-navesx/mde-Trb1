create or replace procedure create_user(
    iusername     VARCHAR2,
    ipassword     VARCHAR2,
    iemail        VARCHAR2,
    iname         VARCHAR2,
    iweight       NUMBER,
    iheight       NUMBER,
    ibday         DATE,
    igender       VARCHAR2
) is
    aux_fit_user_id INTEGER;
begin

    insert into fit_user (username, password, email, premium, active, pt)
    values (iusername,ipassword,iemail, 0, 0, 0);
    
    
    SELECT id 
    INTO aux_fit_user_id
    FROM fit_user 
    WHERE username = iusername;
    
    
    insert into profile (fit_user_id, name, weight, height, bday, gender)
    values (aux_fit_user_id, iname, iweight, iheight, ibday, igender);
    
    insert into daily_goals (fit_user_id,daily_steps,daily_cals)
    values (aux_fit_user_id,0,0);
    
    FOR aRow IN (
        SELECT id
        FROM activities_template
    )
    LOOP
    
    
    insert into totals (
        fit_user_id,
        activities_template_id,
        distance,
        calories
    )
    values (
        aux_fit_user_id,
        aRow.id,
        0,
        0
    );
    
    
    insert into friends_leaderboard (
        totals_fit_user_id,
        totals_activities_template_id,
        place
    )
    values (
        aux_fit_user_id,
        aRow.id,
        1
    );
    
    END LOOP;
end;
