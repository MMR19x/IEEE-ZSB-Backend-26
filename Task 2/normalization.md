# Normalization 

- A tool to validate and improve logical design, so that it satisfies certain consrtrains that avoid unnecessary duplication of data.

1. [1st Normal form](#1st-Normal-form) 
1. [2nd Normal form](#2nd-normal-form)
1. [3rd Noraml form](#3rd-normal-form) 

## 1st Normal form 
- To convert the table into 1st NF there mustn't be any multivalued atributes, repeating groups or composite attributes.

- in our case we have multivalued attribute which is Student_phone which can has more than one value and cause data redundancy in the table, so to transform into 1 NF, 

  separate Student_phone attribute into a new table and take the PK of the main table with it as FK and the Pk of new table is composite PK from Student_name and Student_phone.
   
## Table shape in 1NF :

 ###  `Student_Grade_Report`

| Student_Name (PK) | Course_Title (PK) | City | Street | Zip | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| | | | | | | | | |

### `Student_phone`

| Student_Name (FK, PK) | Student_Phone |
| :--- | :--- |
| | |

---


## 2nd Normal form 
- To convert the table into 2nd NF, it must be at 1 NF and doesn't contain any partial dependecies.

- partial dependency means that there's an attribute depend on one part only of the PK, and in this case the PK should be composite PK, 
  
- in our case there is partial dependancy in the Student_address attribute it depends only on Student_name not both PKs so to transform table into 2nd NF,

  separate Student_address attributes in another table with the part of the PK it depends on which is Student_name.

## Table shape in 2NF :

 ###  `Student_Grade_Report` 

| Student_Name (PK)| Course_Title (PK) | Instructor_Name | Instructor_Dept | Dept_Building | Grade |
| :--- | :--- | :--- | :--- | :--- | :--- |
| | | | | | |

###  `Student_address`

| Student_Name (PK) | City | Street | Zip |
| :--- | :--- | :--- | :--- |
| | | | |

###  `Student_phone` 

| Student_Name (PK,FK) | Student_Phone |
| :--- | :--- |
| | |

---

## 3rd Normal form 
- To convert the table into 3nd NF, it must be at 2 NF and doesn't contain any transitive dependecies.

- Transitive dependency means there's an attribute depends on another non-Key attribute, 
 
- in our case there is a transitive dependency as Dept_Building depends on Instructor_Dept which is not part of the PK, so to transform table into 3rd NF,

  separate Dept_building with Instructor_Dept in a new table with Instructor_Dept as PK and leave it in the main table as FK to keep tables connected with each other.

## Table shape in 3NF :

 ###  `Student_Grade_Report`

| Student_Name (PK) | Course_Title (PK) | Instructor_Name | Instructor_Dept (FK) | Grade |
| :--- | :--- | :--- | :--- | :--- |
| | | | | |

###  `Dept`

| Instructor_Dept (PK) | Dept_Building |
| :--- | :--- |
| | |

###  `Student_address`

| Student_Name (PK) | City | Street | Zip |
| :--- | :--- | :--- | :--- |
| | | | |

### `Student_phone`

| Student_Name (PK,FK) | Student_Phone |
| :--- | :--- |
| | |





