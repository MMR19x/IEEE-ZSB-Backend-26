
-- duplicate emails 

select email 
from person 
group by email 
having count(email) > 1

--  delete duplicated emails 

delete p1
 from person p1
join (
    select id,email
    from person 
)as p2
on p1.email = p2.email
and p1.id > p2.id

-- Nth highest salary

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
    select distinct salary 
    from  (
            SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
            FROM Employee
        ) AS ranked
        WHERE rnk = N

  );
END

-- rank scores

select score,
DENSE_RANK() over(order by score DESC) as 'rank'
from Scores

-- department top salary

select d.name as Department,e.name as Employee , e.salary 
from Employee e join Department d 
on e.departmentID = d.id
join (
    select departmentId, MAX(salary) AS maxSalary
    FROM Employee
    group by departmentId
) as temp 
on e.departmentId = temp.departmentId and e.salary = temp.maxSalary 