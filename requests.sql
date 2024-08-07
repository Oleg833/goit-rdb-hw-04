DROP DATABASE IF EXISTS LibraryManagement;
CREATE DATABASE LibraryManagement;

USE LibraryManagement;
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO authors (author_name) VALUES ('George R. R. Martin'), ('J.K. Rowling');

INSERT INTO genres (genre_name) VALUES ('Fantasy'), ('Mystery');

INSERT INTO books (title, publication_year, author_id, genre_id) 
VALUES ('A Game of Thrones', 1996, 1, 1), 
       ('Harry Potter and the Philosopher\'s Stone', 1997, 2, 1);

INSERT INTO users (username, email) VALUES ('alex_jones', 'alex_jones@gmail.com'), 
                                           ('emma_watson', 'emma_watson@gmail.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) 
VALUES (1, 1, '2024-08-04', '2024-08-25'), 
       (2, 2, '2024-08-07', '2024-08-29');


SELECT *
FROM LibraryManagement.books;

SELECT *
FROM 
    order_details od
INNER JOIN 
    orders o ON od.order_id = o.order_id
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
INNER JOIN 
    products p ON od.product_id = p.product_id
INNER JOIN 
    categories cat ON p.category_id = cat.category_id
INNER JOIN 
    employees e ON o.employee_id = e.employee_id
INNER JOIN 
    shippers s ON o.shipper_id = s.shipper_id
INNER JOIN 
    suppliers sup ON p.supplier_id = sup.supplier_id;


SELECT count(*)
    
FROM 
    order_details od
INNER JOIN 
    orders o ON od.order_id = o.id
INNER JOIN 
    customers c ON o.customer_id = c.id
INNER JOIN 
    employees e ON o.employee_id = e.employee_id
INNER JOIN 
    shippers s ON o.shipper_id = s.id
INNER JOIN 
    products p ON od.product_id = p.id
INNER JOIN 
    categories cat ON p.category_id = cat.id
INNER JOIN 
    suppliers sup ON p.supplier_id = sup.id;


SELECT COUNT(*)

FROM 
    order_details od
INNER JOIN 
    orders o ON od.order_id = o.id
LEFT JOIN 
    customers c ON o.customer_id = c.id
LEFT JOIN 
    shippers s ON o.shipper_id = s.id
INNER JOIN 
    products p ON od.product_id = p.id
LEFT JOIN 
    categories cat ON p.category_id = cat.id
RIGHT JOIN 
    employees e ON o.employee_id = e.employee_id
LEFT JOIN 
    suppliers sup ON p.supplier_id = sup.id;


SELECT *

FROM 
    order_details od
INNER JOIN 
    orders o ON od.order_id = o.id
LEFT JOIN 
    customers c ON o.customer_id = c.id
LEFT JOIN 
    shippers s ON o.shipper_id = s.id
INNER JOIN 
    products p ON od.product_id = p.id
LEFT JOIN 
    categories cat ON p.category_id = cat.id
RIGHT JOIN 
    employees e ON o.employee_id = e.employee_id
LEFT JOIN 
    suppliers sup ON p.supplier_id = sup.id
WHERE 
    e.employee_id > 3 AND e.employee_id <= 10;


SELECT 
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS average_quantity

FROM 
    order_details od
INNER JOIN 
    orders o ON od.order_id = o.id
INNER JOIN 
    customers c ON o.customer_id = c.id
INNER JOIN 
    employees e ON o.employee_id = e.employee_id
INNER JOIN 
    shippers s ON o.shipper_id = s.id
INNER JOIN 
    products p ON od.product_id = p.id
INNER JOIN 
    categories cat ON p.category_id = cat.id
INNER JOIN 
    suppliers sup ON p.supplier_id = sup.id
WHERE 
    e.employee_id > 3 AND e.employee_id <= 10
GROUP BY 
    cat.name
HAVING 
    AVG(od.quantity) > 21
ORDER BY 
    row_count DESC
LIMIT 4 OFFSET 1;
