use assignment_1;
select * from employee;
select * from project;

## Write a query to get all employee detail from "employee" table.
select * 
FROM employee
ORDER BY salary desc
LIMIT 1;

## Select only top 1 record from employee table


## Select only bottom 1 record from employee table
SELECT *
FROM employee
ORDER BY salary ASC
LIMIT 1;

## How to select a random record from a table?
SELECT *
FROM employee
ORDER BY RAND()
LIMIT 10;

## Write a query to get
#    (“first_name” in upper case as "first_name_upper"
#‘first_name’ in lower case as ‘first_name_lower”
#Create a new column “full_name” by combining “first_name” &
#“last_name” with space as a separator.
#Add 'Hello ' to first_name and display result.)##

SELECT 
    UPPER(first_name) AS first_name_upper,
    LOWER(first_name) AS first_name_lower,
    CONCAT(first_name, ' ', last_name) AS full_name,
    CONCAT('Hello ', first_name) AS greeting
FROM employee;


## 9. Select the employee details of
# Whose “first_name” is ‘Malli’
SELECT *
FROM employee
WHERE first_name = 'Malli';


# Whose “first_name” present in ("Malli","Meena", "Anjali")
SELECT *
FROM employee
WHERE first_name in ("Malli","meena","anjali");

# Whose “first_name” not present in ("Malli","Meena", "Anjali")
SELECT *
FROM employee
WHERE first_name not in ("Malli","meena","anjali");


##Whose “first_name” starts with “v”
SELECT *
FROM employee
WHERE first_name LIKE 'v%';

##Whose “first_name” ends with “i”
SELECT *
FROM employee
WHERE first_name LIKE '%i';

##Whose “first_name” contains “o”

SELECT *
FROM employee
WHERE first_name LIKE '%o%';

##Whose "first_name" start with any single character between 'm-v'
SELECT *
FROM employee
WHERE first_name LIKE '[m-v]%';


#Whose "first_name" not start with any single character between 'm-v'
SELECT *
FROM employee
WHERE first_name NOT REGEXP '^[m-vM-V]';

# Whose "first_name" start with 'M' and contain 5 letters
SELECT *
FROM employee
WHERE first_name LIKE 'M____';


## Write a query to get all unique values of"department" from the employee table.
SELECT DISTINCT department
FROM employee;

## Query to check the total records present in a table.

SELECT COUNT(*) AS total_records
FROM employee;

## Write down the query to print first letter of a Name in Upper Case and all other
   ##letter in Lower Case.(EmployDetail table)
   
SELECT 
    CONCAT(
        UPPER(LEFT(first_Name, 1)), 
        LOWER(SUBSTRING(first_Name, 2))
    ) AS formatted_name
FROM Employee;

##Write down the query to display all employee name in one cell separated by ','
   #ex:-"Vikas, nikita, Ashish, Nikhil , anish"(EmployDetail table)

SELECT GROUP_CONCAT(first_Name SEPARATOR ', ') AS EmployeeNames
FROM Employee;


#4. Query to get the below values of "salary" from employee table
# Lowest salary
#Highest salary
#average salary
#Highest salary - Lowest salary as diff_salary
SELECT 
    MIN(salary) AS Lowest_Salary,
    MAX(salary) AS Highest_Salary,
    AVG(salary) AS Average_Salary,
    MAX(salary) - MIN(salary) AS Diff_Salary
FROM employee;

#   % of difference between Highest salary and lowest salary. (sample output  format: 10.5%)                   


SELECT 
    CAST( 
        ( (MAX(salary) - MIN(salary)) * 100.0 / MAX(salary) ) 
        AS DECIMAL(5,1)
    )  AS Diff_Percentage
FROM employee;

# Select “first_name” from the employee table after removing white spaces from
 
# Right side spaces
SELECT RTRIM(first_name) AS first_name_trimmed
FROM employee;

#ledt side spaces
SELECT LTRIM(first_name) AS first_name_trimmed
FROM employee;

# Both right & left side spaces
SELECT LTRIM(RTRIM(first_name)) AS first_name_trimmed
FROM employee;

# Query to check no.of records present in a table where employees having 50k salary.
SELECT COUNT(*) AS No_of_Employees
FROM employee
WHERE salary = 50000;

#Find the most recently hired employee in each department
SELECT department,first_name, joining_date 
FROM employee
GROUP BY 1,2,3
having joining_date=max(joining_date);

