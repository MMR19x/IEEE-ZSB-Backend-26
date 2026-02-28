# Database Architecture and Performance Summary

## 1. Aggregation: GROUP BY vs. Window Functions
The fundamental difference is the **output granularity**.

| Feature | `GROUP BY` | Window Functions (`OVER`) |
| :--- | :--- | :--- |
| **Output Row Count** | Equal to the number of groups. | Equal to the original input rows. |
| **Data Detail** | High-level summary only (collapses rows). | Full detail + summary data (appends data). |
| **Typical Use Case** | Reporting (e.g., Total sales per month). | Ranking or Running Totals (e.g., Row vs. Avg). |



---

## 2. Index Leaf Nodes
* **Clustered Index:** The leaf node **contains the actual data pages**. The table is the index.
* **Non-Clustered Index:** The leaf node contains **pointers** (Row IDs or Clustered Keys) that refer to the actual data located elsewhere.

---

## 3. The Clustered Index Limit
**Question:** Why only one clustered index per table?
**Answer:** Because a clustered index defines the **physical sort order** of the data on the disk. Since a physical row can only be stored in one sorted order, you can only have one clustered index.

---

## 4. Filtered Indexes
A **Filtered Index** is a non-clustered index that includes a `WHERE` clause to index only a portion of the table.
* **Storage Efficiency:** It decreases storage since it only stores entries that meet the condition.
* **Performance:** It provides faster searches because the B-tree is smaller and doesn't require scanning irrelevant data.

---

## 5. Unique Indexes
* **Inserts:** Slower, as the system must perform a "lookup" on all existing data to ensure no duplicates are being added.
* **Selects:** Faster, because the query optimizer knows it can stop searching the moment a single match is found.

---

## 6. Temporary Data: The Case for Heaps
For a "Staging Table" where millions of rows are inserted, read once, and deleted:
* **Heap Structure:** This is the best choice because data is inserted directly into the first available space without the overhead of sorting.
* **Cleanup:** `TRUNCATE` or `DELETE` operations on a Heap are faster because there is no B-tree structure to rebalance or maintain as rows are removed.



---

## 7. Atomicity: The "All or Nothing" Concept
**Atomicity** (the 'A' in ACID) ensures that a transaction is treated as a single, indivisible unit.

### The "All or Nothing" Rule
* **All** parts of the transaction must succeed for any changes to be saved (**Committed**).
* If even one small part fails, the entire operation is undone (**Rolled Back**), leaving the database exactly as it was before you started.

### The Disastrous "Partial Failure"
Without a transaction, a bank transfer of $500 from Account A to Account B could fail mid-way:
1.  **Step 1:** $500 is subtracted from Account A.
2.  **Failure:** A system crash occurs before Step 2.
3.  **Result:** Account A is missing $500, but Account B never received it. The money "vanishes" into thin air.

### The Solution
With a **Transaction (`BEGIN...COMMIT`)**, if Step 2 fails, the database recognizes the partial state and triggers a **Rollback**. This restores the $500 to Account A, ensuring the data remains consistent and "whole."