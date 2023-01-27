--Creating the table with 'sid' as the primary key
create table Student(
    sid number(3,0),
    name varchar(10),
    age number(2,0),
    constraint pk_Student primary key (sid)
);

--Description of the table
desc Student;

--Inserting the rows
insert into Student values(101,'Raju',20);
insert into Student values(103,'John',19);
insert into Student values(104,'Mohan',21);
insert into Student values(107,'Mary',20);

--Fetch the values of all the columns available
select * from Student;

--Fetch values from 1 column
select name from Student;

--Fetch values from multiple columns
select sid,name from Student;

--Filter records
select * from Student where age=20;

insert into Student values(110,'Jane',25);

select * from Student;

--Updating the last added row
update Student
set name='Kate', age=24
where sid=110;

select * from Student;

--Deleting the last added row
delete from Student where sid=110;

select * from Student;

--To save the changes
commit;