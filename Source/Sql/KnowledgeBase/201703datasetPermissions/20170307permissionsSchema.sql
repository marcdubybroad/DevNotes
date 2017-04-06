

-- drop all tables
drop table if exists kb_permission;
drop table if exists kb_user;
drop table if exists kb_role;
drop table if exists kb_user_role;
drop table if exists kb_user_dataset_permissions;



-- lookup tables
-- permissions table
create table kb_permission (
    permission_id bigint(20) not null primary key,
    web_name varchar(1000) not null,
    description varchar(4000));
    
-- insert permissions
insert into kb_permission (permission_id, web_name, description) values(1, 'Existence', 'Can see the existence but not access the dataset');
insert into kb_permission (permission_id, web_name, description) values(2, 'Read Access', 'General low level read permission');
insert into kb_permission (permission_id, web_name, description) values(3, 'Bulk Download', 'Access to bulk download the data');
insert into kb_permission (permission_id, web_name, description) values(4, 'REST Access', 'Programmatic access to the data set through the REST service');


-- user tables
create table kb_user (
    user_id bigint(20) not null primary key,
    email varchar(500) not null,
    web_name varchar(1000) not null,
    description varchar(4000),
    date_created timestamp,
    last_updated date
);

-- role table
create table kb_role (
    role_id bigint(20) not null primary key,
    web_name varchar(1000) not null,
    description varchar(4000),
    date_created timestamp,
    last_updated date
);


-- join tables
-- gtable to store user role links
create table kb_user_role(
    user_role_id bigint(20) not null primary key,
    user_id bigint(20) not null,
    role_id bigint(20) not null,
    date_created timestamp,
    last_updated date,
    foreign key (user_id) references kb_user(user_id),
    foreign key (role_id) references kb_role(role_id)
);

-- table to join role to permission to dataset
create table kb_user_dataset_permissions(
    upermission_id bigint(20) not null primary key,
    permission_id bigint(20) not null,
    role_id bigint(20) not null,
    dataset_id varchar(4000) not null,
    date_created timestamp,
    last_updated date,
    foreign key (permission_id) references kb_permission(permission_id),
    foreign key (role_id) references kb_role(role_id)
);




