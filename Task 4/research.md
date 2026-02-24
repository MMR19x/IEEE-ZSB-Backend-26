# SQL 

---

## 1. UNION vs. UNION ALL

| Feature | UNION | UNION ALL |
| :--- | :--- | :--- |
| **Duplicates** | Automatically removes duplicate rows; returns unique records only. | Includes all rows, including duplicates, in the final result set. |
| **Performance** | **Slower**: Requires internal sorting and filtering overhead to find duplicates. | **Faster**: Simply appends results together without additional checking. |
| **Result Size** | Smaller or equal to the combined row count of the queries. | Exactly equal to the sum of all rows from all combined queries. |
| **Best Use Case** | When you need a list of distinct, unique records. | When you need all records or know that duplicates aren't possible/relevant. |

---

## 2. Choosing Joins over Subqueries
In production environments, **Joins** are often preferred over subqueries for the following reasons:

###  Performance & Optimization
* **Single Pass Operation:** Database engines process tables simultaneously in a single, well-optimized pass.
* **Avoiding "Looping" Logic:** Correlated subqueries can act like a loop, executing the inner query for every single row in the outer table, which kills performance on large datasets.
* **Mature Optimizers:** RDBMS optimizers (MySQL, PostgreSQL, SQL Server) have historically had more mature algorithms for optimizing JOIN operations.
* **Reduced Memory Overhead:** Joins often avoid creating intermediate, temporary result sets in memory that complex subqueries might require.

###  Maintainability & Scalability
* **Explicit Relationships:** Joins explicitly define how tables relate, making the query's intent easier for other engineers to understand and debug.
* **Direct Column Access:** If you need to select columns from multiple tables, a Join is straightforward. Subqueries often require deeply nested or repetitive logic to retrieve the same data.
