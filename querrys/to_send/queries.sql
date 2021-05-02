-- RF 1
-- Implementar as operações CRUD da BD em termos de utilizadores, perfis,
-- objetivos diários e tipos de exercícios.

select * from fit_user;

--ID    Username    Password    Email                           Active  PT
--1	    Minecreeper	mde	        gc.pombo@campus.fct.unl.pt	    0	    0	
--2	    Loukios	    mde	        Loukios@campus.fct.unl.pt	    0	    0	
--3	    Duff	    mde	        Duff@campus.fct.unl.pt	        0	    0	
--4	    Constantin	mde	        Constantin@campus.fct.unl.pt	0	    0	
--5	    Cirino	    mde	        Cirino@campus.fct.unl.pt	    0	    0	
--6	    Yonah	    mde	        Yonah@campus.fct.unl.pt	        0	    0	
--7	    Paora	    mde	        Paora@campus.fct.unl.pt	        0	    0	
--8	    Arttu	    mde	        Arttu@campus.fct.unl.pt	        0	    0	
--9	    Eriu	    mde	        Eriu@campus.fct.unl.pt	        0	    0	
--10    Marlis	    mde	        Marlis@campus.fct.unl.pt	    0	    0		

select 
    fit_user_id,
    name,
    weight,
    height,
    bday,
    case 
        when gender = 'm' then 'Male'
        when gender = 'f' then 'Female'
    end as gender,
    premium
from profile;

--Fit_user_id   Name        Weight  Bday            Gender      Premium
--1	            Guilherme	61	    169	00.04.19	Male	    1
--2 	        Loukios	    69	    175	00.01.01	Male	    1
--3	            Duff	    69	    175	00.01.01	Male	    1
--4	            Constantin	69	    175	00.01.01	Male	    1
--5	            Cirino	    69	    175	00.01.01	Male	    1
--6	            Yonah	    69	    175	00.01.01	Male	    1
--7	            Paora	    69	    175	00.01.01	Male	    1
--8	            Arttu	    69	    175	00.01.01	Male	    1
--9	            Eriu	    69	    175	00.01.01	Female	    1
--10	        Marlis	    69	    175	00.01.01	Female	    1

select * from daily_goals;

--Fit_user_id   Daily_steps     Daily_cals
--1	            1000	        400
--2	            1000	        400
--3 	        1000	        400
--4	            1000	        400
--5	            1000	        400
--6	            1000	        400
--7	            1000	        400
--8	            1000	        400
--9	            1000	        400
--10	        1000	        400

select * from activities_template;

--ID    Name            Cal_step_mult   Cal_dist_mult   Cal_time_mult
--1	    Squats			(null)          (null)          8
--2	    Jumping Jacks	(null)          (null)          16
--3	    Crab Walk		(null)          (null)          10
--4	    Jogging		    (null)          60	            (null)
--5	    Crunches		(null)          (null)          6
--6	    Wall Pushups    (null)          (null)          7
--7	    Lunges			(null)          (null)          6
--8	    High Knees		(null)          (null)          6
--9	    Wall Sit		(null)          (null)          3,6

-- RF 2
-- Proceder ao registo de exercícios físicos efetuados por cada utilizador.

select *
from exercises
order by fit_user_id;

