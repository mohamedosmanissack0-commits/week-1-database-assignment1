-- Week 1 Database Assignment
-- Topic: Community Library Management System

-- Create the database
CREATE DATABASE IF NOT EXISTS community_library;

-- Select the database
USE community_library;

-- Create authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Create books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year YEAR,
    genre VARCHAR(50),
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Create members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    membership_date DATE NOT NULL
);

-- Create loans table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Insert authors
INSERT INTO authors (first_name, last_name, email) VALUES
('Chinua', 'Achebe', 'chinua.achebe@example.com'),
('Ngugi', 'wa Thiong''o', 'ngugi@example.com'),
('Jane', 'Austen', 'jane.austen@example.com');

-- Insert books
INSERT INTO books (title, isbn, publication_year, genre, author_id) VALUES
('Things Fall Apart', '9780385474542', 1958, 'Fiction', 1),
('A Grain of Wheat', '9780143106762', 1967, 'Historical Fiction', 2),
('Pride and Prejudice', '9780141439518', 1813, 'Romance', 3);

-- Insert library members
INSERT INTO members (first_name, last_name, email, phone, membership_date) VALUES
('Amina', 'Kamau', 'amina.kamau@example.com', '0712345678', '2026-01-15'),
('Brian', 'Otieno', 'brian.otieno@example.com', '0723456789', '2026-02-10'),
('Grace', 'Wanjiku', 'grace.wanjiku@example.com', '0734567890', '2026-03-05');

-- Insert book loans
INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 1, '2026-09-01', '2026-09-15', '2026-09-12'),
(2, 2, '2026-09-10', '2026-09-24', NULL),
(3, 3, '2026-09-20', '2026-10-04', '2026-10-02');

-- Display all authors
SELECT * FROM authors;

-- Display all books
SELECT * FROM books;

-- Display all members
SELECT * FROM members;

-- Display all loans
SELECT * FROM loans;

-- Display books that are currently borrowed
SELECT
    l.loan_id,
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    l.loan_date,
    l.due_date
FROM loans AS l
JOIN books AS b ON l.book_id = b.book_id
JOIN members AS m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;