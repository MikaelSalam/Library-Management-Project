--Create Tables 
--Category Table
CREATE TABLE categories (
 CategoryID SERIAL PRIMARY KEY,
 Category_Name VARCHAR(100) NOT NULL
);

--Members Table
CREATE TABLE members (
 MemberID SERIAL PRIMARY KEY,
 Member_Name VARCHAR(500),
 Email VARCHAR(100) UNIQUE,
 Contact_Number VARCHAR(15),
 Membership_Date DATE
);

--Authors Table
CREATE TABLE authors (
 AuthorID SERIAL PRIMARY KEY,
 Author_Name VARCHAR(500),
 Nationality VARCHAR(150)
);

--Books Table
CREATE TABLE books (
 BookId SERIAL PRIMARY KEY,
 Book_title VARCHAR(500),
 ISBN VARCHAR(50) UNIQUE,
 Published_Year DATE,
 Copies_Available INT,
 CategoryID INT,
 FOREIGN KEY (CategoryID)
     REFERENCES categories(CategoryID),
 AuthorID INTEGER NOT NULL,
 FOREIGN KEY (AuthorID) REFERENCES authors(AuthorID)
);

--Librarians Table
CREATE TABLE librarians (
 LibrarianID SERIAL PRIMARY KEY,
 Librarian_Name VARCHAR(500),
 Contact_Info VARCHAR(500),
 Hire_Date DATE
);

--Borrowings Table
CREATE TABLE borrowings (
 BorrowID SERIAL PRIMARY KEY,
 MemberID INT,
  FOREIGN KEY (MemberID)
    REFERENCES members(MemberID),
 BookID INT,
  FOREIGN KEY (BookID)
    REFERENCES books(BookID),
 Borrow_Date DATE,
 Due_Date DATE,
 Return_Date DATE,
 Status VARCHAR(50)
);


--Categorey Data
INSERT INTO categories (Category_Name)
VALUES 
('Philosophy'),
('Belizean Culture'),
('Technology'),
('Science'),
('Geography'),
('History'),
('Health');

--Members Table
INSERT INTO members (Member_Name, Email, Contact_Number, Membership_Date)
VALUES 
('Kemrick Rodriguez', 'kemrick@example.com', '+5016001234', '2025-01-10'),
('Elena Martinez', 'elena.m@example.com', '+5016225678', '2025-03-22'),
('Jamal Young', 'jamal.y@example.com', '+5016347890', '2025-05-05'),
('George Smith' , 'george.s@example.com', '+5016453789', '2023-05-08'),
('Mark Williams' , 'mark.w@example.com', '+5016278910', '2013-12-4'),
('Kile Turner' , 'kile.T@example.com', '+5016843258', '2021-09-08'),
('Oliver Williams' , 'oliver.W@example.com' , '+5016765894' , '2024-06-11'),
('Abraham Lincoln' , 'abraham.l@example.com' , '+5016580903' , '2000-02-02'),
('Quandale Dingle' , 'quandale.d@example.com' , '+5016251023' , '2022-05-09'),
('Samuel George' , 'sam.g@example.com' , '+5016784320' , '2018-12-03'),
('Kevin Wilmer' , 'kevin.w@example.com' , '+5016120039' , '2020-05-09'),
('Aaliyah Bennett', 'aaliyah.b@example.com', '+5016112345', '2025-06-18'),
('Darnell Castillo', 'darnell.c@example.com', '+5016234567', '2025-07-02'),
('Sasha Thompson', 'sasha.t@example.com', '+5016356789', '2025-08-14'),
('Tyrese Alvarez', 'tyrese.a@example.com', '+5016478901', '2025-09-01'),
('Marisol Gutierrez', 'marisol.g@example.com', '+5016590123', '2025-09-20'),
('Andre Lewis', 'andre.l@example.com', '+5016601234', '2025-10-05'),
('Zara Mohammed', 'zara.m@example.com', '+5016723456', '2025-10-22'),
('Kiana Flowers', 'kiana.f@example.com', '+5016005678', '2025-10-25'),
('Malik Gordon', 'malik.g@example.com', '+5016117890', '2025-10-26'),
('Renee Castillo', 'renee.c@example.com', '+5016228901', '2025-10-27'),
('Jared Martinez', 'jared.m@example.com', '+5016339012', '2025-10-28'),
('Tanya Lewis', 'tanya.l@example.com', '+5016440123', '2025-10-29'),
('Devon Young', 'devon.y@example.com', '+5016551234', '2025-10-30'),
('Luz Hernandez', 'luz.h@example.com', '+5016662345', '2025-10-31'),
('Darius Bennett', 'darius.b@example.com', '+5016773456', '2025-11-01'),
('Imani Grant', 'imani.g@example.com', '+5016884567', '2025-11-02'),
('Noah Vasquez', 'noah.v@example.com', '+5016995678', '2025-11-03');

