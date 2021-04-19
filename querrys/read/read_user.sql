create or replace procedure read_user(
    uId INTEGER
)
is
    rUsername fit_user.username%TYPE;
    rEmail fit_user.email%TYPE;
    rPremium fit_user.premium%TYPE;
    rActive fit_user.active%TYPE;
    rPt fit_user.pt%TYPE;
    rUserPt fit_user.fit_user_id%TYPE;
begin
    select username, email, premium, active, pt, fit_user_id
    into rUsername, rEmail, rPremium, rActive, rPt, rUserPt
        from fit_user
    where fit_user.id = uId;
    
    dbms_output.put_line(
        rUsername ||' '|| rEmail ||' ' || rPremium ||' '|| rActive ||' '|| rPt ||' '|| rUserPt
    );
end;