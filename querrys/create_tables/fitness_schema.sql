-- Generated by Oracle SQL Developer Data Modeler 20.4.1.406.0906
--   at:        2021-04-24 13:27:53 BST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE activities_template (
    id             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    name           VARCHAR2(64) NOT NULL,
    cal_step_mult  NUMBER(5, 2),
    cal_dist_mutl  NUMBER(5, 2),
    cal_time_mult  NUMBER(5, 2)
)
LOGGING;

ALTER TABLE activities_template ADD CONSTRAINT activities_template_pk PRIMARY KEY ( id );

ALTER TABLE activities_template ADD CONSTRAINT activities_template__un UNIQUE ( name );

CREATE TABLE daily_goals (
    fit_user_id  INTEGER NOT NULL,
    daily_steps  NUMBER(7, 2) DEFAULT 0,
    daily_cals   NUMBER(7, 2) DEFAULT 0
)
LOGGING;

ALTER TABLE daily_goals ADD CONSTRAINT daily_goals_pk PRIMARY KEY ( fit_user_id );

CREATE TABLE daily_status (
    daily_id     INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    fit_user_id  INTEGER NOT NULL,
    distance     NUMBER(7, 2) NOT NULL,
    steps        NUMBER(7, 2) NOT NULL,
    weigth       NUMBER(5, 2) NOT NULL,
    calories     NUMBER(7, 2) NOT NULL,
    completed    NUMBER(1) DEFAULT 0 NOT NULL
)
LOGGING;

ALTER TABLE daily_status ADD CONSTRAINT daily_status_pk PRIMARY KEY ( daily_id );

CREATE TABLE exercises (
    ex_id                   INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    activities_template_id  INTEGER NOT NULL,
    fit_user_id             INTEGER NOT NULL,
    duration                DATE,
    steps                   NUMBER(7, 2),
    distance                NUMBER(7, 2),
    calories                NUMBER(7, 2),
    begin_date              TIMESTAMP WITH LOCAL TIME ZONE,
    end_date                TIMESTAMP WITH LOCAL TIME ZONE
)
LOGGING;

ALTER TABLE exercises ADD CONSTRAINT exercises_pk PRIMARY KEY ( ex_id );

CREATE TABLE fit_user (
    id           INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    username     VARCHAR2(64) NOT NULL,
    password     VARCHAR2(64) NOT NULL,
    email        VARCHAR2(128) NOT NULL,
    premium      NUMBER,
    active       NUMBER,
    pt           NUMBER,
    fit_user_id  INTEGER
)
LOGGING;

ALTER TABLE fit_user ADD CONSTRAINT user_pk PRIMARY KEY ( id );

ALTER TABLE fit_user ADD CONSTRAINT fit_user__un UNIQUE ( username );

CREATE TABLE friends_leaderboard (
    id                             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    totals_fit_user_id             INTEGER NOT NULL,
    totals_activities_template_id  INTEGER NOT NULL,
    place                          NUMBER(7)
)
LOGGING;

CREATE UNIQUE INDEX friends_leaderboard__idx ON
    friends_leaderboard (
        totals_fit_user_id
    ASC,
        totals_activities_template_id
    ASC )
        LOGGING;

ALTER TABLE friends_leaderboard ADD CONSTRAINT friends_leaderboard_pk PRIMARY KEY ( id );

CREATE TABLE friends_list (
    fit_user_id    INTEGER NOT NULL,
    fit_friend_id  INTEGER NOT NULL,
    accepted       NUMBER(1)
)
LOGGING;

--CREATE UNIQUE INDEX friends_list__idx ON
--    friends_list (
--        fit_user_id
--    ASC )
--        LOGGING;
--
--CREATE UNIQUE INDEX friends_list__idxv1 ON
--    friends_list (
--        fit_friend_id
--    ASC )
--        LOGGING;
--
ALTER TABLE friends_list ADD CONSTRAINT friends_list_pk PRIMARY KEY ( fit_friend_id,
                                                                      fit_user_id );

