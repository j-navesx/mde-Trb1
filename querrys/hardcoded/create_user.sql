

insert into fit_user (username, password, email, premium, active, pt)
values ('comrad','russia','viktor@kgb.com',1,1,0);

insert into profile (name,weight,height,bday,gender) 
VALUES ('comrad',100,250,to_date('16/04/2000','DD/MM/YYYY'),'male');

insert into fit_user (username, password, email, premium, active, pt)
values ('comrad2','russia','viktor2@kgb.com',1,1,1);

insert into profile (name,weight,height,bday,gender) 
VALUES ('comrad2',100,250,to_date('16/04/2000','DD/MM/YYYY'),'male');

insert into fit_user (username, password, email, premium, active, pt, fit_user_id)
values ('comrad3','russia','viktor3@kgb.com',1,1,0,2);

insert into profile (name,weight,height,bday,gender) 
VALUES ('comrad3',100,250,to_date('16/04/2000','DD/MM/YYYY'),'male');

insert into fit_user (username, password, email, premium, active, pt, fit_user_id)
values ('comrad4','russia','viktor4@kgb.com',1,1,0,2);

insert into profile (name,weight,height,bday,gender) 
VALUES ('comrad4',100,250,to_date('16/04/2015','DD/MM/YYYY'),'male');

select * from fit_user;
select * from profile;

