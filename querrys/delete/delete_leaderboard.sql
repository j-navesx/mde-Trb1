create or replace procedure create_leaderboard(
    ifit_user_id  INTEGER,
    iname         VARCHAR2,
    iplace        NUMBER,
    iexercise     VARCHAR2,
    ivalue        NUMBER
) as
begin
    insert into friends_leaderboard (
        fit_user_id,
        name,
        place,
        exercise,
        value
    )
    values (
        ifit_user_id,
        iname,
        iplace,
        iexercise,
        ivalue
    );
end;