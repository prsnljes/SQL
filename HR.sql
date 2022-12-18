//1 Get a list of all employees whose name length is more than 10 letters

SELECT * FROM employees WHERE LENGTH(first_name)>10;

//2 Get a list of all employees whose salary is a multiple of 1000

SELECT * FROM employees WHERE MOD(salary,1000) =0;

//3 Get the phone number and the first 3-digit number of the employee's phone number, if his number is presented in the format XXX.XXX.XXX

SELECT phone_number, SUBSTR(phone_number, 1,3) FROM employees WHERE phone_number LIKE('___.___.____');

//4  Get a list of all employees whose last letter in the name is 'm' and the length of the name is more than 5.

SELECT * FROM employees WHERE first_name LIKE('%m')AND LENGTH(first_name)>5;
SELECT * FROM employees WHERE SUBSTR(first_name, -1,1)='m' AND LENGTH(first_name)>5;

//5 Get the date next Friday.

SELECT NEXT_DAY(SYSDATE,5) FROM dual;

//6 Get a list of all employees who have been working in the company for more than 12 years and 6 months (150 months).

SELECT DISTINCT employees.employee_id,first_name,last_name FROM employees, job_history 
WHERE MONTHS_BETWEEN (SYSDATE, employees.hire_date)>150 AND employees.employee_id not like (SELECT job_history.employee_id FROM dual)
ORDER BY employee_id;

SELECT * FROM job_history;
SELECT * FROM employees;
SELECT DISTINCT employees.employee_id,first_name,last_name FROM employees 
WHERE MONTHS_BETWEEN (SYSDATE, employees.hire_date)>150
ORDER BY employee_id;


//7 Get the phone number by replacing all ' in the PHONE_NUMBER value.' on '-'

SELECT REPLACE(phone_number,'.','-') phone_number FROM employees;

//8 Get the name, email, job_id for all employees in the format STEVEN king Ad_Press

SELECT UPPER(first_name), lOWER(email), INITCAP(job_id) FROM employees;

//9 Get information about the employee's name and salary, without using the || symbol, in this form: Steven 24000

SELECT CONCAT(first_name,salary) "9" from employees;

//10 Get information about the employee's hiring date, the rounded hiring date to the month and the first day of the hiring year

SELECT employee_id, hire_date, ROUND(hire_date, 'MM') "ROUND_MONTH", ROUND(hire_date, 'YEAR') "ROUND_YEAR" 
from employees;


//11 Get information about the first and last names of all employees. The name must consist of 10 characters and if the length of the name is less than 10, then add up to 10 characters with the $ sign. The surname should consist of 15 characters and if the length of the surname is less than 15, then put as many characters before the surname! as much as necessary.

SELECT RPAD(first_name,10,'$')"RPAD", LPAD(last_name,15,'!') "LPAD" FROM employees;


//12 Get the employee's name and the position of the second letter ‘a’ in his name.

SELECT first_name, INSTR(first_name, 'a',1, 2) "second 'A' position" FROM employees;


//13 Display the text '!!!HELLO!! MY FRIEND!!!!!!!!' and the same text, but without the exclamation mark at the beginning and end of the text.

SELECT TRIM('!' FROM '!!!HELLO!! MY FRIEND!!!!!!!!') FROM dual;

//14 Get information about the employee's salary multiplied by the coefficient 3.1415 ,? rounded to an integer value of the increased salary, the whole number of thousands of the increased salary.

SELECT salary, salary*3.1415, ROUND(salary*3.1415) "RoundSalary", TRUNC(salary*3.1415, -3)/1000 as "RoundSalary2" FROM employees;


//15 Get information about the date of the employee's hiring, the date that was six months after the employee was hired, the date of the last day in the month of the employee's hiring.

SELECT hire_date, ADD_MONTHS(hire_date, 6) "HalfYear", LAST_DAY(hire_date) "LastDay" FROM employees;