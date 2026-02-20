# SQL Essential Concepts: A Quick Reference Guide

## 1. WHERE vs. HAVING Clause
Both are used to filter data, but their timing in the execution process is different.

| Feature | WHERE Clause | HAVING Clause |
| :--- | :--- | :--- |
| **Level** | Filters individual rows. | Filters grouped data. |
| **Timing** | Before `GROUP BY`. | After `GROUP BY`. |
| **Aggregates** | Cannot use aggregate functions (SUM, AVG, etc.). | Must be used for aggregate conditions. |
| **Statements** | SELECT, UPDATE, DELETE. | SELECT only. |
| **Speed** | Faster (reduces rows early). | Slower (processes entire groups). |

### Where Clause syntax
```sql
SELECT Column_1, Column_2
FROM table
WHERE Column_1 = 'Value';
```
### Having Clause syntax
```sql
SELECT Column_1, SUM(Column_2) AS Total
FROM table
GROUP BY Column_1
HAVING SUM(Column_2) > value;
```


---

## 2. DELETE vs. TRUNCATE vs. DROP
*Note: I have corrected the labels from your original notes to reflect accurate DB behavior.*

| Command | Category | Action | Rollback? |
| :--- | :--- | :--- | :--- |
| **DELETE** | DML | Removes specific rows based on a condition. | Yes |
| **TRUNCATE** | DDL | Removes all rows but keeps the table structure. | No (usually) |
| **DROP** | DDL | Removes the entire table (data + structure). | No |

**Syntax Examples:**
- `DELETE FROM TableName WHERE ID = 1;`
- `TRUNCATE TABLE TableName;`
- `DROP TABLE TableName;`

---

## 3. Order of Execution
The logical order in which the database engine processes your query:

1. **FROM**: Identify the table(s).
2. **WHERE**: Filter individual rows.
3. **GROUP BY**: Group remaining rows.
4. **HAVING**: Filter groups.
5. **SELECT**: Pick columns to show.
6. **ORDER BY**: Sort the final results.

---

## 4. COUNT(*) vs. COUNT(column_name)
- **COUNT(*)**: Counts every single row in the set, including those with `NULL` values, Used for finding total number of records in a table.
- **COUNT(column_name)**: Counts only the rows where that specific column is **NOT NULL**, Used for counting number of occurrence of specific (Not NULL) values. 


---

## 5. CHAR vs. VARCHAR
- **CHAR(n)**: Fixed length. If the input is shorter than `n`, it pads it with spaces. Use for fixed data like Country Codes (US, UK). 
 Since "Cat" only uses 3 characters, the database adds 7 blank spaces to the end to fill the box.
 Result: "Cat_______"
- **VARCHAR(n)**: Variable length. It only uses as much space as the text requires (plus a tiny bit of metadata). Better for names or descriptions.
It shrinks to fit the 3 characters of "Cat." No extra spaces are added.
 Result: "Cat"
