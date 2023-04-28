--Creating the table and inserting the data
create table book(
    bid number primary key,
    btitle varchar2(10),
    price number
);

insert into book values (101, 'OPERATIONS', 300);
insert into book values (107, 'DATABASES', 370);
insert into book values (128, 'NETWORKS', 175);

set serveroutput on;


--Procedure
create or replace procedure proc1(arg1 in number,arg2 out number) as n number;
begin
dbms_output.put_line(' :' || arg1 ||' :' || arg2);
n:=arg1+10;
arg2:=60;
dbms_output.put_line(' :' || n || ' :' || arg2);
end;
/

--Execution
declare
m number;
p number;
begin
m:=20;
p:=5;
dbms_output.put_line(' :'|| m || ' :' || p);
proc1(m,p);
dbms_output.put_line(' :' || m || ' :'||p);
end;
/

--  Result
--  :20 :5
--  :20 :
--  :30 :60
--  :20 :60

--Procedure to enter a new book record into the Book table
create or replace procedure proc6(id in number,name in varchar2, pr in number) as
begin
insert into book values(id,name,pr);
dbms_output.put_line('Book:' || id|| ':name:' || name||':added to table');
end;
/

--Execution
exec proc6(144,'Economics',570);

--  Result
--  Book:144:name:Economics:added to table

--Procedure:
--To insert BOOK record into BOOK Table, if the total number of records after the new insertion is even 
--it is okay otherwise print error msg
create or replace procedure proc7(id in number, name in varchar2,pr in number) as
n number:=0;
begin
insert into book values(id,name,pr);
select count(*) into n from book;
select MOD(n,2) into n from dual;
if n<>0 then
dbms_output.put_line('ODD Number of tuples in Book table');
end if;
end;
/

--Execution:
exec proc7(14,'CS',500);

--  Result
--  ODD Number of tuples in Book table

--Procedure:
--Write a procedure that takes bookid as argument and prints the book id : title : is costly/cheap
--costly if price>300 else cheap

create or replace procedure proc8(id in number) as
n number:=0;
Title varchar(10);
begin
select price,title into n,Title from book where bid=id;
if n>300 then
dbms_output.put_line('BookId ' || id|| ' Title'  || Title ||' is costly' );

else
dbms_output.put_line('BookId ' || id|| ' Title' || Title || ' is cheap');
end if;
end;
/

--Execution:
declare
id number;
begin
id:=101;
proc8(id);
end;
/

--  Result
--  BookId 101 Title is cheap


--Procedure:
--USE LOOP TO PRINT NUMBERS IN MULTIPLE OF 10'S

create or replace procedure proc8 as
n number:=10;
begin
loop
dbms_output.put_line('Value of n is : '||n||' ');
n:=n+10;
exit when n>100;
end loop;
end;
/

--Execution:

exec proc8

--Result
--Value of n is : 10 
--Value of n is : 20 
--Value of n is : 30 
--Value of n is : 40 
--Value of n is : 50 
--Value of n is : 60 
--Value of n is : 70 
--Value of n is : 80 
--Value of n is : 90 
--Value of n is : 100 