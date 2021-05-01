create or replace NONEDITIONABLE procedure create_activities_template(
    iname           VARCHAR2,
    ical_step_mult  NUMBER,
    ical_dist_mutl  NUMBER,
    ical_time_mult  NUMBER
) is
    aux_act_id INTEGER;
begin
    insert into activities_template (name,cal_step_mult,cal_dist_mutl,cal_time_mult)
    values (iname,ical_step_mult,ical_dist_mutl,ical_time_mult);

    SELECT id 
    INTO aux_act_id
    FROM activities_template 
    WHERE name = iname;

    FOR aRow IN (
        SELECT id
        FROM fit_user
    )
    LOOP

    insert into totals (
        fit_user_id,
        activities_template_id,
        distance,
        calories
    )
    values (
        aRow.id,
        aux_act_id,
        0,
        0
    );

    insert into friends_leaderboard (
        totals_fit_user_id,
        totals_activities_template_id,
        place
    )
    values (
        aRow.id,
        aux_act_id,
        1
    );

    END LOOP;
end;

create or replace procedure create_daily_goals(
    ifit_user_id  INTEGER,
    idaily_steps  NUMBER,
    idaily_cals   NUMBER
) as
begin
    insert into daily_goals (fit_user_id,daily_steps,daily_cals)
    values (ifit_user_id,idaily_steps,idaily_cals);
end;

create or replace procedure create_daily_status(
    ifit_user_id  INTEGER
) as
begin
    insert into daily_status (
        status_date,
        fit_user_id,
        distance,
        steps,
        weight,
        calories,
        completed
    )
    values (
        (select sysdate from dual),
        ifit_user_id,
        0,
        0,
        0,
        0,
        0
    );
end;

create or replace procedure create_exercises(
    iactivities_template_id  INTEGER,
    ifit_user_id             INTEGER
) as
begin
    insert into exercises (activities_template_id,fit_user_id,begin_date)
    values (iactivities_template_id,ifit_user_id,(SELECT SYSTIMESTAMP FROM dual));
end;

create or replace procedure create_friends(
    ifit_user_id     INTEGER,
    ifit_user_id1    INTEGER
) as
begin
    insert into friends_list (fit_user_id,fit_user_id1)
    values (ifit_user_id,ifit_user_id1);
end;

create or replace procedure create_notice(
    iexercises_ex_id  INTEGER,
    ifit_user_id      INTEGER,
    ititle            VARCHAR2,
    idescription      VARCHAR2,
    ibrief            VARCHAR2
) as
begin
    insert into notice (exercises_ex_id,fit_user_id,date_hour,title,description,brief)
    values (iexercises_ex_id,ifit_user_id,(SELECT SYSTIMESTAMP FROM dual),ititle,idescription,ibrief);
end;

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

    insert into fit_user (username, password, email, active, pt)
    values (iusername,ipassword,iemail, 0, 0);
    
    
    SELECT id 
    INTO aux_fit_user_id
    FROM fit_user 
    WHERE username = iusername;
    
    
    insert into profile (fit_user_id, name, weight, height, bday, gender, premium)
    values (aux_fit_user_id, iname, iweight, iheight, ibday, igender, 0);
    
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

create or replace procedure create_user_activity(
    ifit_user_id  INTEGER
) as
begin
    insert into user_activity (
        fit_user_id,
        act_date,
        begin_date,
        paid
    )
    values (
        ifit_user_id,
        TO_DATE(sysdate,'YYYY-MM-DD'),
        (SELECT SYSTIMESTAMP FROM dual),
        (SELECT premium from profile where fit_user_id = ifit_user_id)
    );
end;

create or replace NONEDITIONABLE procedure delect_user (
    p_ID in FIT_USER.ID%type
) is
begin
    delete from FIT_USER
    where ID = p_ID;
end;

create or replace NONEDITIONABLE procedure delete_activities (
    p_ID in ACTIVITIES_TEMPLATE.ID%type
) is
    begin
    delete from ACTIVITIES_TEMPLATE
    where ID = p_ID;
end;

