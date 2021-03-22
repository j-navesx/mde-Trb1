CREATE TABLE fUser(
    id integer,
    name varchar2(255),
    bday date,
    weight float(126),
    height float(126),
    premium number(1),
    pt_status number(1),
    active number(1)
);


/*
ALTER TABLE Fitness_User
ADD my_activities integer references activities_rel(id) 
ADD my_pt integer references pts_rel(id)
ADD my_transactions integer references transactions_rel(id);
*/

SELECT * FROM fUser;