--Authors Data
INSERT INTO authors (Author_Name, Nationality)
VALUES 
('Rolf Dobelli', 'Swiss'),
('Myra Godoy', 'Belizean'),
('John Smith', 'American'),
('Aisha Thompson', 'Jamaican'),
('Emily Zhang', 'Chinese'),
('Fatima Al-Mansour', 'Moroccan'),
('Tobias Klein', 'German'),
('Priya Desai', 'Indian'),
('Akira Tanaka', 'Japanese'),
('Jean-Luc Moreau', 'French'),
('Sofia Petrova', 'Bulgarian'),
('Omar El-Sayed', 'Egyptian'),
('Mateo Alvarez', 'Argentinian'),
('Anika Mehta', 'Indian'),
('Hans Gruber', 'Austrian'),
('Chinelo Okafor', 'Nigerian'),
('Isabella Rossi', 'Italian'),
('Dmitri Volkov', 'Russian'),
('Leila Haddad', 'Tunisian'),
('Nia Roberts', 'Welsh');

--Books Data
INSERT INTO books (Book_title, ISBN, Published_Year, Copies_Available , CategoryID , AuthorID)
VALUES 
('The Art of Thinking Clearly', '9780062219675', '2013-05-01', 5,1,1),
('Belizean Legends', '9789992201534', '2005-08-15', 3,2,2),
('SQL for Beginners', '9780131107627', '2020-01-10', 7,3,3),
('Thinking Fast And Slow' , '9780374533557', '2011-10-25',6,1,6),
('Meditations', '9780140449334', '2012-8-9', 5 , 1,11),
('The Art of War and Philosphy', '9780195014761' , '1972-01-01', 3, 1,12),
('The Philosophy of Freedom' , '9781855841007' , '1894-01-01' , 5, 1,10),
('The Ethics of Ambiguity', '9780141018941', '1947-06-01', 4,1,10),
('The Republic', '9780140455113', '1980-01-05', 7, 1,7),
('Legends of The Maya' , '9789992201111', '2001-7-15', 4,2,2),
('Garifuna Rhythms and Roots', '9789992201128', '2003-11-20', 3, 2,3),
('The History of Punta Rock', '9789992201166', '2018-06-30', 3, 2,9),
('Festivals of Belize', '9789992201180', '2021-03-01', 7, 2,6),
('Belizean Identity and Heritage', '9789992201203', '2016-05-22', 5, 2,3),
('Creole Proverbs and Sayings', '9789992201159', '2007-02-28', 6, 2,5),
('Cuisine of the Caribbean Coast', '9789992201142', '2015-08-12', 2, 2, 9),
('Voices of the Rainforest', '9789992201197', '2012-12-12', 5, 2,9),
('Introduction to Artificial Intelligence', '9780136042594', '2018-09-10', 5, 3,7),
('Data Science for Beginners', '9780134034287', '2021-01-05', 7, 3,6),
('Programming with Python', '9781593279288', '2020-10-01', 8, 3,4),
('Tech Trends in Education', '9780134095738', '2023-02-18', 3, 3,12),
('The Internet of Things Explained', '9781491954249', '2020-03-15', 4, 3,11),
('Why We Sleep', '9781501144318', '2017-10-03', 5, 4, 13),
('The Sixth Extinction', '9781250062185', '2014-02-11', 4, 4, 15),
('The Selfish Gene', '9780199291151', '2006-03-16', 5, 4, 14),
('The Elegant Universe', '9780393338102', '2003-10-01', 4, 4, 18),
('A Brief History of Time', '9780553380163', '1998-09-01', 6, 4, 5),
('Geography of Belize', '9789768161234', '2012-06-15', 3, 5, 2),
('Natural Disasters and Human Impact', '9780135678901', '2014-07-22', 6, 5, 13),
('Cultural Landscapes of the World', '9781118123456', '2021-02-14', 4, 5, 20),
('Understanding Climate Zones', '9780521123456', '2018-09-01', 5, 5, 15),
('The Changing Earth: Landforms and Processes', '9780071234567', '2017-08-30', 5, 5, 19),
('Geopolitics and Global Conflicts', '9781107654321', '2019-11-12', 3, 5, 18),
('The Rise and Fall of Empires', '9780143123456', '2010-04-12', 5, 6, 14),
('World War II: A Global History', '9780198765432', '2017-11-11', 3, 6, 17),
('The Industrial Revolution Uncovered', '9781107123456', '2018-10-22', 4, 6, 13),
('A People’s History of the World', '9781786630810', '2008-09-01', 4, 6, 16),
('Holistic Healing Practices', '9781118123457', '2018-05-22', 3, 7, 18),
('The Psychology of Wellness', '9780135678902', '2022-02-14', 5, 7, 20),
('The Immune System Explained', '9781400052188', '2023-04-18', 5, 7, 11),
('Health and Hygiene for All Ages', '9789768123457', '2014-07-22', 4, 7, 12),
('Fitness Fundamentals', '9781498765433', '2020-01-15', 7, 7, 17),
('Mental Health Matters', '9780521123457', '2021-06-01', 4, 7, 15),
('Nutrition Essentials for Beginners', '9780135671234', '2019-03-10', 5, 7, 14);

