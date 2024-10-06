CREATE TABLE employees_a  (employee_id int,employee_name varchar(15), email_id varchar(15) );
delete from employees_a;
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('101','Liam Alton', 'li.al@abc.com');
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('102','Josh Day', 'jo.da@abc.com');
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('103','Sean Mann', 'se.ma@abc.com'); 
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('104','Evan Blake', 'ev.bl@abc.com');
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('105','Toby Scott', 'jo.da@abc.com');
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('106','Anjali Chouhan', 'JO.DA@ABC.COM');
INSERT INTO employees_a (employee_id,employee_name, email_id) VALUES ('107','Ankit Bansal', 'AN.BA@ABC.COM');

ALTER TABLE employees_a
ALTER COLUMN email_id VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CS_AS;

with cte as(
select *, ascii(email_id) as ascii_email,
RANK() over(partition by email_id order by ascii(email_id) desc) as rn
from employees_a)
select employee_id, employee_name, email_id, ascii_email from cte where rn = 1