--Ex_id activities_template_id  fit_user_id     Duration                Steps   Distance    Calories    Begin_date                  End_date                    Avg_bpm
--1	    4	                    1	            +00 00:00:00.000000	    0	    23	        1380	    21.05.02 11:50:42,173000000	21.05.02 11:50:42,274000000	159
--3	    3	                    4	            +00 00:00:00.000000	    0	    0	        0	        21.05.02 11:50:42,183000000	21.05.02 11:50:42,431000000	132
--5	    9	                    5	            +00 00:00:00.000000	    0	    0	        0	        21.05.02 11:50:42,194000000	21.05.02 11:50:42,447000000	139
--7	    5	                    7	            +00 00:00:00.000000	    0	    0	        0	        21.05.02 11:50:42,207000000	21.05.02 11:50:42,463000000	179
--9	    4	                    8	            +00 00:00:00.000000	    0	    20	        1200	    21.05.02 11:50:42,218000000	21.05.02 11:50:42,482000000	146
--11	7	                    9	            +00 00:00:00.000000	    0	    0	        0	        21.05.02 11:50:42,229000000	21.05.02 11:50:42,494000000	211
--13	5	                    10	            +00 00:00:00.000000	    0	    0	        0	        21.05.02 11:50:42,242000000	21.05.02 11:50:42,508000000	132
--15	4	                    11	            +00 00:00:00.000000	    0	    15	        900	        21.05.02 11:50:42,255000000	21.05.02 11:50:42,525000000	153
--4	    4	                    12	            +00 00:00:00.000000	    0	    20	        1200	    21.05.02 11:50:42,187000000	21.05.02 11:50:42,439000000	179
--6	    4	                    13	            +00 00:00:00.000000	    0	    30	        1800	    21.05.02 11:50:42,201000000	21.05.02 11:50:42,455000000	146

-- RF 3
-- Proceder ao registo de notificações, sempre que após um exercício, algum 
-- parâmetro possua um valor abaixo ou acima duma gama recomendada (por 
-- exemplo, o ritmo cardíaco).

select * 
from notice
order by fit_user_id;

--N_id  Exercises_ex_id Fit_user_id Date_hour                   Title                       Description Brief
--1	    1	            1	        21.05.02 11:50:42,366000000	kinda alto mas meh	        placeholder	placeholder
--4	    7	            7	        21.05.02 11:50:42,464000000	oi isso não esta bom	    placeholder	placeholder
--6	    11	            9	        21.05.02 11:50:42,495000000	vai para o hospital rapido	placeholder	placeholder
--7	    15	            11	        21.05.02 11:50:42,525000000	kinda alto mas meh	        placeholder	placeholder
--3	    4	            12	        21.05.02 11:50:42,440000000	oi isso não esta bom	    placeholder	placeholder
--5	    10	            15	        21.05.02 11:50:42,488000000	oi isso não esta bom	    placeholder	placeholder
--8	    16	            21	        21.05.02 11:50:42,533000000	kinda alto mas meh	        placeholder	placeholder
--2	    2	            28	        21.05.02 11:50:42,423000000	kinda alto mas meh	        placeholder	placeholder

-- RF 4
-- Visualizar os valores diários para um utilizador entre duas datas.

select * 
from daily_status_screen
where fit_user_id = 18
and status_date
between to_date('2021-04-28','YYYY-MM-DD') 
and to_date('2021-05-02','YYYY-MM-DD')+1;

--Para o caso da condição ser fit_user_id = 1

--Fit_user_id   Name        Daily_id    Status_date Distance    Steps   Weight  Calories    Completed
--1	            Guilherme	1	        21.05.02	23	        0	    0	    1380	    0

--Para o caso da condição ser fit_user_id = 18

--Fit_user_id   Name        Daily_id    Status_date Distance    Steps   Weight  Calories    Completed
--18	        Augusta	    14	        21.05.02	10	        0	    0	    600	        0

-- RF 5
-- Visualizar as notificações dum utilizador nos últimos 7 dias.

select *
from notification_screen 
where fit_user_id = 1 and
date_hour between sysdate-7 and sysdate;

--Para o caso da condição ser fit_user_id = 1

--Fit_user_id   User_name   Name        Date_hour   Title                       Description
--1	            Guilherme	Jogging	    2021-05-02	kinda alto mas meh	        placeholder

--Para o caso da condição ser fit_user_id = 9

--Fit_user_id   User_name   Name        Date_hour   Title                       Description
--9	            Eriu	    Lunges	    2021-05-02	vai para o hospital rapido	placeholder

-- RF 6
-- Visualizar utilizadores com ritmo cardíaco abaixo ou acima de certos limiares, 
-- considerando a sua idade.

select fit_user_id, user_name
from notification_screen
order by fit_user_id;