# Display first_name and gender as M/F.(if male then M, if Female then F) 1.
 select first_name,
  case
 when gender= 'male' then 'M'
 else 'F'
 end as gender_short
 from employee;

 #Display first_name, salary, and a salary category. (If salary is below 50,000, categorize as 'Low'; between 50,000 and 60,000 as 'Medium'; above 60,000 as 'High')
 
 select first_name,salary,
 case
 when salary <50000 then"low"
 when salary between 50000 and 60000 then "medium"
 else "high"
 end as salary_category
 from employee;
 
 
 
 #Display first_name, department, and a department classification. (If department is      'IT', display 'Technical'; if 'HR', display 'Human Resources'; if 'Finance', display
 #'Accounting'; otherwise, display 'Other'
 
 select first_name,department,
 case
 when department='IT' then 'Technical'
 when department= 'HR' then 'Human Resources'
 when department ='Finance' then 'Accounting'
 else 'other'
 end as department_classification
 from employee;
 
 
 # Display first_name, salary, and eligibility for a salary raise. (If salary is less than 50,000, mark as 'Eligible for Raise'; otherwise, 'Not Eligible'
 select first_name,salary,
 case
 when salary < 50000 then 'Eligible for Rise'
 else 'Not eligible'
 end as eligibilty_Salary_Rise
 from employee;
  
 # 4 Display first_name, joining_date, and employment status. (If joining date is before
 #'2022-01-01', mark as 'Experienced'; otherwise, 'New Hire')
 
 select first_name, joining_date,
 case
 when joining_date <'2022-01-01' then 'Experienced'
 else'New hire'
 end as Employment_status
 from employee;
 
 # Display first_name, salary, and bonus amount. (If salary is above 60,000, add10%
 # bonus; if between 50,000 and 60,000, add 7%; otherwise, 5%)
 
 select first_name,salary,
 case
 when salary > 60000 then  salary*0.10
 when salary between 50000 and 60000 then salary*0.07
 else salary*0.05
 end as bonus_amount
 from employee;
 
# 7 Display first_name, salary, and seniority level
# If salary is greater than 60,000, classify as 'Senior'; between 50,000 and 60,000 as'Mid-Level'; below 50,000 as 'Junior')
 
 select first_name,salary,
 case
 when salary >60000 then 'Senior'
 when salary between 50000 and 60000 then 'Mid-level'
 else 'junior'
 end as seniority_level
 from employee;
 
 
 #  Display first_name, department, and job level for IT employees. (If department is 'IT'
 # and salary is greater than 55,000, mark as 'Senior IT Employee'; otherwise, 'Other')
 
 select first_name,department,
 case 
 when department='IT' and salary > 55000 then 'Senior IT Employee'
 else 'Other'
 end as job_level_IT_employees
 from employee;
 
 
 
# Display first_name, joining_date, and recent joiner status. (If an employee joined
 # after '2024-01-01', label as 'Recent Joiner'; otherwise, 'Long-Term Employee' 
 
 select first_name,joining_date,
 case
 when joining_date > '2024-01-01' then 'Recent joiner'
 else 'Long-Term Employee'
 end as Recent_joiner_Status
 from employee;
 
  #13. Display first_name, joining_date, and leave entitlement. (If joined before '2021-01
   #    01', assign '10 Days Leave'; between '2021-01-01' and '2023-01-01', assign '20 Days
    #   Leave'; otherwise, '25 Days Leave'
   
   select first_name,joining_date,
    case
    when joining_date < '2021-01-01' then '10 Days Leave'
    when joining_date between '2021-01-01' and '2023-01-01' then '20 Days Leave'
    else '25 Days Leave'
    end as Leave_entitlement
    from employee;
    
    
   ## 14. Display first_name, salary, department, and promotion eligibility. (If salary is above
     # 60,000 and department is 'IT', mark as 'Promotion Eligible'; otherwise, 'Not Eligible'
    
    select first_name, salary,department,
    case
    when salary > 60000 and department ='IT' then 'Promotion Eligible'
    else'Not Eligible'
    end as Promotion_Eligibility
    from employee;
    
     #15. Display first_name, salary, and overtime pay eligibility. (If salary is below 50,000,
      # mark as 'Eligible for Overtime Pay'; otherwise, 'Not Eligible'
     
     select first_name, salary,
     case
     when salary <50000 then 'Eligible for Overpay'
     else 'Not Eligible'
     end as Overtime_pay_Eligiblity
     from employee ;
     
     # 16. Display first_name, department, salary, and job title. (If department is 'HR' and salary
      # is above 60,000, mark as 'HR Executive'; if department is 'Finance' and salary is above
      # 55,000, mark as 'Finance Manager'; otherwise, 'Regular Employee')
    
    select first_name,department,salary,
     case
     when department ='HR' and salary >60000 then 'HR Executive'
     when department ='Finance' and salary>55000 then 'Finance Manager'
     else 'Regular Employee'
     end as Job_Title
     from employee;
     
    # 17. Display first_name, salary, and salary comparison to the company average. (If salary is 
     # above the company’s average salary, mark as 'Above Average'; otherwise, 'Below Average')
     
     select first_name,salary,
     case
     when salary > (select avg(salary) from employee) then 'Above Average'
     else 'Below Average'
     end as Salary_comparison_comp_avg
     from employee;
     
     
  #Write the query to get the department and department wise total(sum) salary, display it in ascending and descending order according to salary.  
 
 select department,sum(salary) as total_salary from employee
  group by department
  order by total_salary asc ;
  
    select department,sum(salary) as total_salary from employee
  group by department
  order by total_salary desc;
  
  #  Write down the query to fetch Project name assign to more than one Employee 2.
  
  SELECT project_name, COUNT(*) AS employee_count