create or replace NONEDITIONABLE procedure delete_friend (
    ifit_user_id1 in FRIENDS_LIST.FIT_USER_ID1%type,
    ifit_user_id in FRIENDS_LIST.FIT_USER_ID%type
) is
begin
    delete from FRIENDS_LIST
    where fit_user_id1 = ifit_user_id1 and fit_user_id = ifit_user_id;
end;

create or replace NONEDITIONABLE procedure update_exercises (
    ifit_user_id in fit_user.id%type,
    idistance in EXERCISES.DISTANCE%type,
    isteps in EXERCISES.STEPS%type,
    ibpm in EXERCISES.avg_bpm%type
) is
    ex_calories       EXERCISES.CALORIES%type;
    ex_end_date       EXERCISES.end_date%type;
    ex_duration       EXERCISES.duration%type;
    ex_duration_min   number(38);
    ex_begin_date     EXERCISES.begin_date%type;
    act_id            EXERCISES.activities_template_id%type;
    iex_id            EXERCISES.ex_id%type;
    ex_cal_step_mult  activities_template.cal_step_mult%type;
    ex_cal_dist_mutl  activities_template.cal_dist_mutl%type;
    ex_cal_time_mult  activities_template.cal_time_mult%type;
begin
    select SYSTIMESTAMP 
    into ex_end_date
    from dual;

    select ex_id
    into iex_id
    from exercises
    where fit_user_id = ifit_user_id
    and end_date is null;

    select 
        activities_template_id,
        begin_date
    into 
        act_id,
        ex_begin_date
    from exercises
    where ex_id = iex_id;

    select 
        cal_step_mult,
        cal_dist_mutl,
        cal_time_mult
    into
        ex_cal_step_mult,
        ex_cal_dist_mutl,
        ex_cal_time_mult
    from activities_template
    where id = act_id;

    ex_duration := ex_end_date - ex_begin_date;

    ex_duration_min := abs( extract( minute from ex_duration ) 
        + extract( hour from ex_duration ) * 60 
        + extract( day from ex_duration ) * 60 * 24
        );

    ex_calories := 0;

    if ex_cal_step_mult is not null
    then
        ex_calories := ex_calories + isteps*ex_cal_step_mult;
    end if;

    if ex_cal_dist_mutl is not null
    then
        ex_calories := ex_calories + idistance*ex_cal_dist_mutl;
    end if;

    if ex_cal_time_mult is not null
    then
        ex_calories := ex_calories + ex_duration_min*ex_cal_time_mult;
    end if;

    update EXERCISES set
        distance = idistance,
        calories = ex_calories,
        end_date = ex_end_date,
        duration = ex_duration,
        steps = isteps,
        avg_bpm = ibpm
    where ex_id = iex_id;
end;

create or replace NONEDITIONABLE procedure update_friends (
    ifit_user_id in FRIENDS_LIST.FIT_USER_ID%type,
    ifit_user_id1 in FRIENDS_LIST.FIT_USER_ID1%type
) is
begin
    update FRIENDS_LIST set
    accepted = 1
    where fit_user_id1 = ifit_user_id and fit_user_id = ifit_user_id1;

    insert into friends_list (fit_user_id,fit_user_id1,accepted)
    values (ifit_user_id,ifit_user_id1,1);
end;

create or replace NONEDITIONABLE procedure update_leaderboard (
    itotals_fit_user_id in FRIENDS_LEADERBOARD.TOTALS_FIT_USER_ID%type,
    itotals_activities_template_id in FRIENDS_LEADERBOARD.TOTALS_ACTIVITIES_TEMPLATE_ID%type
) is
    aux_fit_user_calories TOTALS.CALORIES%type;
    aux_fit_friend_calories TOTALS.CALORIES%type;
    place_var FRIENDS_LEADERBOARD.place%type;
begin

    select calories
    into aux_fit_user_calories
    from totals 
    where fit_user_id = itotals_fit_user_id and activities_template_id = itotals_activities_template_id;

    place_var := 1;

    for aRow in (
    select fit_user_id1
    from friends_list
    where accepted = 1
    )
    LOOP
        select calories 
        into aux_fit_friend_calories
        from totals 
        where activities_template_id = itotals_activities_template_id 
        and fit_user_id = aRow.fit_user_id1;

        if 
            aux_fit_user_calories < aux_fit_friend_calories
        then
            place_var := place_var + 1;
        end if;
    END LOOP;

    update FRIENDS_LEADERBOARD set
    place = place_var
    where totals_fit_user_id = itotals_fit_user_id and totals_activities_template_id = itotals_activities_template_id;
