# Research 

### 1. What is the difference between a DBMS and an RDBMS?

- Database Management System (DBMS) is a software package to facilitate creation and maintenance of computerized DB, 

- Relational Database Management System (RDBMS) is a type of DBMS, as the name suggests it deals with relations as well as various key constraints.

#### <u> DBMS </u>                                                         
1. stores data as file.                                                 
2. Data elements need to access individually.
3. No relationship between data.
4. Normalization is not present.
5. Data redundancy is common in this model.	
6. It deals with small quantity of data.

 #### <u> RDBMS </u>
 1. RDBMS stores data in tabular form.
 2. Multiple data elements can be accessed at the same time.
 3. Data is stored in the form of tables which are related to each other.
 4. Normalization is present.
 5. Keys and indexes do not allow Data redundancy.
 6. It deals with large amount of data.

 ---

### 2. Based on Chapter 04 and 05, what is the difference between DDL (Data Definition Language) and DML (Data Manipulation Language)? Give one example command for each.

- DDL (Data Definition Language) : commands used to define a DB, including those commands for creating , altering and dropping tables.
1.  `Create`
```sql
CREATE TABLE table_name (
    Column_1 data_type constrains,
    Column_2 data_type
);
```
2. `Alter` 
```sql 
ALTER TABLE table_name
ADD column_name datatype;
```

- DML (Data Manipulation Language) : commands used to maintain and query DB, including those commands for updating , inserting and modifying data.
1. `Update` 
``` sql
    UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;
```

2. `INSERT INTO` 
``` sql 
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');
```

---

### 3.In your own words, why is Normalization important for a large system like a university database?

#### - Normalization helps in making well-structured relations as is contains minimal data redundancy and allow user to insert, delete and update rows withoud causing inconsistencies.

#### - avoid anomalies
1. insertion anomaly : adding new rows force user to duplicate data
2. deletion anomaly : deleting rows may cause loss of data that would be needed for other future rows.
3. modification anomaly : changing data in a row forces to change to other rows due to duplication.

#### - all these constrains that put by normalization helps DB to work smoothly without any sudden crashing or losing data.