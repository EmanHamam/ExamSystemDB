--Instructor
INSERT INTO Instructor (Instructor_Id, First_Name, Last_Name, Email, HireDate)
VALUES
(1, 'Ahmed', 'Hassan', 'ahmed.hassan@iti.edu.eg', '2018-03-15'),
(2, 'Mohamed', 'Ali', 'mohamed.ali@iti.edu.eg', '2019-07-10'),
(3, 'Sara', 'Mahmoud', 'sara.mahmoud@iti.edu.eg', '2020-01-20'),
(4, 'Omar', 'Khaled', 'omar.khaled@iti.edu.eg', '2017-11-05'),
(5, 'Mona', 'Adel', 'mona.adel@iti.edu.eg', '2021-06-01'),
(6, 'Youssef', 'Samir', 'youssef.samir@iti.edu.eg', '2016-09-18'),
(7, 'Nour', 'Ibrahim', 'nour.ibrahim@iti.edu.eg', '2022-02-12'),
(8, 'Kareem', 'Tarek', 'kareem.tarek@iti.edu.eg', '2015-12-03');

--Instructor_Phone
INSERT INTO Instructor_Phone (Instructor_Id, Phone)
VALUES
(1, '01012345678'),
(1, '01223456789'),
(2, '01134567890'),
(3, '01098765432'),
(4, '01287654321'),
(5, '01111223344'),
(6, '01055667788'),
(7, '01266778899'),
(8, '01199887766');

--Department
INSERT INTO Department (Id, Dept_Name, Instructor_Id)
VALUES
(1, 'Programming', 1),
(2, 'Design', 3),
(3, 'Business', 5),
(4, 'Engineering', 6);

--Track
INSERT INTO Track (Id,Track_Name, Intake_Year, Dept_id)
VALUES
(1,'Web Development', 2025, 1),
(2,'Data Science', 2025, 1),
(3,'Mobile Development', 2025, 1),
(4,'AI and Machine Learning', 2025, 1),
(5,'Cyber Security', 2025, 1),
(6,'Cloud Computing', 2025, 1),
(7,'Blockchain Development', 2025, 1),
(8,'Game Development', 2025, 1),
(9,'DevOps', 2025, 1),
(10,'Software Engineering', 2025, 1),
(11,'Full Stack Development', 2025, 1),
(12,'Big Data', 2025, 1),
(13,'Quality Assurance', 2025, 1),
(14,'Automation Testing', 2025, 1),
(15,'Database Administration', 2025, 1),
(16,'VR/AR Development', 2025, 1),
(17,'SAP Programming', 2025, 1),
(18,'UI/UX Design', 2025, 2),
(19,'Project Management', 2025, 3),
(20,'Digital Marketing', 2025, 3),
(21,'IT Management', 2025, 3),
(22,'Entrepreneurship', 2025, 3),
(23,'HR Analytics', 2025, 3),
(24,'Salesforce Administration', 2025, 3),
(25,'Supply Chain Management', 2025, 3),
(26,'Operations Research', 2025, 3),
(27,'Energy Management', 2025, 3),
(28,'Embedded Systems', 2025, 4),
(29,'Networking', 2025, 4),
(30,'IOT', 2025, 4);

--Instructor_Track
INSERT INTO Instructor_Track (Instructor_Id, Track_Id)
VALUES
(1,1),(1,10),
(2,2),(2,4),
(3,1),
(4,3),
(5,6),(5,10),
(6,5),(6,6),
(7,2),(7,4),
(8,6),(8,9);

-- Course 
INSERT INTO Course (Id,Course_Name)
VALUES 
(3,'Advanced JavaScript'),
(4,'React Development'),
(5,'Node.js'),
(6,'Python for Data Science'),
(7,'Machine Learning'),
(8,'Deep Learning'),
(9,'Cyber Security Basics'),
(10,'Cloud Fundamentals'),
(11,'Blockchain Basics'),
(12,'Solidity Development'),
(13,'Game Design Basics'),
(14,'Unity Development'),
(15,'CI/CD Pipelines'),
(16,'Microservices Architecture'),
(17,'Agile Development'),
(18,'Android Development'),
(19,'iOS Development'),
(20,'Cross-platform Mobile Development'),
(21,'Database Fundamentals'),
(22,'SQL for Beginners'),
(23,'Data Warehousing'),
(24,'Big Data Tools'),
(25,'Intro to AWS'),
(26,'Azure Cloud Computing'),
(27,'Web Security Essentials'),
(28,'PHP Development'),
(29,'Ruby on Rails'),
(30,'Advanced C++ Programming');


