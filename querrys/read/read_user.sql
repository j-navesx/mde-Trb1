create or replace procedure create_user(
    iusername VARCHAR2
    ipassword VARCHAR2
    iemail VARCHAR2
    ipremium CHAR
    iactive CHAR
    ipt CHAR
    ipt_id INTEGER
) is 
    fit_user.username%ROWTYPE, 
    fit_user.password%ROWTYPE,
    fit_user.email%ROWTYPE,
    fit_user.premium%ROWTYPE,
    fit_user.active%ROWTYPE,
    fit_user.pt%ROWTYPE,
    fit_user.my_pt%ROWTYPE;
begin
    if my_pt != null then
        insert into fit_user (username, password, email, premium, active, pt, fit_user_id)
        values (iusername,ipassword,iemail,ipremium,iactive,ipt,ipt_id);
    else
        insert into fit_user (username, password, email, premium, active, pt)
        values (iusername,ipassword,iemail,ipremium,iactive);
    end if;
    
end;