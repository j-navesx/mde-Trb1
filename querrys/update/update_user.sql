create or replace procedure update_user(
    ifit_user_id  fit_user.id%type,
    ipassword     fit_user.password%type,
    ipremium      fit_user.premium%type,
    iactive       fit_user.active%type,
    ipt           fit_user.pt%type,
    ipt_id        fit_user.fit_user_id%type
) as
begin

    UPDATE fit_user
    SET
        password = ipassword,
        premium = ipremium,
        active = iactive,
        pt = ipt,
        fit_user_id = ipt_id
    WHERE
        id = ifit_user_id;
        
end;

select username, email, active, premium from fit_user;