-- Create users

call create_user ('Minecreeper', 'mde', 'gc.pombo@campus.fct.unl.pt', 'Guilherme', 61, 169, '2000-04-19', 'male');
call create_user ('Loukios', 'mde', 'Loukios@campus.fct.unl.pt', 'Loukios', 69, 175, '2000-01-01', 'male');
call create_user ('Duff', 'mde', 'Duff@campus.fct.unl.pt', 'Duff', 69, 175, '2000-01-01', 'male');
call create_user ('Constantin', 'mde', 'Constantin@campus.fct.unl.pt', 'Constantin', 69, 175, '2000-01-01', 'male');
call create_user ('Cirino', 'mde', 'Cirino@campus.fct.unl.pt', 'Cirino', 69, 175, '2000-01-01', 'male');
call create_user ('Yonah', 'mde', 'Yonah@campus.fct.unl.pt', 'Yonah', 69, 175, '2000-01-01', 'male');
call create_user ('Paora', 'mde', 'Paora@campus.fct.unl.pt', 'Paora', 69, 175, '2000-01-01', 'male');
call create_user ('Arttu', 'mde', 'Arttu@campus.fct.unl.pt', 'Arttu', 69, 175, '2000-01-01', 'male');
call create_user ('Eriu', 'mde', 'Eriu@campus.fct.unl.pt', 'Eriu', 69, 175, '2000-01-01', 'female');
call create_user ('Marlis', 'mde', 'Marlis@campus.fct.unl.pt', 'Marlis', 69, 175, '2000-01-01', 'female');
call create_user ('Meabh', 'mde', 'Meabh@campus.fct.unl.pt', 'Meabh', 69, 175, '2000-01-01', 'female');
call create_user ('Amabilia', 'mde', 'Amabilia@campus.fct.unl.pt', 'Amabilia', 69, 175, '2000-01-01', 'female');
call create_user ('Valkyrie', 'mde', 'Valkyrie@campus.fct.unl.pt', 'Valkyrie', 69, 175, '2000-01-01', 'female');
call create_user ('Drishti', 'mde', 'Drishti@campus.fct.unl.pt', 'Drishti', 69, 175, '2000-01-01', 'female');
call create_user ('Leanne', 'mde', 'Leanne@campus.fct.unl.pt', 'Leanne', 69, 175, '2000-01-01', 'female');
call create_user ('Sunitha', 'mde', 'Sunitha@campus.fct.unl.pt', 'Sunitha', 69, 175, '2000-01-01', 'female');
call create_user ('Tirta', 'mde', 'Tirta@campus.fct.unl.pt', 'Tirta', 69, 175, '2000-01-01', 'female');
call create_user ('Augusta', 'mde', 'Augusta@campus.fct.unl.pt', 'Augusta', 69, 175, '2000-01-01', 'female');
call create_user ('Katelyn', 'mde', 'Katelyn@campus.fct.unl.pt', 'Katelyn', 69, 175, '2000-01-01', 'female');
call create_user ('Nona', 'mde', 'Nona@campus.fct.unl.pt', 'Nona', 69, 175, '2000-01-01', 'female');
call create_user ('Aarti', 'mde', 'Aarti@campus.fct.unl.pt', 'Aarti', 69, 175, '2000-01-01', 'female');
call create_user ('Dominika', 'mde', 'Dominika@campus.fct.unl.pt', 'Dominika', 69, 175, '2000-01-01', 'female');
call create_user ('Helene', 'mde', 'Helene@campus.fct.unl.pt', 'Helene', 69, 175, '2000-01-01', 'female');
call create_user ('Danica', 'mde', 'Danica@campus.fct.unl.pt', 'Danica', 69, 175, '2000-01-01', 'female');
call create_user ('Italia', 'mde', 'Italia@campus.fct.unl.pt', 'Italia', 69, 175, '2000-01-01', 'female');
call create_user ('Laura', 'mde', 'Laura@campus.fct.unl.pt', 'Laura', 69, 175, '2000-01-01', 'female');
call create_user ('Narses', 'mde', 'Narses@campus.fct.unl.pt', 'Narses', 69, 175, '2000-01-01', 'male');
call create_user ('Colwyn', 'mde', 'Colwyn@campus.fct.unl.pt', 'Colwyn', 69, 175, '2000-01-01', 'male');
call create_user ('Suhail', 'mde', 'Suhail@campus.fct.unl.pt', 'Suhail', 69, 175, '2000-01-01', 'male');
call create_user ('Ajith', 'mde', 'Ajith@campus.fct.unl.pt', 'Ajith', 69, 175, '2000-01-01', 'male');
call create_user ('Buhle', 'mde', 'Buhle@campus.fct.unl.pt', 'Buhle', 69, 175, '2000-01-01', 'male');
call create_user ('Davit', 'mde', 'Davit@campus.fct.unl.pt', 'Davit', 69, 175, '2000-01-01', 'male');
call create_user ('Sander', 'mde', 'Sander@campus.fct.unl.pt', 'Sander', 69, 175, '2000-01-01', 'male');
call create_user ('Kumaran', 'mde', 'Kumaran@campus.fct.unl.pt', 'Kumaran', 69, 175, '2000-01-01', 'male');
call create_user ('Narayana', 'mde', 'Narayana@campus.fct.unl.pt', 'Narayana', 69, 175, '2000-01-01', 'male');

-- Create activities

call create_activities_template ('Squats', NULL, NULL, 8);
call create_activities_template ('Jumping Jacks', NULL, NULL, 16);
call create_activities_template ('Crab Walk', NULL, NULL, 10);
call create_activities_template ('Jogging', NULL, 60, NULL);
call create_activities_template ('Crunches', NULL, NULL, 6);
call create_activities_template ('Wall Pushups', NULL, NULL, 7);
call create_activities_template ('Lunges', NULL, NULL, 6);
call create_activities_template ('High Knees', NULL, NULL, 6);
call create_activities_template ('Wall Sit', NULL, NULL, TO_NUMBER('3.6', '9.99'));

-- Create friends

call create_friends ( 2, 7);
call create_friends ( 5, 4);
call create_friends ( 2, 26);
call create_friends ( 7, 3);
call create_friends ( 2, 5);
call create_friends ( 6, 16);
call create_friends ( 18, 21);
call create_friends ( 16, 1);
call create_friends ( 2, 1);
call create_friends ( 28, 1);
call create_friends ( 2, 12);
call create_friends ( 4, 3);
call create_friends ( 25, 6);
call create_friends ( 2, 8);
call create_friends ( 14, 19);
call create_friends ( 4, 17);
call create_friends ( 6, 23);
call create_friends ( 24, 12);
call create_friends ( 16, 11);

-- Create accept all invitations

call update_friends ( 7, 2);
call update_friends ( 4, 5);
call update_friends ( 26, 2);
call update_friends ( 3, 7);
call update_friends ( 5, 2);
call update_friends ( 16, 6);
call update_friends ( 21, 18);
call update_friends ( 1, 16);
call update_friends ( 1, 2);
call update_friends ( 1, 28);
call update_friends ( 12, 2);
call update_friends ( 3, 4);
call update_friends ( 6, 25);
call update_friends ( 8, 2);
call update_friends ( 19, 14);
call update_friends ( 17, 4);
call update_friends ( 23, 6);
call update_friends ( 12, 24);
call update_friends ( 11, 16);