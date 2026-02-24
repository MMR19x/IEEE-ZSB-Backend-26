-- Combine Two Tables

select firstName , lastName , city , state 
from Person P left join Address a
on P.personId = a.personId

-- Replace Employee ID With The Unique Identifier

select unique_id, name 
from Employees E left join EmployeeUNI U
on E.id = U.id

-- Customer Who Visited but Did Not Make Any Transactions

select customer_id, COUNT(v.visit_id) as count_no_trans
from Visits v left join Transactions t 
on v.visit_id = t.visit_id
where t.transaction_id is null
GROUP BY v.customer_id;

-- Project Employees I

select p.project_id, ROUND(AVG(e.experience_years),2) as average_years
from Project p join Employee e 
on p.employee_id = e.employee_id
group by project_id

-- Sales Person

elect p.name
FROM SalesPerson p
where sales_id NOT IN (
    select o.sales_id
    from Orders o
    join Company c on o.com_id = c.com_id
    where c.name = 'RED'
)

-- Rising Temperature

select w1.id
from Weather w1
join Weather w2 
  on DATEDIFF(w1.recordDate, w2.recordDate) = 1
where w1.temperature > w2.temperature;

--Average Time of Process per Machine

select machine_id , 
ROUND(SUM(case  when activity_type = "start" then - timestamp
     else timestamp end) / COUNT(DISTINCT process_id) ,3) as processing_time 
from Activity 
group by machine_id   

-- Students and Examinations

select s.student_id , s.student_name , j.subject_name , COUNT(e.subject_name) as attended_exams
from Students s  cross join Subjects j 
left join Examinations e 
on s.student_id = e.student_id
and e.subject_name = j.subject_name
group by s.student_id ,j.subject_name
order by s.student_id ,j.subject_name

-- Managers with at Least 5 Direct Reports

select m.name 
from Employee e join Employee m 
on e.managerId = m.id
group by m.id, m.name
Having Count(e.managerId) >= 5 

--Confirmation Rate

select s.user_id , 
ROUND(Coalesce(SUM(Case when c.action = "confirmed" then 1 
else 0 end ) / COUNT(c.user_id),0) , 2) as confirmation_rate
from signups s  left join confirmations c 
on s.user_id = c.user_id
group by s.user_id


--Product Sales Analysis III

select product_id , year as first_year , quantity , price 
from Sales 
where (product_id , year) IN (
    select product_id , MIN(year)
    from Sales
    group by product_id
)


--Market Analysis I

select u.user_id as buyer_id , u.join_date , COUNT(o.buyer_id) as orders_in_2019
from Users u left join Orders o 
on u.user_id = o.buyer_id
and year(o.order_date) = 2019
group by u.user_id