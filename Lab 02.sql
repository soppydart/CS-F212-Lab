--Creating the Student table with 'rollno' as the primary key
create table Student(
    rollno number(3,0),
    name varchar(20),
    dob date,
    gender char(1),
    class number(2,0),
    college varchar(20),
    city varchar(20),
    marks number(2,0),
    constraint pk_rollno primary key (rollno)
);

--Inserting 6 records in the student table
insert into Student values(101,'Kiran','10-MAR-1998','M',10,'SBTM','Delhi',67);
insert into Student values(103,'Malini','22-DEC-1997','F',9,'Gandhi Memorial','Mumbai',73);
insert into Student values(104,'Ahmad','18-APR-1998','M',10,'Princeton','Nagpur',50);
insert into Student values(108,'James','30-SEP-1996','M',12,'SBTM','Delhi',77);
insert into Student values(109,'Shivani','11-AUG-1999','F',11,'Stanley','Chennai',46);
insert into Student values(112,'Akul','23-MAR-1993','M',12,'Stanley','Chennai',67);

--Display the information of all the students
select * from Student;

--Display the detailed structure of the student table
desc Student;

--Display rollno, name and class of all students
select rollno,name,class from Student;

--Display rollno, name and marks for students in Delhi colleges
select rollno,name,class from Student where city='Delhi';

--Display details for those born after 01-MAR-1998
select * from Student where dob>'01-MAR-1998';

--Delete the record for Shivani
delete from Student where name='Shivani';

select * from Student;

--Update a record for class 10 and make marks 75
update Student
set marks=75
where class=10;

select * from Student;

--Display rollno and class for all students with labels sid and standard
select rollno as sid, class as standard from Student;

-- Display the average marks
select avg(marks) from Student;

--Compute MIN, MAX, COUNT and SUM of marks
select min(marks), max(marks),count(marks),sum(marks) from Student;

--Get rollno and marks for those having marks between 70 and 75 (both excluded)
select rollno,name from Student where marks>70 and marks<75;

--For all display current marks+10
select marks+10 from Student;

--Get rollno and name for those in Delhi and having marks > 70
select rollno, name from Student where city='Delhi' and marks>70;

--Create the table Book
create table Book(
  bid number,
  title varchar(20)
);

--Inserting the rows
insert into Book values(1,'DBMS TB');
insert into Book values(2,'DSA TB');

--Display the information of all the books
select * from Book;

--Add a column 'price'(int)
alter table Book add price number;

select * from Book;

--Remove the column 'price'
alter table Book drop column price;

select * from Book;