--1
SELECT region_name, COUNT(employee_id) count_employees 
FROM regions r
        LEFT OUTER JOIN countries c ON (r.region_id = c.region_id)
        LEFT OUTER JOIN locations l ON (c.country_id = l.country_id)
        LEFT OUTER JOIN departments d ON (l.location_id = d.location_id)
        LEFT OUTER JOIN employees e ON (d.department_id = e.department_id)
GROUP BY region_name;
--2
SELECT first_name, last_name, department_name, job_id, street_address, country_name, region_name
FROM employees e
        LEFT OUTER JOIN departments d ON (e.department_id = d.department_id)
        LEFT OUTER JOIN locations l ON (d.location_id = l.location_id)
        LEFT OUTER JOIN countries c ON (l.country_id = c.country_id)
        LEFT OUTER JOIN regions r ON (c.region_id = r.region_id);
--3
SELECT man.first_name, COUNT(emp.employee_id)
FROM employees emp JOIN employees man ON (emp.manager_id = man.employee_id)
GROUP BY man.first_name
HAVING COUNT(emp.employee_id) > 6;

--4
SELECT department_name, COUNT(employee_id) count_employees
FROM employees JOIN departments USING(department_id)
GROUP BY (department_name)
HAVING COUNT(employee_id) >30;

--5
SELECT d.department_id, d.department_name, COUNT(e.employee_id)
FROM departments d LEFT OUTER JOIN employees e ON(e.department_id = d.department_id)
GROUP BY d.department_name, d.department_id
HAVING COUNT(e.employee_id) = 0;
--6
SELECT man.first_name manager, emp.first_name  employee, man.hire_date hire_manager, emp.hire_date hire_employee 
FROM employees emp JOIN employees man ON (emp.manager_id = man.employee_id)
WHERE TO_CHAR(man.hire_date, 'yyyy')= 2005 AND TO_CHAR(emp.hire_date, 'yyyy') < 2005; 
--7
SELECT country_name, region_name
FROM countries NATURAL JOIN regions;
--8
SELECT e.first_name,e.last_name,e.salary,j.min_salary
FROM employees  e, jobs j
WHERE e.job_id = j.job_id AND e.salary < j.min_salary+1000;
--9
SELECT DISTINCT first_name, last_name, country_name
FROM employees e FULL OUTER JOIN departments d ON (e.department_id = d.department_id)
                 FULL OUTER JOIN locations l ON (d.location_id = l.location_id)
                 FULL OUTER JOIN countries c ON (l.country_id = c.country_id)
ORDER BY first_name nulls last;

--10
SELECT first_name, last_name, country_name
FROM employees e, countries c;
--11
SELECT region_name, count(employee_id) count_employees 
FROM regions r, countries c, locations l,departments d, employees e 
WHERE r.region_id = c.region_id(+) AND c.country_id = l.country_id(+) 
AND l.location_id = d.location_id(+) AND d.department_id = e.department_id(+)
GROUP BY region_name;
--12
SELECT department_name, count(employee_id)
FROM employees e, departments d WHERE e.department_id(+) = d.department_id
GROUP BY department_name
HAVING COUNT(employee_id)=0;