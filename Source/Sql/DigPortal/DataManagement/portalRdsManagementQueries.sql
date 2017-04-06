

-- see email with all associated roles
select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and u.email like '%haroldduby%';


select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and u.email like '%hliu%';

select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and u.email like '%steiner%';
  
  
  
select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and u.email like '%jignesh%';
  
select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and u.email like '%yuksel%';
  
-- insert sysadmin role
insert into user_role values(3, 1422);


-- get role sfor user id
select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and ur.user_id = 1424;

insert into user_role values(2, 1424);

-- get list of admins
select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and ur.role_id = 3;
  
  
-- get list of admins not on Intel project  
select u.id, u.email, u.enabled, u.full_name, ro.id, ro.authority
from user u, user_role ur, role ro
where u.id = ur.user_id
  and ur.role_id = ro.id
  and ur.role_id = 3
  and u.id not in (1419, 1420, 1421, 1422, 16, 3);

-- delete all admins not on Intel project
delete from user_role where role_id = 3 and user_id not in (1419, 1420, 1421, 1422, 16, 3);

-- get sessions sorted by start date
select u.id, u.email, u.full_name, us.start_session
from user u, user_session us
where u.id = us.user_id
--    and us.start_session > (sysdate -1)
order by us.start_session;