--Librarians Data
INSERT INTO librarians (Librarian_Name, Contact_Info, Hire_Date)
VALUES 
('Marsha Bennett', 'marsha.b@library.com', '2023-06-01'),
('Carlos Mejia', 'carlos.m@library.com', '2024-01-15'),
('Mark Kile' , 'mark.kile@library.com', '2023-09-10'),
('Pamela Kennett' , 'pam.k@library.com', '2022-03-05'),
('Margot Sam' , 'margot.s@library.com', '2023-04-03'),
('Alan Sheer' , 'alan.s@library.com', '2019-09-08'),
('Josh Reign' , 'josh.r@library.com', '2021-08-02'),
('Samantha Johnson' , 'sam.j@library.com', '2017-01-04'),
('Peter Young' , 'peter.y@library.com', '2024-09-05'),
('Nick Alvarez' , 'nick.al@library.com', '2023-01-09'),
('Jake Musa' , 'jake.M@library.com', '2020-07-06');

--Borrowings Data
INSERT INTO borrowings (MemberID, BookID, Borrow_Date, Due_Date, Return_Date, Status)
VALUES 
(1, 1, '2025-10-01', '2025-10-15', '2025-10-14', 'Returned'),
(2, 2, '2025-10-10', '2025-10-24', NULL, 'Borrowed'),
(3, 3, '2025-09-20', '2025-10-04', '2025-10-03', 'Returned'),
(4, 8, '2025-02-02', '2025-07-07', '2025-07-08' , 'Returned'),
(4, 5, '2025-10-05', '2025-10-19', NULL, 'Borrowed'),
(5, 8, '2025-10-08', '2025-10-22', '2025-10-21', 'Returned'),
(6, 10, '2025-10-12', '2025-10-26', NULL, 'Borrowed'),
(7, 12, '2025-10-15', '2025-10-29', '2025-11-10', 'Returned'),
(8, 15, '2025-10-18', '2025-11-01', '2025-10-01', 'Returned'),
(9, 18, '2025-10-20', '2025-11-03', NULL, 'Borrowed'),
(10, 20, '2025-10-22', '2025-11-05', NULL, 'Borrowed'),
(11, 22, '2025-10-24', '2025-11-07', '2025-11-06', 'Returned'),
(12, 25, '2025-10-26', '2025-11-09', NULL, 'Borrowed'),
(13, 28, '2025-10-28', '2025-11-11', NULL, 'Borrowed'),
(14, 30, '2025-10-30', '2025-11-13', '2025-11-12', 'Returned'),
(15, 32, '2025-11-01', '2025-11-15', NULL, 'Borrowed'),
(16, 35, '2025-11-03', '2025-11-17', NULL, 'Borrowed'),
(17, 38, '2025-11-05', '2025-11-19', '2025-11-18', 'Returned'),
(18, 40, '2025-11-07', '2025-11-21', NULL, 'Borrowed'),
(19, 42, '2025-11-09', '2025-11-23', NULL, 'Borrowed'),
(20, 44, '2025-11-11', '2025-11-25', '2025-11-24', 'Returned');