--Topic
INSERT INTO Topic (Id, Topic_Name, Course_ID)
VALUES
(1, 'Introduction to HTML', 1),
(2, 'CSS Styling Basics', 1),
(3, 'Responsive Design', 1),
(4, 'Variables in JavaScript', 2),
(5, 'Loops and Functions', 2),
(6, 'DOM Manipulation', 2),
(7, 'ES6 Features', 3),
(8, 'Asynchronous JavaScript', 3),
(9, 'Error Handling', 3),
(10, 'Hooks in React', 4),
(11, 'State Management', 4),
(12, 'Redux Basics', 4),
(13, 'Express.js Basics', 5),
(14, 'Working with Databases', 5),
(15, 'REST API Development', 5),
(16, 'Data Preprocessing', 6),
(17, 'Data Visualization', 6),
(18, 'Pandas Basics', 6);

--Course_Track
INSERT INTO Course_Track (Course_Id, Track_Id)
VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),
(6,2),(21,2),(22,2),(23,2),(24,2),
(7,4),(8,4),(6,4),
(18,3),(19,3),(20,3),
(9,5),(27,5),
(10,6),(25,6),(26,6),
(11,7),(12,7),
(13,8),(14,8),
(15,9),(16,9),
(17,10),(16,10),(30,10);

INSERT INTO Student (Id, FName, LName, Email, Enrollment_Date, Track_Id)
VALUES
(1, 'Omar', 'Hany', 'omar.hany@student.edu.eg', '2025-09-15', 1),
(2, 'Yara', 'Mostafa', 'yara.mostafa@student.edu.eg', '2025-09-15', 1),
(3, 'Khaled', 'Nabil', 'khaled.nabil@student.edu.eg', '2025-09-15', 1),
(4, 'Salma', 'Adel', 'salma.adel@student.edu.eg', '2025-09-16', 2),
(5, 'Mahmoud', 'Essam', 'mahmoud.essam@student.edu.eg', '2025-09-16', 2),
(6, 'Nada', 'Samir', 'nada.samir@student.edu.eg', '2025-09-16', 2),
(7, 'Hassan', 'Fathy', 'hassan.fathy@student.edu.eg', '2025-09-17', 3),
(8, 'Farah', 'Ibrahim', 'farah.ibrahim@student.edu.eg', '2025-09-17', 3),
(9, 'Ahmed', 'Wael', 'ahmed.wael@student.edu.eg', '2025-09-18', 4),
(10, 'Reem', 'Tamer', 'reem.tamer@student.edu.eg', '2025-09-18', 4),
(11, 'Mostafa', 'Ashraf', 'mostafa.ashraf@student.edu.eg', '2025-09-18', 5),
(12, 'Dina', 'Hesham', 'dina.hesham@student.edu.eg', '2025-09-18', 5),
(13, 'Karim', 'Osama', 'karim.osama@student.edu.eg', '2025-09-19', 6),
(14, 'Mariam', 'Nader', 'mariam.nader@student.edu.eg', '2025-09-19', 6),
(15, 'Youssef', 'Hatem', 'youssef.hatem@student.edu.eg', '2025-09-19', 7),
(16, 'Shahd', 'Ayman', 'shahd.ayman@student.edu.eg', '2025-09-20', 8),
(17, 'Amr', 'Samy', 'amr.samy@student.edu.eg', '2025-09-20', 9),
(18, 'Laila', 'Khalil', 'laila.khalil@student.edu.eg', '2025-09-21', 10),
(19, 'Tarek', 'Magdy', 'tarek.magdy@student.edu.eg', '2025-09-21', 10),
(20, 'Huda', 'Raouf', 'huda.raouf@student.edu.eg', '2025-09-21', 10);