FROM Project
GROUP BY project_name
HAVING COUNT(*) > 1;



#Write the query to get the department, total no. of departments, total(sum) salary with respect to department from "employee table" table. 

select department, count(department),sum(salary) as total_salary  from employee
group by department;

#Get the department-wise salary details from the "employee table" table: 4.
 # What is the average salary? (Order by salary ascending)
 # What is the maximum salary? (Order by salary ascending

select department, avg(salary) as avg_salary from employee
group by department
order by avg_salary asc;

select department, max(salary) as max_salary from employee
group by department
order by max_salary asc ;
 
# Display department-wise employee count and categorize based on size. (If a department
  #   has more than 5 employees, label it as 'Large'; between 3 and 5 as 'Medium'; otherwise,'Small')
 
 select * from employee;
    select department , count(employee_id) as employee_count, 
    case 
    when count(employee_id) > 5 then 'large'
    when count(employee_id) between 3 and 5 then 'Medium'
    else 'Small'
    end as department_size
    from employee
    group by department;
    
    # Display department-wise average salary and classify pay levels. (If the average salary in a
    # department is above 60,000, label it as 'High Pay'; between 50,000 and 60,000 as 'Medium Pay'; otherwise, 'Low Pay').
    
     select department, avg(salary) as avg_salary , 
     case
     when avg(salary) > 60000 then 'High Pay'
     when avg(salary)  between 50000 and 60000 then 'Medium Pay'
     else 'Low pay'
     end as pay_Levels
     from employee
     group by department;
     
    # 7. Display department, gender, and count of employees in each category. (Group by department and gender, showing total employees in each combination)
    
    SELECT 
    department AS Department,
    gender,
    COUNT(*) AS Total_Employees
FROM employee
GROUP BY department, gender
ORDER BY department, gender;

    
    # 8. Display the number of employees who joined each year and categorize hiring trends. (If a
    # year had more than 5 hires, mark as 'High Hiring'; 3 to 5 as 'Moderate Hiring'; otherwise,'Low Hiring'
    
    select year(joining_date) as join_year,count(emp_id) as join_count,
    case
    when count(emp_id) >5 then 'High Hiring'
    when count(emp_id) between 3 and 5 then 'Moderate Hiring'
    else 'Low Hiring'
    end as hiring_trend
    from employee
    group by year(joining_date) 
    order by join_year;
    select * from employee;
    
    # Display department-wise highest salary and classify senior roles. (If the highest salary in a
    # department is above 70,000, label as 'Senior Leadership'; otherwise, 'Mid-Level')
    
    select department,max(salary) as highest_salary,
    case
    when (select department from employee where salary > 70000) then 'Senior Leadership'
    else 'Mid-Level'
    end as senior_roles
    from employee
    group by department;
    
  #  Display department-wise count of employees earning more than 60,000. (Group
     #  employees by department and count those earning above 60,000, labeling departments with more than 2 such employees as 'High-Paying Team')  
  
  select   department ,count(emp_id) as employee_cnt,
  case
  when count(emp_id) >2 then 'High PayingTeam'
  else 'Normal Paying Team'
  end as team_category
  from employee
  where salary > 60000
  group by department;
  
  
  
  # Query to extract the below things from joining_date column. (Year, Month, Day, CurrentDate) 
  
    select joining_date,
    year(joining_date) as joining_year,
    month(joining_date) as joining_month,
    day(joining_date) as joining_day,
    current_date() as cur_date
    from employee;
    
   # Create two new columns that calculate the difference between joining_date and the
 #   current date. One column should show the difference in months, and the other should show the difference in days
 
 select joining_date,
 timestampdiff(month,joining_date,curdate()) as diff_in_months,
 datediff(curdate() , joining_date) as diff_in_days
 from employee;
 
   # Get all employee details from the employee table whose joining year is 2020 
   
   select first_name, emp_id  from employee
   where year(joining_date)=2020;
   select * from employee;
   select first_name,emp_id from employee
   where month(joining_date)= 02;
   describe employee;
    
    # Get all employee details from employee table whose joining date between "2021-01-01 0and "2021-12-01"
   
   select * from employee
    where joining_date between "2021-01-01"and "2021-12-01";
    
    #Get all employee details from the employee table whose joining month is Feb
   
   SELECT *
