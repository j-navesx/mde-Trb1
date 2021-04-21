
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
) as
begin
    if ipt_id != null then
        insert into fit_user (username, password, email, premium, active, pt, fit_user_id)
        values (iusername,ipassword,iemail,ipremium,iactive,ipt,ipt_id);
    else
        insert into fit_user (username, password, email, premium, active, pt)
        values (iusername,ipassword,iemail,ipremium,iactive, ipt);
    end if;
    
    -- create user's profile
    
    insert into profile (fit_user_id, name, weight, height, bday, gender)
    values ((SELECT id FROM fit_user WHERE username = iusername), iname, iweight, iheight, ibday, igender);
    
    -- create totals rows
    
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
        (SELECT id FROM fit_user WHERE username = iusername),
        aRow.id,
        0,
        0
    );
    
    END LOOP;
    
    -- create friends leaderboard
    
    FOR aRow IN (
        SELECT id
        FROM activities_template
    )
    LOOP
    
    insert into friends_leaderboard (
        totals_fit_user_id,
        totals_activities_template_id,
        place
    )
    values (
        (SELECT id FROM fit_user WHERE username = iusername),
        aRow.id,
        1
    );
    
    END LOOP;
end;
