drop database IF EXISTS `SQL-Training1`;
create database `SQL-Training1`;
use `SQL-Training1`;

-- Cau 1
create table `categories`(
	id bigint primary key auto_increment not null, 
    category_name varchar(50) not null, 
    created_at timestamp default current_timestamp not null, 
	updated_at timestamp default current_timestamp not null
);

create table `companies`(
	id bigint primary key auto_increment not null, 
    company_name varchar(50) not null, 
	company_code varchar(255) unique not null, 
    created_at timestamp default current_timestamp not null, 
	updated_at timestamp default current_timestamp not null
);

create table `users`(
	id bigint primary key auto_increment not null, 
    username varchar(16) unique not null, 
	email varchar(50) unique not null, 
    password varchar(10) not null, 
    birthday date, 
    image_url varchar(255), 
    role enum('user',  'admin') default('user') not null, 
    created_at timestamp default current_timestamp not null, 
	updated_at timestamp default current_timestamp not null
);

create table `projects`(
	id bigint primary key auto_increment not null, 
	category_id bigint not null , 
	company_id bigint not null, 
    project_name varchar(50) not null, 
	project_spend int , 
    project_variance int, 
    revenue_recognised int, 
    created_at timestamp default current_timestamp not null, 
	updated_at timestamp default current_timestamp not null, 
    FOREIGN KEY (category_id) REFERENCES categories(id), 
	FOREIGN KEY (company_id) REFERENCES companies(id)
);

create table `project_users`(
	id bigint primary key auto_increment not null, 
	project_id bigint not null , 
	user_id bigint not null, 
    created_at timestamp default current_timestamp not null, 
	updated_at timestamp default current_timestamp not null, 
    FOREIGN KEY (project_id) REFERENCES projects(id), 
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Cau 2
INSERT INTO `categories`(`category_name`) VALUES ('category1'),  ('category2'),  ('category3'),  ('category4'),  ('category5');
INSERT INTO `companies`(`company_name`, `company_code`) VALUES ('company1', 1),  ('company2', 2),  ('company3', 3),  ('company4', 4),  ('company5', 5);
INSERT INTO `users`(`username`, `email`, `password`, `role`) VALUES ('user1', 'user1@gmail.com', 'user1', 'user'),  
('user2', 'user2@gmail.com', 'user2', 'user'),  
('user3', 'user3@gmail.com', 'user3', 'user'),  
('user4', 'user4@gmail.com', 'user4', 'admin'),  
('user5', 'user5@gmail.com', 'user5', 'admin'), 
('user6', 'user6@gmail.com', 'user6', 'admin'), 
('user7', 'user7@gmail.com', 'user7', 'admin'), 
('user8', 'user8@gmail.com', 'user8', 'admin'), 
('user9', 'user9@gmail.com', 'user9', 'admin'), 
('user10', 'user10@gmail.com', 'user10', 'admin'), 
('user11', 'user11@gmail.com', 'user11', 'admin'), 
('user12', 'user12@gmail.com', 'user12', 'admin'), 
('user13', 'user13@gmail.com', 'user13', 'admin');


INSERT INTO `projects`(`category_id`, `company_id`, `project_name`,  `project_spend`,  `revenue_recognised`) VALUES (1, 1, 'project1', 100, 100),  
(2, 2, 'project2', 200, 100),  
(3, 3, 'project3', 300, 100),  
(4, 4, 'project4', 400, 100),  
(5, 5, 'project5', 500, 100), 
(5, 5, 'project6', 600, 100);

INSERT INTO `project_users`(`project_id`, `user_id`) VALUES (1, 1),  
(2, 2),  
(3, 3),  
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10), (4, 11), (4, 12), (4, 13), 
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), (5, 11);

-- Cau 3
select project_name,  project_spend,  project_variance,  revenue_recognised,  count(user_id) as userCount
from `projects` p inner join `project_users` pu on p.id = pu.project_id
group by p.id;

-- Cau 4
select  project_name
from `projects` p inner join `companies` co on p.company_id = co.id 
where co.company_name = 'monstar-lab';

-- Cau 5
select  company_name,  company_code
from `projects` p inner join `companies` co on p.company_id = co.id 
where p.project_spend > 100;

select distinct username,  email,  `password`,  birthday,  image_url,  `role`
from `projects` p inner join `project_users` pu on p.id = pu.project_id
				  inner join `users` u on u.id = pu.user_id;

-- Cau 6
select  project_name,  count(user_id) as userCount
from `projects` p inner join `project_users` pu on p.id = pu.project_id
				  inner join `users` u on u.id = pu.user_id
group by project_name
having userCount > 10
order by userCount asc;

-- Cau 7
SET SQL_SAFE_UPDATES = 0;
delete from `projects` p
where (select count(user_id) from `project_users` pu where pu.project_id = p.id) = 0;

-- Cau 8
select id,  project_name, revenue_recognised, project_spend,  if( revenue_recognised > project_spend,  'profit',  if(revenue_recognised = project_spend,  'break',  'loss')) as `revenue_status`
from `projects`;

-- Cau 9
select project_name,  sum(revenue_recognised),  month(updated_at) as `month` ,  year(updated_at) as `year`
from `projects`
group by `month`, `year`;



















    