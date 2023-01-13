--Window functions
-- Ranking functions
select
    first_name, last_name,  job_id, salary,
    row_number() over (partition by job_id order by salary) as order_salary
from
    employees;
    
select
    first_name, last_name,  job_id, salary,
    row_number() over (partition by job_id order by salary) as fn_row_number,
    rank() over (partition by job_id order by salary) as fn_rank
from
    employees;

select
    first_name, last_name,  job_id, salary,
    row_number() over (partition by job_id order by salary) as fn_row_number,
    rank() over (partition by job_id order by salary) as fn_rank,
    dense_rank() over (partition by job_id order by salary) as fn_dense
from
    employees;

select 
    first_name, last_name ,job_id, salary,
    ntile(10) over (partition by job_id order by salary) as fn_ntile
from
    (
        select * from employees
        where salary between 6000 and 7300
        and job_id = 'SA_REP'
    );
-- Analytic functions
select
    first_name, last_name, salary, job_id,
    first_value(first_name || ' ' || last_name) 
        over (partition by job_id order by salary desc) highest_salary,
    last_value(first_name || ' ' || last_name)
        over (partition by job_id order by salary desc
        rows between unbounded preceding and unbounded following) lowest_salary
from
    employees
        where job_id in ('FI_ACCOUNT','IT_PROG','PU_CLERK');
       
select
    first_name, last_name, salary, job_id,
    nth_value(first_name || ' ' || last_name, 2) 
        over (partition by job_id order by salary desc
        rows between unbounded preceding and unbounded following) highest_salary
from
    employees
        where job_id in ('FI_ACCOUNT','IT_PROG','PU_CLERK'); 
select
    distinct job_id,
    nth_value(salary, 3) 
        over (partition by job_id order by salary desc
        rows between unbounded preceding and unbounded following) highest_salary
from
    employees
        where job_id in ('FI_ACCOUNT','IT_PROG','PU_CLERK'); 
select
    employee_id, first_name, last_name, job_id, salary,
    lag(first_name, 1,'-') 
        over (partition by job_id order by salary) fn_lag,
    lead(first_name, 2,'-') 
        over (partition by job_id order by salary) fn_lead   
from
    employees
        where job_id in ('FI_ACCOUNT','IT_PROG','PU_CLERK'); 

select
    employee_id, first_name, last_name, job_id, salary,
    ratio_to_report(salary) 
        over (partition by job_id) fn_ratio_to_report
from
    employees
        where job_id in ('FI_ACCOUNT','IT_PROG','PU_CLERK'); 
        
-- Aggregate functions    
select
    employee_id, first_name, last_name, job_id, salary,
    max(salary) over (partition by job_id) as max_salary
from 
    employees;
select
    employee_id, first_name, last_name, job_id, salary,
    max(salary) over (partition by job_id) as max_salary,
    sum(salary) over (partition by job_id) as sum,
    round(ratio_to_report(salary) over (partition by job_id),4) as report
from
    employees;
    
select
    employee_id, first_name, last_name, job_id, salary,
    round(salary/sum(salary) over (partition by job_id),3) as sum
from
    employees;
    
select
    e.employee_id, e.first_name, e.last_name, e.job_id, e.salary, d.department_name, 
    round(salary/sum(salary) over (partition by d.department_name),3) as part,
    round(ratio_to_report(salary) over (partition by d.department_name),3) as report
from
    employees e 
    left join departments d on (e.department_id = d.department_id);
    
    
    