FROM employee
WHERE MONTH(joining_date) = 2;

    
    
 # Get the employee name and project name from the "employee table" and "ProjectDetail" for employees who have been assigned a project, sorted by first name  
    
    select * from  project;
   select first_name,project_name 
   from employee  as e inner join project as p
   on e.employee_id=p.emp_id_no
   order by first_name;
   
# Get the employee name and project name from the "employee table" and
 #"ProjectDetail" for all employees, including those who have not been assigned a project,sorted by first name.
 
 select * from employee;
 select first_name as employee_name,project_name 
 from employee as e left join project as p 
 on e.employee_id=p.emp_id_no
 order by  first_name;
 
  # Get the employee name and project name from the "employee table" and
 #"ProjectDetail" for all employees. If an employee has no assigned project, display "-N0 Project Assigned," sorted by first name
 
 select first_name as employee_name,
 case
 when p.project_name is null then 'NO Project is assigned'
 else p.project_name
 end as project_name
 from employee e left join project p
 on e.emp_id=p.emp_id_no
 order by e.first_name;
 
 # Get all project names from the "ProjectDetail" table, even if they are not linked to any
 # employee, sorted by first name from the "employee table" and "ProjectDetail" table.
 
 select e.first_name,p.project_name
 from employee as e left join project as p
 on e.emp_id=p.emp_id_no
 union
 select e.first_name,p.project_name
 from employee as e right join project as p
 on e.emp_id=p.emp_id_no
 order by  first_name, project_name;
 
 # Find the project names from the "ProjectDetail" table that have not been assigned to any employee using the "employee table" and "ProjectDetail" table.
 select * from project;
  select * from employee;

 select p.project_name from project p left join employee e
 on p.emp_id_no=e.emp_id where e.emp_id is null;
 
 # 6.Get the employee name and project name for employees who are assigned to more than one project.

SELECT 
    CONCAT(first_name, ' ', last_name) AS employee_name,
    COUNT(project_name)
FROM
    employee e
        LEFT JOIN
    project p ON e.emp_id = p.emp_id_no
GROUP BY employee_name
HAVING COUNT(project_name) > 1;
 
 # Get the project name and the employee names of employees working on projects that have more than one employee assigned
 SELECT 
    p.project_name,
    e.emp_id_no
FROM project e
JOIN (
    SELECT project_name
    FROM project
    GROUP BY project_name
    HAVING COUNT(*) > 1
) p 
  ON e.project_name = p.project_name
ORDER BY p.project_name, e.emp_id_no;



        
 # Get records from the "ProjectDetail" table where the corresponding employee ID does not exist in the "employee table."
 
 select p.* from project p left join employee e 
 on p.emp_id_no=e.emp_id where e.emp_id is  null;

 # Get all project names from the "ProjectDetail" table, even if they are not linked to any employee, sorted by first name from the "employee table" and "ProjectDetail" table
 
 select p.project_name,e.first_name from project p left join employee e 
 on p.emp_id_no=e.emp_id order by e.first_name;
 
##Find the project names from the "ProjectDetail" table that have not been assigned to any employee using the "employee table" and "ProjectDetail" table. 
 
 select project_name from project p left join employee e
 on p.emp_id_no=e.emp_id where emp_id is  null;
 