--Fit_user_id   User_name
--1	            Guilherme
--7	            Paora
--9	            Eriu
--11	        Meabh
--12	        Amabilia
--15	        Leanne
--21	        Aarti
--28	        Colwyn

-- RF 7
-- Visualizar cada utilizador e o total pago desde uma data anterior (fornecida) até à 
-- data actual.

-- É usada a função total_paid() para calcular o valor pago entre duas datas

select 
    id, 
    name, 
    premium, 
    total_paid(user_paid_screen.id, to_date('2021-04-19','YYYY-MM-DD'),sysdate) as total_paid 
from user_paid_screen;

--ID    Name        Premium Total_paid
--1	    Guilherme	1	    0,99
--2	    Loukios	    1	    2,97
--3	    Duff	    1	    1,98
--4	    Constantin	1	    4,95
--5	    Cirino	    1	    2,97
--6	    Yonah	    1	    1,98
--7	    Paora	    1	    0,99
--8	    Arttu	    1	    1,98
--9	    Eriu	    1	    3,96
--10	Marlis	    1	    1,98

-- RF 8
-- Visualizar os clientes não ativos. Para cada um deles, visualizar as datas de 
-- inicio/fim do período de activo e eventualmente, o total de valor pago.

select 
    id, 
    name, 
    active, 
    to_date(begin_date,'YYYY-MM-DD') as begin_date, 
    to_date(end_date,'YYYY-MM-DD')+1 as end_date, 
    total_paid(id, to_date(begin_date,'YYYY-MM-DD'), to_date(end_date,'YYYY-MM-DD')+1) as total_paid 
from nonactive_users;

--ID    Name        Active  Begin_date  End_date    Total_paid
--1	    Guilherme	0	    21.05.02	21.05.03	0,99
--2	    Loukios	    0	    21.05.02	21.05.03	2,97
--3	    Duff	    0	    21.05.02	21.05.03	1,98
--4	    Constantin	0	    21.05.02	21.05.03	4,95
--5	    Cirino	    0	    21.05.02	21.05.03	2,97
--6	    Yonah	    0	    21.05.02	21.05.03	1,98
--7	    Paora	    0	    21.05.02	21.05.03	0,99
--8	    Arttu	    0	    21.05.02	21.05.03	1,98
--9	    Eriu	    0	    21.05.02	21.05.03	3,96
--10	Marlis	    0	    21.05.02	21.05.03	1,98

-- RF 10
-- Proponha um requisito relevante ainda por identificar e que requeira uma query 
-- simples para o satisfazer. Implemente

-- Visualizar amigos que foram aceites por um dado utilizador

select 
    fit_user_id,
    fit_user_id1 as fit_friend_id,
    accepted
from friends_list
where fit_user_id = 1
and accepted = 1;

--Fit_user_id   Fit_friend_id   accepted
--1	            2	            1
--1	            16	            1
--1	            28	            1

-- Outro possível seria visualizar a posição numa leaderboard por cada atividade 
-- em relação aos amigos aceites por um dado utilizador

select activities_template.name, friends_leaderboard.place 
from friends_leaderboard
left join activities_template 
on activities_template.id = friends_leaderboard.totals_activities_template_id
where totals_fit_user_id = 1
order by place;

--Name          Place
--Crab Walk	    1
--Crunches	    1
--High Knees	1
--Jogging	    1
--Wall Sit	    1
--Lunges	    1
--Squats	    1
--Wall Pushups	1
--Jumping Jacks	1

-- RF 11
-- Proponha um requisito relevante ainda por identificar e que requeira uma query 
-- com funções de agregação (sum, max, min, etc) para o satisfazer. Implemente.

-- sum() utilizado na function total_paid

select sum(value)
from (
    select value
    from transaction
    where t_date 
    between to_date('2021-04-28','YYYY-MM-DD') and to_date('2021-05-02','YYYY-MM-DD')+1
    and fit_user_id = 1
);

-- max() utilizado no trigger update_user_activity_trg

select max(t_date)
from ( 
    select tr_id, t_date 
    from transaction
    where fit_user_id = 1
);




