**Overview**

This project is a Library Management System built using SQL and MySQL, designed to manage and analyze data for a multi-branch library network. It includes information about books, authors, publishers, borrowers, library branches, book copies, and book loans — with the goal of organizing, connecting, and retrieving library records in a structured way.

The system replicates real-world library operations such as book availability, loan tracking, borrower history, and branch-level inventory management. The project was presented in a clear, easy-to-understand format, making it suitable even for non-technical audiences.

**Tools & Skills Used**

MySQL / SQL – for database design and query execution

ER Diagram – to visualize core entity relationships

Joins, Subqueries & Aggregations – for detailed data retrieval

Data Modeling & Normalization – to maintain accuracy and reduce redundancy

Database Design Concepts – primary keys, foreign keys, constraints

**Key Insights & Analyses**

Retrieved the number of copies of a specific book (“The Lost Tribe”) across different branches.

Identified borrowers who currently have no books checked out.

Analyzed loan details for specific branches and due dates.

Calculated the total number of books loaned from each library branch.

Retrieved borrowers with more than five active loans.

Extracted branch-level book availability for authors like Stephen King.

**Database Design Highlights**

Built 7 interconnected tables representing all library operations:

Publisher → Book → Book Authors

Book → Book Copies → Library Branch

Borrower → Book Loans

All tables are connected through Primary & Foreign Keys to maintain referential integrity and ensure consistent data flow across the system.

**Project Features**
Feature	Description
Relational Design	Built a normalized database with 7 tables and clear constraints
Advanced Queries	Used joins, subqueries, and aggregate functions
Insights Extraction	Identified book availability, borrower patterns, and branch-level activity
Data Consistency	Enforced using foreign key relationships
Structured Presentation	Explained with ER diagram and real-world examples

**What I Learned**

How to structure and normalize a relational SQL database

Writing analytical queries for real-world scenarios

Understanding entity relationships through an ER diagram

Managing multi-branch systems using relational logic

Presenting technical processes in a simple, clear format
