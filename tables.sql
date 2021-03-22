CREATE TABLE User(
    uuid primary key,
    name varchar2(255),
    bday date,
    weight float,
    height float,
    premium boolean,
    pt_status boolean,
    active boolean,
    my_activities foreign primary key, 
    my_pt foreign primary key,
    my_transactions foreign primary key
);