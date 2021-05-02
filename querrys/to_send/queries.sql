-- RF 1



-- RF 2



-- RF 3



-- RF 4
-- Visualizar os valores diários para um utilizador entre duas datas.

select * 
from daily_status_screen 
where fit_user_id = 1 
and status_date 
between to_date('2021-04-28','YYYY-MM-DD') 
and to_date('2021-05-01','YYYY-MM-DD')+1;

-- RF 5
-- Visualizar as notificações dum utilizador nos últimos 7 dias.

select *
from notification_screen 
where fit_user_id = 1 and
date_hour between sysdate-7 and sysdate;

-- RF 6
-- Visualizar utilizadores com ritmo cardíaco abaixo ou acima de certos limiares, 
-- considerando a sua idade.

select fit_user_id, user_name
from notification_screen
order by fit_user_id;

-- RF 7
-- Visualizar cada utilizador e o total pago desde uma data anterior (fornecida) até à 
-- data actual.

select id, name, premium, total_paid(user_paid_screen.id, to_date('2021-04-19','YYYY-MM-DD'),sysdate) as total_paid 
from user_paid_screen;

-- RF 8
-- Visualizar os clientes não ativos. Para cada um deles, visualizar as datas de 
-- inicio/fim do período de activo e eventualmente, o total de valor pago.

select id, name, active, begin_date, end_date, total_paid(id, begin_date, end_date) as total_paid 
from nonactive_users;

-- RF 10
-- Proponha um requisito relevante ainda por identificar e que requeira uma query 
-- simples para o satisfazer. Implemente

-- Ver amigos aceites

select * 
from friends_list
where fit_user_id = 1
and accepted = 1;

-- Ver posição na leaderboard em relação aos amigos aceites por atividade

select activities_template.name, friends_leaderboard.place 
from friends_leaderboard
left join activities_template 
on activities_template.id = friends_leaderboard.totals_activities_template_id
where totals_fit_user_id = 18
order by place;

-- RF 11
-- Proponha um requisito relevante ainda por identificar e que requeira uma query 
-- com funções de agregação (sum, max, min, etc) para o satisfazer. Implemente.

-- max() utilizado em trigger update_user_activity_trg

select sum(value)
from (
    select value
    from transaction
    where t_date 
    between begin_date and end_date
    and fit_user_id = 1
);

-- sum() utilizado em function total_paid

select max(t_date)
from ( 
    select tr_id, t_date 
    from transaction
    where fit_user_id = 1
);