--Queries 

--List all From Books
SELECT * FROM books; 

--List all from categories
SELECT * FROM categories;

--List all from borrowed
SELECT * FROM borrowings;

--List all members even if they haven't borrowed any books
SELECT m.member_name , b.Book_title ,br.Borrow_Date, br.Status 
FROM members m
LEFT JOIN borrowings br 
ON m.MemberID = br.MemberID
LEFT JOIN books b
ON b.BookID = br.BookID

--Show all borrowings even if member records are missing
SELECT * FROM borrowings br
LEFT JOIN members m
ON br.MemberID = m.MemberID;

--List only borrowings where both members and book exist
SELECT m.member_name , b.BookID , b.Book_title , br.Borrow_Date , br.Status
FROM borrowings br
INNER JOIN members m
ON br.MemberID = m.MemberID
INNER JOIN books b
ON br.BookID = b.BookID


--Show total borrowings per member
SELECT m.member_name , COUNt(br.BorrowID) AS Total_Borrowings  
FROM borrowings br 
INNER JOIN members m ON br.MemberID = m.MemberID
GROUP BY m.member_name

--Show Members with more than one borrowings
SELECT m.MemberID , m.member_name , COUNT(br.BorrowID) AS Borrow_Count
FROM borrowings br 
INNER JOIN members m ON br.MemberID = m.memberID
GROUP BY m.memberID
HAVING COUNT(br.BorrowID) > 1;

--Show books per author 
SELECT a.AuthorID , a.Author_Name , COUNT(a.AuthorID) AS Book_Count
FROM books b
INNER JOIN authors a
ON b.AuthorID = a.AuthorID
GROUP BY a.AuthorID;

--Show recent Borrowing
SELECT * FROM borrowings 
WHERE Borrow_Date IN (SELECT MAX(Borrow_Date) FROM borrowings);

--Show books borrowed recently
SELECT Book_title
FROM books
WHERE BookID IN 
(SELECT BookID FROM borrowings WHERE Borrow_Date =
(SELECT MAX(Borrow_Date)FROM borrowings))

--List Members who borrowed a specific book
SELECT MemberID , member_name 
FROM members 
WHERE MemberID IN (SELECT MemberID FROM borrowings WHERE BookID = 
                  (SELECT BookID FROM books WHERE Book_title = 'Programming with Python' ));

--List Categories with more than 5 books
SELECT CategoryID , Category_Name 
FROM categories
WHERE CategoryID IN
(SELECT CategoryID FROM books GROUP BY CategoryID HAVING COUNT(BookID) > 5)
