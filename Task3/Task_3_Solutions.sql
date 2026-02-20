--Invalid tweets 

Select tweet_id 
from Tweets 
where LENGTH(content) > 15 ;


-- fix names in table 

select user_id , CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2, Length(name)))) As name
from users


-- Calculate special bonus

SELECT 
    employee_id, 
    CASE 
        WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary 
        ELSE 0 
    END AS bonus
FROM employees
order by employee_id;

-- patients with conditions 

select patient_id , patient_name , conditions
from patients
where conditions like "DIAB1%" 
or conditions like "% DIAB1%"


-- total time 

select event_day as day , emp_id , 
SUM(out_time - in_time) as total_time
from employees
group by event_day , emp_id

-- followers count 

select user_id , Count(follower_id) as followers_count 
from followers
group by user_id 
order by user_id


-- daily lead and partners 

select date_id , make_name ,
COUNT(DISTINCT lead_id) as unique_leads ,
COUNT(DISTINCT partner_id) as unique_partners 
from dailysales
group by date_id , make_name


-- actors and directors 

select actor_id , director_id 
from actordirector 
Group by actor_id , director_id
Having COUNT(timestamp)>= 3


-- classes 

select class 
from courses 
group by class
Having COUNT(student) >= 5

-- gameplay analysis 

select player_id , 
MIN(event_date) as first_login 
from activity 
group by player_id


-- capital gain loss

select stock_name , 
SUM(Case  when operation = "buy" then - price
 else price 
    end ) as capital_gain_loss
from stocks
group by stock_name

--second highest salary

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);