CREATE TABLE notice (
    n_id             INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    exercises_ex_id  INTEGER NOT NULL,
    fit_user_id      INTEGER NOT NULL,
    date_hour        TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    title            VARCHAR2(64) NOT NULL,
    description      VARCHAR2(128) NOT NULL,
    brief            VARCHAR2(64) NOT NULL
)
LOGGING;

ALTER TABLE notice ADD CONSTRAINT notice_pk PRIMARY KEY ( n_id );

CREATE TABLE profile (
    fit_user_id  INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    name         VARCHAR2(128) NOT NULL,
    weight       NUMBER(5, 2),
    height       NUMBER(5, 2),
    bday         DATE NOT NULL,
    gender       VARCHAR2(64)
)
LOGGING;

ALTER TABLE profile ADD CONSTRAINT profile_pk PRIMARY KEY ( fit_user_id );

CREATE TABLE totals (
    fit_user_id             INTEGER NOT NULL,
    activities_template_id  INTEGER NOT NULL,
    distance                NUMBER(7, 2),
    calories                NUMBER(7, 2)
)
LOGGING;

ALTER TABLE totals ADD CONSTRAINT totals_pk PRIMARY KEY ( fit_user_id,
                                                          activities_template_id );

CREATE TABLE transaction (
    tr_id        INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    fit_user_id  INTEGER NOT NULL,
    value        NUMBER(4, 2) NOT NULL,
    t_date       TIMESTAMP WITH LOCAL TIME ZONE NOT NULL
)
LOGGING;

ALTER TABLE transaction ADD CONSTRAINT transaction_pk PRIMARY KEY ( tr_id );

CREATE TABLE user_activity (
    id           INTEGER
        GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 NOCACHE ORDER )
    NOT NULL,
    fit_user_id  INTEGER NOT NULL,
    act_date     DATE,
    begin_date   TIMESTAMP WITH LOCAL TIME ZONE,
    end_date     TIMESTAMP WITH LOCAL TIME ZONE,
    paid         NUMBER(1)
)
LOGGING;

ALTER TABLE user_activity ADD CONSTRAINT user_activity_pk PRIMARY KEY ( id );

ALTER TABLE daily_goals
    ADD CONSTRAINT daily_goals_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE daily_status
    ADD CONSTRAINT daily_status_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE exercises
    ADD CONSTRAINT exercises_act_fk FOREIGN KEY ( activities_template_id )
        REFERENCES activities_template ( id )
    NOT DEFERRABLE;

ALTER TABLE exercises
    ADD CONSTRAINT exercises_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE friends_leaderboard
    ADD CONSTRAINT f_lb_totals_fk FOREIGN KEY ( totals_fit_user_id,
                                                totals_activities_template_id )
        REFERENCES totals ( fit_user_id,
                            activities_template_id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE fit_user
    ADD CONSTRAINT fit_user_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
    NOT DEFERRABLE;

ALTER TABLE friends_list
    ADD CONSTRAINT friends_list_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE friends_list
    ADD CONSTRAINT friends_list_fit_user_fkv2 FOREIGN KEY ( fit_friend_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE notice
    ADD CONSTRAINT notice_exercises_fk FOREIGN KEY ( exercises_ex_id )
        REFERENCES exercises ( ex_id )
    NOT DEFERRABLE;

ALTER TABLE notice
    ADD CONSTRAINT notice_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE profile
    ADD CONSTRAINT profile_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE totals
    ADD CONSTRAINT totals_act_fk FOREIGN KEY ( activities_template_id )
        REFERENCES activities_template ( id )
    NOT DEFERRABLE;

ALTER TABLE totals
    ADD CONSTRAINT totals_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE transaction
    ADD CONSTRAINT transaction_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE user_activity
    ADD CONSTRAINT user_activity_fit_user_fk FOREIGN KEY ( fit_user_id )
        REFERENCES fit_user ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             3
-- ALTER TABLE                             29
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