--Student_Phone
INSERT INTO Student_Phone (Student_Id, Phone)
VALUES
(1, '01011223344'),
(1, '01222334455'),
(2, '01133445566'),
(3, '01055667788'),
(4, '01266778899'),
(4, '01177889900'),
(5, '01099887766'),
(6, '01244556677'),
(7, '01122334455'),
(8, '01033445566'),
(9, '01255667788'),
(10, '01166778899'),
(11, '01077889900'),
(12, '01288990011'),
(13, '01199001122'),
(14, '01010111222'),
(15, '01212131415'),
(16, '01114151617'),
(17, '01016171819'),
(18, '01218192021'),
(19, '01120212223'),
(20, '01021222324');

--Questions
INSERT INTO Question (Question_Id, Ques_Description, Grade, Course_Id)
VALUES
(1, 'You are designing a website layout using CSS. You want the container to take 50% of screen width. Which CSS property achieves this?', 2, 1),
(2, 'Which HTML element is used to create a hyperlink?', 1, 1),
(3, 'What CSS property is used to change the text color of an element?', 1, 1),
(4, 'Which tag is used to group together form controls in HTML?', 1, 1),
(5, 'In CSS, how do you center a block element horizontally?', 1, 1),
(6, 'Which CSS property removes default bullets from ul?', 1, 1),
(7, 'Which HTML tag is used for the largest heading?', 1, 1),
(8, 'How do you add a comment in CSS?', 1, 1),
(9, 'Which HTML attribute is used for inline styles?', 1, 1),
(10, 'Correct syntax for external CSS file?', 1, 1),
(11, 'Correct HTML5 doctype?', 1, 1),
(12, 'Default value of CSS position property?', 1, 1),
(13, 'CSS property for space between lines?', 1, 1),
(14, 'HTML attribute to make input required?', 2, 1),
(15, 'CSS property to hide element but keep space?', 1, 1),
(16, 'HTML attribute for inline JavaScript?', 2, 1),
(17, 'What does z-index control?', 1, 1),
(18, 'Which is NOT valid HTML tag?', 1, 1),
(19, 'Default display of div?', 1, 1),
(20, 'CSS property for background color?', 1, 1),
(21, 'How to write comment in HTML?', 1, 1),
(22, 'CSS property for space inside border?', 1, 1),
(23, 'p { color: blue } does what?', 1, 1),
(24, 'HTML element for division?', 1, 1),
(25, 'opacity:0.5 does what?', 1, 1),
(26, 'Tag to embed image?', 1, 1),
(27, 'float:left does what?', 1, 1),
(28, 'Unit relative to root element?', 1, 1),
(29, 'Selector for class header?', 1, 1),
(30, 'Attribute for image path?', 1, 1),
(31, 'Invisible but takes space?', 1, 1),
(32, 'How to create ordered list?', 1, 1),
(33, 'Position relative to nearest ancestor?', 1, 1),
(34, 'Correct table syntax?', 1, 1),
(35, 'CSS property for border thickness?', 1, 1),
(36, 'HTML element for metadata?', 1, 1),
(37, 'Select all p inside div?', 1, 1),
(38, 'CSS property for flex item order?', 1, 1),
(39, 'Valid HTML5 semantic element?', 2, 1),
(40, 'Space outside border?', 1, 1),
(41, 'HTML tag for video?', 1, 1),
(42, 'Purpose of calc() in CSS?', 1, 1),
(43, 'Correct way to include JS file?', 1, 1),
(44, 'What does box-shadow do?', 1, 1),
(45, 'HTML5 footer tag?', 1, 1),
(46, 'Flex property to grow element?', 1, 1),
(47, 'Attribute for link URL?', 1, 1),
(48, 'Element for clickable button?', 1, 1),
(49, 'CSS property for rounded corners?', 2, 1),
(50, 'HTML5 tag for navigation?', 1, 1),
(51, 'Which is NOT a valid JS data type?', 2, 2),
(52, 'Correct syntax to create function in JS?', 2, 2),
(53, 'State management works in React.', 1, 4),
(54, 'Command to start a Node.js server?', 1, 5),
(55, 'Command to initialize Git repo?', 1, 6),
(56, 'Library used for deep learning in Python?', 2, 7),
(57, 'Key components of cloud architecture?', 2, 10),
(58, 'What does SQL stand for?', 2, 12),
(59, 'CSS stands for Cascading Style Sheets.', 1, 1),
(60, 'JavaScript is a statically typed language.', 1, 2),
(61, 'React uses a virtual DOM to improve performance.', 1, 4),
(62, 'Node.js can be used for backend development.', 1, 5),
(63, 'Python is commonly used in data science.', 1, 6),
(64, 'Machine learning requires labeled data in all cases.', 1, 7),
(65, 'Cloud computing eliminates the need for physical servers.', 1, 10),
(66, 'Solidity is used to write smart contracts on Ethereum.', 1, 12);

