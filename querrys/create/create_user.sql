
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
    
    insert into profile (name, weight, height, bday, gender)
    values (iname, iweight, iheight, ibday, igender);
end;