create or replace procedure create_user(
    iusername     VARCHAR2,
    ipassword     VARCHAR2,
    iemail        VARCHAR2,
    ipremium      NUMBER,
    iactive       NUMBER,
    ipt           NUMBER,
    ipt_id       INTEGER
) as
begin
    if ipt_id != null then
        insert into fit_user (username, password, email, premium, active, pt, fit_user_id)
        values (iusername,ipassword,iemail,ipremium,iactive,ipt,ipt_id);
        
        insert into profile (name, weight, height, bday, gender)
        values ('comrad',100,250,to_date('16/04/2000','DD/MM/YYYY'),'male');
    else
        insert into fit_user (username, password, email, premium, active, pt)
        values (iusername,ipassword,iemail,ipremium,iactive, ipt);
        
        insert into profile (name, weight, height, bday, gender)
        values ('comrad',100,250,to_date('16/04/2000','DD/MM/YYYY'),'male');
    end if;
end;