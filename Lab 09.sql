set serveroutput on;
--in the beginning you have to write the above thing for using dbms_output.put_line 


-- the below 2 examples demonstrate the difference between in and out mthod
create or replace procedure proc1(arg1 in number) as
n number;
begin
n:= arg1+10;
dbms_output.put_line('argument value :' || arg1);
end;
/


create or replace procedure proc1(arg1 in number, arg2 out number ) as
n number;
begin
n:=arg1 + 10;
arg2:=60;
end;
/



--the below method shows the use of in and out method;
declare
m number;
p number;
begin
m:=20;
p:=5;
dbms_output.put_line(' :'||m||' :'||p);
proc1(m,p);
dbms_output.put_line(' :'||m||' :'||p);
end;
/



--below code for in out parameter
create or replace procedure proc1(arg1 in out number)as 
begin
dbms_output.put_line(' argument value: '|| arg1);
arg1:=80;
end;
/

declare 
m number;
begin
m:=20;
dbms_output.put_line(' :'||m);
proc1(m);
dbms_output.put_line(' :'||m);
end;
/



-- the below code if for example 3 in lab sheet 9
create or replace procedure proc7(id in number, name in varchar2, pr in number) as
n number;
begin
insert into book values(id, name, pr);
select count(*) into n from book;
select MOD(n,2) into n from dual;
if n<>0 then
dbms_output.put_line(' ODD Number of tuples in the book table');
end if;
end;
/



--the below one is for example 4
create table EMP (eid number primary key, ename varchar(2), esal number, dno number, foreign key(dno) references dept2 (dnum));
create table Dept2(dnum number primary key, dname varchar(2), total_emps number);

create or replace procedure proc8(id in number, name in varchar2, sal in number, dep in number) as
n number;
begin
insert into emp values(id, name, sal, dep);
select count(*) into n from emp where dno=dep;
update dept2 set total_emps=n where dnum=dep;
dbms_output.put_line(' insert and update done for eid' || id || ' '); 
end;
/



--the below one is for example 5
create or replace procedure proc22(id in number) as 
pr number;
name varchar(10);
begin
select title, price into name, pr from book where bid=id;
dbms_output.put_line('For the book with bid: '|| id|| 'Title is :'||name||' Price is: '||pr);
end;
/


-- the example 6 code is already given in labsheet 9;


-- the below code is for example 7 given in labsheet 9
create or replace function func1(bookid in number) return number is
prc number;
begin
select price into prc from book where bid=bookid;
return prc;
end;
/

declare
n number;
begin
n:=func1(107);
dbms_output.put_line(' '||' price is :'||n);
end;
/

-- the below code is for example 8 given in labsheet 9
create or replace function func2(a in number, b in number) return number is
n number;
begin
n:=a+b;
return n;
end;
/

declare
s number;
begin 
s:=func2(20,10);
dbms_output.put_line(' '|| 'the sum is :'||s);
end;
/



--then you have some built in function given in labsheet 9, you cna try them;

select initcap('hello') from dual;

--translate is for matching the index of two words like given below:-

select translate ('e', 'hello', 'world') from dual;
--output will be o