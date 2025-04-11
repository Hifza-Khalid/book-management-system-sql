-- Step 1: Create the Database
CREATE DATABASE BookManagementSystem;
USE BookManagementSystem;

-- Step 2: Create Tables

-- Authors Table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50)
);

-- Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author_id INT,
    genre VARCHAR(50),
    price DECIMAL(10, 2),
    publication_year INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Step 3: Insert Sample Data

-- Inserting Authors
INSERT INTO Authors (author_name, nationality)
VALUES 
    ('J.K. Rowling', 'British'),
    ('George R.R. Martin', 'American'),
    ('J.R.R. Tolkien', 'British'),
    ('Agatha Christie', 'British'),
    ('Stephen King', 'American'),
    ('Isaac Asimov', 'Russian'),
    ('Dan Brown', 'American'),
    ('F. Scott Fitzgerald', 'American'),
    ('Harper Lee', 'American'),
    ('Mark Twain', 'American');

-- Inserting Books
INSERT INTO Books (title, author_id, genre, price, publication_year)
VALUES 
    ('Harry Potter and the Philosopher\'s Stone', 1, 'Fantasy', 19.99, 1997),
    ('A Game of Thrones', 2, 'Fantasy', 15.99, 1996),
    ('The Hobbit', 3, 'Fantasy', 10.99, 1937),
    ('Murder on the Orient Express', 4, 'Mystery', 12.99, 1934),
    ('The Shining', 5, 'Horror', 14.99, 1977),
    ('Foundation', 6, 'Sci-Fi', 16.99, 1951),
    ('The Da Vinci Code', 7, 'Thriller', 18.99, 2003),
    ('The Great Gatsby', 8, 'Classic', 13.99, 1925),
    ('To Kill a Mockingbird', 9, 'Classic', 14.99, 1960),
    ('Adventures of Huckleberry Finn', 10, 'Classic', 11.99, 1884);

-- Inserting Customers
INSERT INTO Customers (customer_name, email, phone)
VALUES 
    ('Alice Johnson', 'alice@example.com', '123-456-7890'),
    ('Bob Smith', 'bob@example.com', '234-567-8901'),
    ('Charlie Brown', 'charlie@example.com', '345-678-9012'),
    ('David Wilson', 'david@example.com', '456-789-0123'),
    ('Eva Clark', 'eva@example.com', '567-890-1234'),
    ('Frank Moore', 'frank@example.com', '678-901-2345'),
    ('Grace Lee', 'grace@example.com', '789-012-3456'),
    ('Hannah Harris', 'hannah@example.com', '890-123-4567'),
    ('Ivy Martin', 'ivy@example.com', '901-234-5678'),
    ('Jack Scott', 'jack@example.com', '012-345-6789');

-- Inserting Orders
INSERT INTO Orders (customer_id, book_id, order_date, quantity)
VALUES 
    (1, 1, '2025-01-01', 2),
    (2, 3, '2025-01-03', 1),
    (3, 5, '2025-01-10', 3),
    (4, 2, '2025-02-01', 2),
    (5, 4, '2025-02-10', 1),
    (6, 6, '2025-02-15', 2),
    (7, 7, '2025-03-01', 1),
    (8, 8, '2025-03-10', 2),
    (9, 9, '2025-03-15', 1),
    (10, 10, '2025-04-01', 1);

-- Step 4: Sample Queries

-- 1. Get the total number of books sold for each book
SELECT B.title, SUM(O.quantity) AS total_books_sold
FROM Orders O
JOIN Books B ON O.book_id = B.book_id
GROUP BY B.title;

-- 2. Get the average price of books by genre
SELECT genre, AVG(price) AS avg_price
FROM Books
GROUP BY genre;

-- 3. Find the author with the most books sold
SELECT A.author_name, SUM(O.quantity) AS total_books_sold
FROM Orders O
JOIN Books B ON O.book_id = B.book_id
JOIN Authors A ON B.author_id = A.author_id
GROUP BY A.author_name
ORDER BY total_books_sold DESC
LIMIT 1;

-- 4. Find the customer who ordered the most books
SELECT C.customer_name, SUM(O.quantity) AS total_books_ordered
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
GROUP BY C.customer_name
ORDER BY total_books_ordered DESC
LIMIT 1;

-- 5. Get the books ordered by a particular customer (e.g., Alice Johnson)
SELECT B.title, O.quantity, O.order_date
FROM Orders O
JOIN Books B ON O.book_id = B.book_id
JOIN Customers C ON O.customer_id = C.customer_id
WHERE C.customer_name = 'Alice Johnson';

-- 6. Get the total sales for each book (price * quantity)
SELECT B.title, SUM(B.price * O.quantity) AS total_sales
FROM Orders O
JOIN Books B ON O.book_id = B.book_id
GROUP BY B.title;

-- 7. Get the most expensive book
SELECT title, price
FROM Books
ORDER BY price DESC
LIMIT 1;

-- 8. Get the list of books with their respective authors
SELECT B.title, A.author_name
FROM Books B
JOIN Authors A ON B.author_id = A.author_id;

-- 9. Get the total number of books in the system (Books table)
SELECT COUNT(*) AS total_books
FROM Books;

-- 10. Get the books published after the year 2000
SELECT title, publication_year
FROM Books
WHERE publication_year > 2000;