INSERT INTO Question (Question_Id, Ques_Description, Grade, Course_Id)
VALUES
(67, 'HTML is used to structure the content of a webpage.', 1, 1),
(68, 'CSS can be used to change the layout of multiple web pages at once.', 1, 1),
(69, 'The <title> tag is placed inside the <body> section.', 1, 1),
(70, 'Inline CSS has higher priority than external CSS.', 1, 1),
(71, 'The <img> tag requires a closing tag.', 1, 1),
(72, 'CSS Flexbox is mainly used for one-dimensional layouts.', 1, 1),
(73, 'The id attribute in HTML must be unique within a page.', 1, 1),
(74, 'You can apply multiple classes to the same HTML element.', 1, 1),
(75, 'The z-index property only works on positioned elements.', 1, 1),
(76, 'Media queries are used in CSS to create responsive designs.', 1, 1);


-- TrueFalse_Question
INSERT INTO TrueFalse_Question (QuestionTF_Id, Correct_Answer)
VALUES
(53, 1), 
(59, 1), 
(60, 0), 
(61, 1), 
(62, 1), 
(63, 1), 
(64, 0), 
(65, 0), 
(66, 1); 

INSERT INTO TrueFalse_Question (QuestionTF_Id, Correct_Answer)
VALUES
(67, 1), 
(68, 1), 
(69, 0), 
(70, 1), 
(71, 0), 
(72, 1), 
(73, 1), 
(74, 1), 
(75, 1), 
(76, 1); 


--MCQ_Question
INSERT INTO MCQ_Question (QuestionMCQ_Id)
VALUES
(1),(2),(4),(3),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),
(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),
(51),(52),(54),(55),(56),(57),(58);