end;

create or replace NONEDITIONABLE function check_password
  (user_name VARCHAR2, passin VARCHAR2)
  return INTEGER
  is
  table_pass VARCHAR2(64);
  user_id INTEGER;
  begin
    select id, password
      into user_id, table_pass
      from fit_user
    where fit_user.username = user_name;

    if table_pass = passin then
      return user_id;
    else
      return 0;
    end if;
  end;
  
create or replace NONEDITIONABLE function total_paid(
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

create or replace NONEDITIONABLE trigger notice_trg
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

create or replace NONEDITIONABLE trigger update_daily_status_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
declare
    is_completed daily_status.completed%type;
    has_daily    daily_status.completed%type;
    ex_end_date  daily_status.status_date%type;
    new_distance daily_status.distance%type;
    new_calories daily_status.calories%type;
    new_steps    daily_status.steps%type;
    goal_cals    daily_goals.daily_cals%type;
    goal_steps   daily_goals.daily_steps%type;
begin
    select sysdate 
    into ex_end_date
    from dual;

    select case
        when exists(
            select * 
            from DAILY_STATUS 
            where 
                fit_user_id = :ex.fit_user_id 
                and to_date(status_date,'YYYY-MM-DD') = to_date(ex_end_date,'YYYY-MM-DD')
        )
        then 1
        else 0
        end into has_daily
    from dual;

    if has_daily = 0
    then
        create_daily_status(:ex.fit_user_id);
    end if;

    select
        daily_steps,
        daily_cals
    into
        goal_steps,
        goal_cals
    from DAILY_GOALS
    where 
        fit_user_id = :ex.fit_user_id;

    select
        distance,
        calories,
        steps,
        completed
    into
        new_distance,
        new_calories,
        new_steps,
        is_completed
    from DAILY_STATUS
    where 
        fit_user_id = :ex.fit_user_id 
        and to_date(status_date,'YYYY-MM-DD') = to_date(ex_end_date,'YYYY-MM-DD');

    new_distance := new_distance + :ex.distance;
    new_calories := new_calories + :ex.calories;
    new_steps := new_steps + :ex.steps;

    if is_completed = 0  and (goal_steps != 0 or goal_cals != 0)
    then
        if new_steps >= goal_steps and new_calories >= goal_cals
        then
            is_completed := 1;
        end if;
    end if;

    update DAILY_STATUS set
        distance = new_distance,
        calories = new_calories,
        steps = new_steps,
        completed = is_completed
    where 
        fit_user_id = :ex.fit_user_id 
        and to_date(status_date,'YYYY-MM-DD') = to_date(ex_end_date,'YYYY-MM-DD');
end;

create or replace NONEDITIONABLE trigger update_daily_weight_trg
    after update of weight
    on profile
    referencing new as profile
    for each row   
declare
    
begin
    update DAILY_STATUS set
        weight = :profile.weight
    where 
        fit_user_id = :profile.fit_user_id and status_date = (select sysdate from dual);
end;

create or replace NONEDITIONABLE trigger update_totals_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
begin
    update TOTALS set
        distance = distance + :ex.distance,
        calories = calories + :ex.calories
    where 
        fit_user_id = :ex.fit_user_id 
        and activities_template_id = :ex.activities_template_id;
end;

create or replace NONEDITIONABLE trigger update_user_activity_trg
    after update of active
    on fit_user
    referencing new as new old as old
    for each row  
declare
    exp_date         transaction.t_date%type;
    transaction_date transaction.t_date%type;
    ifit_user_id     fit_user.id%type;
    user_premium     profile.premium%type;
begin
    if :new.active = 1 and :old.active = 0
    then
        create_user_activity(:new.id);
    else
        if :new.active = 0 and :old.active = 1
        then
            update user_activity 
            set end_date = (SELECT SYSTIMESTAMP FROM dual)
            where fit_user_id = :new.id
            and end_date is null;
        end if;
    end if;

    select 
        fit_user_id,
        premium
    into
        ifit_user_id,
        user_premium
    from profile
    where fit_user_id = :new.id;

    select max(t_date)
    into transaction_date
    from ( 
        select tr_id, t_date 
        from transaction
        where fit_user_id = ifit_user_id
    );

    if user_premium = 1
    then
        exp_date := ADD_MONTHS(transaction_date, 1);
        if to_date(exp_date,'YY-MM-DD') <= to_date(sysdate,'YY-MM-DD')
        then
            update profile
            set premium = 0
            where fit_user_id = ifit_user_id;
        end if;
    end if;
end;

create or replace NONEDITIONABLE trigger update_leaderboard_trg
    after update of end_date
    on exercises
    referencing new as ex
    for each row   
begin
    update_leaderboard (:ex.fit_user_id, :ex.activities_template_id);
end;

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
        
create or replace view friends_list_screen
    as
    select
        friends_list.fit_user_id,
        fit_user.username,
        profile.name
    from friends_list
        full outer join fit_user on fit_user.id = friends_list.fit_user_id1
        full outer join profile on profile.fit_user_id = fit_user.id
    where friends_list.accepted = 1;
    
create or replace view friends_request_screen
    as
    select
        friends_list.fit_user_id1,
        fit_user.username,
        profile.name
    from friends_list
        full outer join fit_user on fit_user.id = friends_list.fit_user_id
        full outer join profile on profile.fit_user_id = fit_user.id
    where friends_list.accepted is null;
    
create or replace view home_screen
    as
    select 
        profile.fit_user_id,
        profile.name, 
        daily_status.steps, 
        daily_goals.daily_steps, 
        profile.weight,
        exercises.duration, 
        exercises.distance, 
        exercises.calories, 
        exercises.begin_date
        from profile
        full outer join daily_status on daily_status.fit_user_id = profile.fit_user_id
        full outer join daily_goals on daily_goals.fit_user_id = daily_status.fit_user_id
        full outer join exercises on exercises.fit_user_id = daily_goals.fit_user_id
    where exercises.ex_id = (select max(ex_id) from exercises) or exercises.ex_id is null;
    
create or replace view nonactive_users
    as
    select
        fit_user.id,
        profile.name,
        fit_user.active,
        user_activity.begin_date, 
        user_activity.end_date
    from fit_user
        full outer join profile on profile.fit_user_id = fit_user.id
        full outer join user_activity on user_activity.fit_user_id = profile.fit_user_id
    where fit_user.active = 0
    order by fit_user.id, user_activity.end_date desc;
    
create or replace view notification_screen
    as
    select
        notice.fit_user_id,
        profile.name as user_name,
        activities_template.name,
        notice.date_hour,
        notice.title,
        notice.description
    from notice
        full outer join profile on profile.fit_user_id = notice.fit_user_id
        full outer join exercises on exercises.ex_id = notice.exercises_ex_id
        full outer join activities_template on activities_template.id = exercises.activities_template_id  
    where activities_template.id = (select activities_template_id from exercises where exercises.ex_id = notice.exercises_ex_id)
    order by notice.date_hour desc;
    
create or replace view recent_exercises_screen
    as
    select 
        exercises.fit_user_id,
        activities_template.name,
        exercises.begin_date,
        exercises.duration,
        exercises.steps,
        exercises.distance,
        exercises.calories
    from exercises
        left join activities_template on activities_template.id = exercises.activities_template_id
        order by begin_date desc;
        
create or replace view transactions_screen
    as
    select
        transaction.fit_user_id,
        profile.name, 
        transaction.tr_id,
        transaction.value,        
        transaction.t_date
    from transaction
        left join profile on profile.fit_user_id = transaction.fit_user_id
        order by transaction.t_date desc;
        
create or replace view user_activities_screen
    as
    select  
        user_activity.fit_user_id,
        profile.name,
        user_activity.act_date,   
        user_activity.begin_date, 
        user_activity.end_date,   
        user_activity.paid
    from user_activity
        left join profile on profile.fit_user_id = user_activity.fit_user_id;
        
create or replace view user_paid_screen
    as
    select 
        fit_user.id,
        profile.name,
        profile.premium
    from fit_user
        left join profile on profile.fit_user_id = fit_user.id
        order by profile.premium desc, fit_user.id;


