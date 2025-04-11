-- ==================================================
-- Book Management System Database Schema
-- ==================================================

-- Table 1: Authors
-- Stores information about authors
CREATE TABLE Authors (
    author_id INT PRIMARY KEY, -- Unique identifier for each author
    name VARCHAR(100) NOT NULL, -- Name of the author
    birth_date DATE, -- Birth date of the author
    country VARCHAR(50) -- Country of origin
);

-- Table 2: Publishers
-- Stores information about publishers
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY, -- Unique identifier for each publisher
    name VARCHAR(100) NOT NULL, -- Name of the publisher
    address VARCHAR(150), -- Address of the publisher
    contact_number VARCHAR(15) -- Contact number for the publisher
);

-- Table 3: Books
-- Stores information about books and links them to authors and publishers
CREATE TABLE Books (
    book_id INT PRIMARY KEY, -- Unique identifier for each book
    title VARCHAR(100) NOT NULL, -- Title of the book
    publication_year INT, -- Year the book was published
    price DECIMAL(10, 2), -- Price of the book
    author_id INT, -- Foreign key referencing Authors table
    publisher_id INT, -- Foreign key referencing Publishers table
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

-- Table 4: Customers
-- Stores information about customers who borrow or buy books
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY, -- Unique identifier for each customer
    name VARCHAR(100) NOT NULL, -- Name of the customer
    email VARCHAR(100) NOT NULL, -- Email of the customer
    phone VARCHAR(15), -- Phone number of the customer
    address VARCHAR(150) -- Address of the customer
);

-- Table 5: Orders
-- Stores information about the books ordered by customers
CREATE TABLE Orders (
    order_id INT PRIMARY KEY, -- Unique identifier for each order
    customer_id INT, -- Foreign key referencing Customers table
    book_id INT, -- Foreign key referencing Books table
    order_date DATE, -- Date the order was placed
    quantity INT, -- Number of books ordered
    total_price DECIMAL(10, 2), -- Total price of the order (quantity * book price)
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- ==================================================
-- Sample Data Insertion
-- ==================================================

-- Inserting Authors
INSERT INTO Authors (author_id, name, birth_date, country) VALUES
(1, 'J.K. Rowling', '1965-07-31', 'United Kingdom'),
(2, 'George Orwell', '1903-06-25', 'United Kingdom'),
(3, 'J.R.R. Tolkien', '1892-01-03', 'United Kingdom'),
(4, 'Mark Twain', '1835-11-30', 'United States'),
(5, 'Jane Austen', '1775-12-16', 'United Kingdom');

-- Inserting Publishers
INSERT INTO Publishers (publisher_id, name, address, contact_number) VALUES
(1, 'Bloomsbury Publishing', 'London, UK', '020 7631 5600'),
(2, 'Penguin Books', 'New York, USA', '800-778-7814'),
(3, 'Houghton Mifflin Harcourt', 'Boston, USA', '617-351-5000'),
(4, 'HarperCollins', 'New York, USA', '212-207-7000'),
(5, 'Oxford University Press', 'Oxford, UK', '01865 556767');

-- Inserting Books
INSERT INTO Books (book_id, title, publication_year, price, author_id, publisher_id) VALUES
(1, 'Harry Potter and the Philosopher\'s Stone', 1997, 19.99, 1, 1),
(2, '1984', 1949, 14.99, 2, 2),
(3, 'The Lord of the Rings', 1954, 25.99, 3, 3),
(4, 'Adventures of Huckleberry Finn', 1884, 12.99, 4, 4),
(5, 'Pride and Prejudice', 1813, 9.99, 5, 5),
(6, 'Harry Potter and the Chamber of Secrets', 1998, 19.99, 1, 1),
(7, 'Animal Farm', 1945, 12.99, 2, 2),
(8, 'The Hobbit', 1937, 15.99, 3, 3),
(9, 'Tom Sawyer', 1876, 11.99, 4, 4),
(10, 'Sense and Sensibility', 1811, 8.99, 5, 5);

-- Inserting Customers
INSERT INTO Customers (customer_id, name, email, phone, address) VALUES
(1, 'Alice Johnson', 'alice.johnson@email.com', '123-456-7890', '123 Main St, Sydney'),
(2, 'Bob Smith', 'bob.smith@email.com', '234-567-8901', '456 Oak St, New York'),
(3, 'Charlie Brown', 'charlie.brown@email.com', '345-678-9012', '789 Pine St, London'),
(4, 'David Clark', 'david.clark@email.com', '456-789-0123', '321 Elm St, California'),
(5, 'Eva Davis', 'eva.davis@email.com', '567-890-1234', '654 Maple St, Texas');

-- Inserting Orders
INSERT INTO Orders (order_id, customer_id, book_id, order_date, quantity, total_price) VALUES
(1, 1, 1, '2025-04-11', 2, 39.98),
(2, 2, 4, '2025-04-10', 1, 12.99),
(3, 3, 2, '2025-04-09', 1, 14.99),
(4, 4, 3, '2025-04-08', 1, 25.99),
(5, 5, 5, '2025-04-07', 1, 9.99);

-- ==================================================
-- SQL Queries
-- ==================================================

-- 1. Fetch All Books and Their Authors
SELECT B.title, A.name AS author_name
FROM Books B
JOIN Authors A ON B.author_id = A.author_id;

-- 2. Fetch Books Published by a Specific Publisher
SELECT B.title, P.name AS publisher_name
FROM Books B
JOIN Publishers P ON B.publisher_id = P.publisher_id
WHERE P.name = 'Penguin Books';

-- 3. Fetch All Orders Made by a Specific Customer
SELECT O.order_id, O.order_date, B.title, O.quantity, O.total_price
FROM Orders O
JOIN Books B ON O.book_id = B.book_id
WHERE O.customer_id = 1;

-- 4. Find the Most Expensive Book in the System
SELECT title, price
FROM Books
ORDER BY price DESC
LIMIT 1;

-- 5. Find the Total Sales for Each Book
SELECT B.title, SUM(O.quantity) AS total_sales
FROM Orders O
JOIN Books B ON O.book_id = B.book_id
GROUP BY B.title;

-- 6. List All Authors with Their Books
SELECT A.name AS author_name, GROUP_CONCAT(B.title) AS books
FROM Authors A
JOIN Books B ON A.author_id = B.author_id
GROUP BY A.name;

-- 7. List Customers and Their Total Orders
SELECT C.name AS customer_name, COUNT(O.order_id) AS total_orders
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.name;

-- 8. Fetch Books and Their Details with Author and Publisher Information
SELECT B.title, A.name AS author_name, P.name AS publisher_name, B.price
FROM Books B
JOIN Authors A ON B.author_id = A.author_id
JOIN Publishers P ON B.publisher_id = P.publisher_id;

-- 9. Update Book Price (Increase by 5)
UPDATE Books
SET price = price + 5
WHERE book_id = 1;

-- 10. Delete an Order
DELETE FROM Orders
WHERE order_id = 2;