INSERT INTO MCQ_Option (Option_Id, Option_text, Is_Correct, Question_Id) VALUES
-- Q1
(1,'width: 50px;',0,1),(2,'width: 50%;',1,1),(3,'max-width: 50%;',0,1),(4,'min-width: 50%;',0,1),
-- Q2
(5,'<link>',0,2),(6,'<a>',1,2),(7,'<href>',0,2),(8,'<button>',0,2),
-- Q3
(9,'font-size',0,3),(10,'background-color',0,3),(11,'color',1,3),(12,'text-color',0,3),
-- Q4
(13,'<div>',0,4),(14,'<form>',0,4),(15,'<fieldset>',1,4),(16,'<section>',0,4),
-- Q5
(17,'margin: auto;',1,5),(18,'text-align: center;',0,5),(19,'position: center;',0,5),(20,'align: middle;',0,5),
-- Q6
(21,'list-style: none;',1,6),(22,'display: block;',0,6),(23,'text-decoration: none;',0,6),(24,'remove-bullets: true;',0,6),
-- Q7
(25,'<heading>',0,7),(26,'<h1>',1,7),(27,'<h6>',0,7),(28,'<head>',0,7),
-- Q8
(29,'// comment',0,8),(30,'<!-- comment -->',0,8),(31,'/* comment */',1,8),(32,'# comment',0,8),
-- Q9
(33,'class',0,9),(34,'id',0,9),(35,'style',1,9),(36,'css',0,9),
-- Q10
(37,'<link rel="stylesheet" href="style.css">',1,10),(38,'<css href="style.css">',0,10),(39,'<style src="style.css">',0,10),(40,'<stylesheet link="style.css">',0,10),
-- Q11
(41,'<!DOCTYPE html>',1,11),(42,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">',0,11),(43,'<!DOCTYPE h5>',0,11),(44,'<DOCTYPE html>',0,11),
-- Q12
(45,'relative',0,12),(46,'absolute',0,12),(47,'fixed',0,12),(48,'static',1,12),
-- Q13
(49,'line-height',1,13),(50,'text-indent',0,13),(51,'font-spacing',0,13),(52,'letter-spacing',0,13),
-- Q14
(53,'placeholder',0,14),(54,'required',1,14),(55,'value',0,14),(56,'validate',0,14),
-- Q15
(57,'visibility: hidden',1,15),(58,'display:none',0,15),(59,'opacity:0',0,15),(60,'hide',0,15),
-- Q16
(61,'onclick',1,16),(62,'onload',0,16),(63,'script',0,16),(64,'href',0,16),
-- Q17
(65,'Transparency',0,17),(66,'Horizontal position',0,17),(67,'Stacking order',1,17),(68,'Width',0,17),
-- Q18
(69,'<em>',0,18),(70,'<strong>',0,18),(71,'<break>',1,18),(72,'<br>',0,18),
-- Q19
(73,'inline',0,19),(74,'block',1,19),(75,'inline-block',0,19),(76,'flex',0,19),
-- Q20
(77,'color',0,20),(78,'background-color',1,20),(79,'bg-color',0,20),(80,'fill',0,20),

-- Q21
(81,'<!-- This is a comment -->',1,21),(82,'// This is a comment',0,21),(83,'/* This is a comment */',0,21),(84,'# This is a comment',0,21),
-- Q22
(85,'padding',1,22),(86,'margin',0,22),(87,'border-spacing',0,22),(88,'spacing',0,22),
-- Q23
(89,'Sets paragraph background to blue',0,23),(90,'Sets paragraph text color to blue',1,23),(91,'Sets paragraph border color to blue',0,23),(92,'Makes paragraph bold',0,23),
-- Q24
(93,'<section>',0,24),(94,'<div>',1,24),(95,'<article>',0,24),(96,'<span>',0,24),
-- Q25
(97,'Makes element fully transparent',0,25),(98,'Makes element 50% transparent',1,25),(99,'Makes element wider',0,25),(100,'Removes element from layout',0,25),
-- Q26
(101,'<img>',1,26),(102,'<image>',0,26),(103,'<picture>',0,26),(104,'<src>',0,26),
-- Q27
(105,'Centers element',0,27),(106,'Moves element left and allows text wrapping',1,27),(107,'Hides element',0,27),(108,'Moves element to top',0,27),
-- Q28
(109,'em',0,28),(110,'px',0,28),(111,'rem',1,28),(112,'%',0,28),
-- Q29
(113,'#header {}',0,29),(114,'.header {}',1,29),(115,'header {}',0,29),(116,'*header {}',0,29),
-- Q30
(117,'href',0,30),(118,'src',1,30),(119,'alt',0,30),(120,'link',0,30),
-- Q31
(121,'display: none;',0,31),(122,'visibility: hidden;',1,31),(123,'opacity: 0;',0,31),(124,'float: none;',0,31),
-- Q32
(125,'<ul>',0,32),(126,'<ol>',1,32),(127,'<li>',0,32),(128,'<list>',0,32),
-- Q33
(129,'absolute',1,33),(130,'relative',0,33),(131,'fixed',0,33),(132,'static',0,33),
-- Q34
(133,'<table><tr><td>Data</td></tr></table>',1,34),(134,'<table><row><data>Data</data></row></table>',0,34),(135,'<table><tr><th>Data</th></tr></table>',0,34),(136,'<table><tr><td><td>Data</td></tr></table>',0,34),
-- Q35
(137,'border-width',1,35),(138,'border-height',0,35),(139,'border-thickness',0,35),(140,'border-style',0,35),
-- Q36
(141,'<meta>',1,36),(142,'<head>',0,36),(143,'<header>',0,36),(144,'<info>',0,36),
-- Q37
(145,'p div {}',0,37),(146,'div p {}',1,37),(147,'.div p {}',0,37),(148,'div + p {}',0,37),
-- Q38
(149,'flex-direction',0,38),(150,'order',1,38),(151,'align-items',0,38),(152,'flex-grow',0,38),
-- Q39
(153,'<span>',0,39),(154,'<article>',1,39),(155,'<div>',0,39),(156,'<section>',0,39),
-- Q40
(157,'padding',0,40),(158,'border-spacing',1,40),(159,'margin',0,40),(160,'border-width',0,40),
-- Q41
(161,'<media>',1,41),(162,'<video>',0,41),(163,'<embed>',0,41),(164,'<movie>',0,41),
-- Q42
(165,'To apply dynamic styling based on user input.',0,42),(166,'To calculate mathematical expressions for property values.',1,42),(167,'To animate elements based on time values.',0,42),(168,'To control the order of execution in the browser.',0,42),
-- Q43
(169,'<script src="script.js"></script>',1,43),(170,'<js href="script.js"></js>',0,43),(171,'<script link="script.js"></script>',0,43),(172,'<link rel="javascript" href="script.js">',0,43),
-- Q44
(173,'Adds a shadow inside the border of an element.',0,44),(174,'Adds a shadow outside the border of an element.',1,44),(175,'Increases the width of the border.',0,44),(176,'Controls the visibility of the element.',0,44),
-- Q45
(177,'<footer>',1,45),(178,'<bottom>',0,45),(179,'<section>',0,45),(180,'<end>',0,45),
-- Q46
(181,'flex-grow',1,46),(182,'flex-wrap',0,46),(183,'align-content',0,46),(184,'justify-content',0,46),
-- Q47
(185,'target',0,47),(186,'href',1,47),(187,'rel',0,47),(188,'src',0,47),
-- Q48
(189,'<input>',0,48),(190,'<button>',1,48),(191,'<a>',0,48),(192,'<div>',0,48),
-- Q49
(193,'border-radius',1,49),(194,'border-corner',0,49),(195,'corner-radius',0,49),(196,'border-style',0,49),
-- Q50
(197,'<nav>',1,50),(198,'<header>',0,50),(199,'<aside>',0,50),(200,'<menu>',0,50),
-- Q51
(201,'String',0,51),(202,'Boolean',0,51),(203,'Number',0,51),(204,'Character',1,51),
-- Q52
(205,'function = myFunction()',0,52),(206,'function:myFunction()',0,52),(207,'function myFunction()',1,52),(208,'func myFunction()',0,52),
-- Q54
(209,'node start',0,54),(210,'npm start',1,54),(211,'node run',0,54),(212,'start server',0,54),
-- Q55
(213,'git start',0,55),(214,'git init',1,55),(215,'git create',0,55),(216,'git new',0,55),
-- Q56
(217,'NumPy',0,56),(218,'Pandas',0,56),(219,'Matplotlib',0,56),(220,'TensorFlow',1,56),
-- Q57
(221,'Servers only',0,57),(222,'Databases only',0,57),(223,'Compute, Storage, Networking',1,57),(224,'Internet only',0,57),
-- Q58
(225,'Structured Query Language',1,58),(226,'Simple Query Language',0,58),(227,'Sequential Query Logic',0,58),(228,'System Query Level',0,58);





--Exam
INSERT INTO Exam (Exam_Name, EXDate, Duration)
VALUES
('DB','2026-01-30', 2),
('C++','2026-02-01', 3),
('C#','2026-02-05', 1),
('JS','2026-02-10', 3),
('HTML','2026-02-15', 2);

-- Exam_Question
INSERT INTO Exam_Question(Exam_Id, Question_ID)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(3, 8),
(4, 9),
(4, 10),
(5, 11),
(5, 12),
(5, 13),
(5, 14),
(5, 15);

--Student_Question_Exam
INSERT INTO Student_Question_Exam(Student_ID, Exam_ID, Question_ID, Student_Answer, Student_Grade)
VALUES
(1, 1, 1, 1, 0),
(1, 1, 2, 3, 0),
(2, 1, 3, 1, 5),
(3, 2, 4, 1, 5),
(3, 2, 5, 2, 5),
(4, 3, 6, 3, 5),
(5, 4, 7, 2, 5),
(6, 4, 8, 1, 5),
(7, 5, 9, 2, 5),
(8, 5, 10, 1, 5);

--STUDENT_EXAM
INSERT INTO STUDENT_EXAM (Student_ID, Exam_ID, Total_Grade)
VALUES
(1, 1, 50),
(2, 1, 45),
(3, 2, 40),
(4, 2, 35),
(5, 3, 50),
(6, 3, 45),
(7, 4, 40),
(8, 4, 38),
(9, 5, 49),
(10, 5, 44);
