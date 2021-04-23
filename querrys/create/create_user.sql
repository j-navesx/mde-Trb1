create or replace procedure create_user(
    iusername     VARCHAR2,
    ipassword     VARCHAR2,
    iemail        VARCHAR2,
    ipremium      NUMBER,
    iactive       NUMBER,
    ipt           NUMBER,
    ipt_id        INTEGER,
    iname         VARCHAR2,
    iweight       NUMBER,
    iheight       NUMBER,
    ibday         DATE,
    igender       VARCHAR2
) is
    aux_fit_user_id INTEGER;
begin
    if ipt_id != null then
        insert into fit_user (username, password, email, premium, active, pt, fit_user_id)
        values (iusername,ipassword,iemail,ipremium,iactive,ipt,ipt_id);
    else
        insert into fit_user (username, password, email, premium, active, pt)
        values (iusername,ipassword,iemail,ipremium,iactive, ipt);
    end if;
    
    -- select fit_user_id from username
    
    SELECT id 
    INTO aux_fit_user_id
    FROM fit_user 
    WHERE username = iusername;
    
    -- create user's profile
    
    insert into profile (fit_user_id, name, weight, height, bday, gender)
    values (aux_fit_user_id, iname, iweight, iheight, ibday, igender);
    
    FOR aRow IN (
        SELECT id
        FROM activities_template
    )
    LOOP
    
    -- create totals rows
    
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
    
    -- create friends leaderboard
    
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
