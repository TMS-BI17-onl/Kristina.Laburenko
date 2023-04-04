Task 1 
SELECT EM2.FIRST_NAME, EM2.LAST_NAME, COUNT(E1.MANAGER_ID) AS cnt
FROM EMPLOYEES EM1 LEFT JOIN EMPLOYEES EM2 
                   ON EM1.MANAGER_ID = EM2.EMPLOYEE_ID
GROUP BY EM2.FIRST_NAME, EM2.LAST_NAME
HAVING COUNT(EM2.MANAGER_ID) > 6

Task 2
SELECT d.DEPARTMENT_NAME, MIN (e.SALARY*(1-e.COMISSION_PCT*0,01)) AS min_s, MAX(e.SALARY*(1-e.COMISSION_PCT*0,01)) AS max_s
FROM DEPARTMENTS d JOIN EMPLOYEES e 
                   ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_NAME

Task 3 
SELECT TOP 1 WITH TIES r.REGION_NAME 
FROM 
(
SELECT r.REGION_NAME, COUNT(e.Employee_ID) AS cntEMP
FROM REGIONS r JOIN COUNTRIES c ON r.REGION_ID = c.REGION_ID
		       JOIN LOCATIONS l ON c.COUNTRY_ID = l.COUNTRY_ID
		       JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID
		       JOIN EMPLOYEES e ON d.MANAGER_ID = e.EMPLOYEE_ID
GROUP BY r.REGION_NAME
)
ORDER BY cntEMP DESC

TASK 4
SELECT dep.DEPARTMENT_NAME, ((AVG(e.SALARY) OVER (PARTITION BY dep.DEPARTMENT_NAME))/(AVG(e.SALARY) OVER ())) * 100 AS 'diff, %'
FROM DEPARTMENTS d JOIN EMPLOYEES e ON dep.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_NAME

TASK 5.
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME
FROM EMPLOYEES e JOIN JOB_HISTORY h ON e.EMPLOYEE_ID=h.EMPLOYEE_ID 
				 JOIN DEPARTMENTS d ON h.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE DATEDIFF (YEAR, HIRE_DATE, GETDATE()) > 10

TASK 6
SELECT FIRST_NAME, LAST_NAME
FROM(
SELECT FIRST_NAME, LAST_NAME, RANK () OVER (ORDER BY Salary DESC) AS RNK
FROM EMPLOYEES
) RNK1
WHERE RNK BETWEEN 5 AND 10