CREATE DATABASE LIBRARY;
USE LIBRARY;
-- Table: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress TEXT,
    publisher_PublisherPhone VARCHAR(15)
);

select * from tbl_publisher;

-- Table: tbl_book
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName)
);

select * from tbl_book;

-- Table: tbl_book_authors
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID)
);

select * from tbl_book_authors;

-- Table: tbl_library_branch
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress TEXT
);

select * from tbl_library_branch;

-- Table: tbl_book_copies
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID)
);

select * from tbl_book_copies;

-- Table: tbl_borrower
CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress TEXT,
    borrower_BorrowerPhone VARCHAR(15)
);

select * from tbl_borrower;

-- Table: tbl_book_loans
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID),
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID),
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo)
);

select * from tbl_book_loans;

-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
select book_copies_no_of_Copies FROM tbl_book_copies
where book_copies_BookID = (SELECT book_BookID
from tbl_book WHERE book_Title = 'The Lost Tribe')
and book_copies_BranchID = (SELECT library_branch_BranchID
from tbl_library_branch WHERE library_branch_BranchName = 'Sharpstown');

-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?
SELECT library_branch_BranchName, book_copies_No_Of_Copies
FROM tbl_book_copies
JOIN tbl_book ON book_copies_BookID = book_BookID
JOIN tbl_library_branch ON book_copies_BranchID = library_branch_BranchID
WHERE book_Title = 'The Lost Tribe';

-- Retrieve the names of all borrowers who do not have any books checked out.
select borrower_BorrowerName from tbl_borrower
left join tbl_book_loans on borrower_CardNo = book_loans_CardNo
where book_loans_BookID is null;

-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address.
SELECT book_Title, borrower_BorrowerName, borrower_BorrowerAddress
FROM tbl_book_loans
JOIN tbl_book ON book_loans_BookID = book_BookID
JOIN tbl_borrower ON book_loans_CardNo = borrower_CardNo
JOIN tbl_library_branch ON book_loans_BranchID = library_branch_BranchID
WHERE library_branch_BranchName = 'Sharpstown'
AND book_loans_DueDate = '2018-03-02';
  
-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
SELECT library_branch_BranchName, 
COUNT(book_loans_LoansID)
FROM tbl_library_branch
JOIN tbl_book_loans ON library_branch_BranchID = book_loans_BranchID
GROUP BY library_branch_BranchName;

-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
SELECT borrower_BorrowerName, borrower_BorrowerAddress, 
COUNT(book_loans_BookID)
FROM tbl_borrower
JOIN tbl_book_loans ON borrower_CardNo = book_loans_CardNo
GROUP BY borrower_CardNo, borrower_BorrowerName, borrower_BorrowerAddress
HAVING COUNT(book_loans_BookID) > 5;

-- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
SELECT book_Title, book_copies_No_Of_Copies
FROM tbl_book_authors
JOIN tbl_book ON book_authors_BookID = book_BookID
JOIN tbl_book_copies ON book_BookID = book_copies_BookID
JOIN tbl_library_branch ON book_copies_BranchID = library_branch_BranchID
WHERE book_authors_AuthorName = 'Stephen King'
AND library_branch_BranchName = 'Central';

SELECT book_Title,book_copies_No_Of_Copies
FROM tbl_book 
JOIN tbl_book_authors ON book_BookID = book_authors_BookID
JOIN tbl_book_copies ON book_BookID = book_copies_BookID
JOIN tbl_library_branch ON book_copies_BranchID = library_branch_BranchID
WHERE book_authors_AuthorName = 'Stephen King'
AND library_branch_BranchName = 'Central';

