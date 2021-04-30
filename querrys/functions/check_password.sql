create or replace function check_password
  (user_name VARCHAR2, passin VARCHAR2)
  return INTEGER
  is
  table_pass VARCHAR2(64);
  user_id INTEGER;
  begin
    select id, password
      into user_id, table_pass
      from fit_user
    where fit_user.username = user_name;

    if table_pass = passin then
      return user_id;
    else
      return 0;
    end if;
  end;