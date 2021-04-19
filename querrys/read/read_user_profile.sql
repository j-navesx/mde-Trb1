create or replace procedure read_user_profile(
    uId INTEGER
)
is
    rName profile.name%TYPE;
    rWeight profile.weight%TYPE;
    rHeight profile.height%TYPE;
    rBday profile.bday%TYPE;
    rGender profile.gender%TYPE;
begin
    select name, weight, height, bday, gender
    into rName, rWeight, rHeight, rBday, rGender
        from profile
    where profile.fit_user_id = uId;
    
    dbms_output.put_line(
        rName ||' '|| rWeight ||' '|| rHeight ||' '|| rBday ||' '|| rGender
    );
end;