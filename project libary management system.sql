CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Books (
    ISBN VARCHAR(25) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(25),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(25),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES (1, 101, 'Downtown Library', '9876543210');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES (101, 'John Doe', 'Manager', 60000, 1);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES ('978-1234567890', 'Introduction to SQL', 'Database', 30.00, 'yes', 'John Smith', 'TechPress');

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES ('978-9876543210', 'Advanced Python', 'Programming', 45.00, 'yes', 'Jane Doe', 'CodeWorld');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES (201, 'Alice Johnson', '123 Main St', '2023-05-15');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES (202, 'Bob Smith', '456 Elm St', '2021-12-10');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES (301, 201, 'Introduction to SQL', '2024-03-20', '978-1234567890');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES (401, 201, 'Introduction to SQL', '2024-03-25', '978-1234567890');

SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'yes';

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

SELECT Books.Book_title, Customer.Customer_name FROM IssueStatus JOIN Books ON IssueStatus.Isbn_book = Books.ISBN JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

SELECT Category, COUNT(*) AS Total_Books FROM Books GROUP BY Category;

SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no;

SELECT DISTINCT Customer.Customer_name FROM IssueStatus JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

SELECT Book_title FROM Books WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

SELECT Employee.Emp_name, Branch.Branch_address FROM Employee JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

SELECT DISTINCT Customer.Customer_name FROM IssueStatus JOIN Books ON IssueStatus.Isbn_book = Books.ISBN JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id WHERE Books.Rental_Price > 25;
