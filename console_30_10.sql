
--#1
select e1.id     as id,
       e1.name   as employee_name,
       e1.salary as employee_salary,
       e2.salary as chief_salary,
       d.name       department_name
from employee as e1
         left join employee e2
                   on e1.chief_id = e2.id
         left join department d
                   on e1.department_id = d.id
where e1.salary > e2.salary;


--#2
select *
from employee as e1
where e1.salary = (
    select max(salary)
    from employee as e2
    where e2.department_id = e1.department_id
);

--#3
select distinct d.id
from employee as e
         join department d
              on e.department_id = d.id
where (
          select count(department_id)
          from employee
          where department_id = d.id) <= 3;

--#4
select e1.*
from employee as e1
         left join employee as e2
                   on e1.chief_id = e2.id
where e1.department_id != e2.department_id;

--#5
with sum_of_salaries as (
    select sum(salary)   as sum,
             department_id as d_id
      from employee
      group by department_id)

select d_id
from sum_of_salaries
where sum = (
    select max(sum)
    from sum_of_salaries
);
