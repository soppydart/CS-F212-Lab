--Creating the tables DEPT, and EMP
create table DEPT(
    dnum number primary key,
    dname varchar(20),
    dloc varchar(10)
);
create table EMP(
    eno number primary key,
    ename varchar(15),
    job varchar(10),
    mgr number references EMP(eno),            
    hiredate date,
    sal number,
    comm number,
    deptno number references DEPT(dnum)
);

--Inserting the records in DEPT and EMP
INSERT INTO dept VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES (20,'RESEARCH','DALLAS');
INSERT INTO dept VALUES (30,'SALES','CHICAGO');
INSERT INTO dept VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO emp VALUES (7839,'KING','PRESIDENT',NULL,'17-NOV-81',5000,NULL,10);
INSERT INTO emp VALUES (7782,'CLARK','MANAGER',7839,'09-JUN-81',2450,NULL,10);
INSERT INTO emp VALUES (7566,'JONES','MANAGER',7839,'02-APR-81',2975,NULL,20);
INSERT INTO emp VALUES (7698,'BLAKE','MANAGER',7839,'01-MAY-81',2850,NULL,30);
INSERT INTO emp VALUES (7934,'MILLER','CLERK',7782,'23-JAN-82',1300,NULL,10);
INSERT INTO emp VALUES (7499,'ALLEN','SALESMAN',7698,'20-FEB-81',1600,300,30);
INSERT INTO emp VALUES (7521,'WARD','SALESMAN',7698,'22-FEB-81',1250,500,30);
INSERT INTO emp VALUES (7654,'MARTIN','SALESMAN',7698,'28-SEP-81',1250,1400,30);
INSERT INTO emp VALUES (7844,'TURNER','SALESMAN',7698,'08-SEP-81',1500,0,30);
INSERT INTO emp VALUES (7900,'JAMES','CLERK',7698,'03-DEC-81',950,NULL,30);
INSERT INTO emp VALUES (7788,'SCOTT','ANALYST',7566,'19-APR-87',3000,NULL,20);
INSERT INTO emp VALUES (7902,'FORD','ANALYST',7566,'03-DEC-81',3000,NULL,20);
INSERT INTO emp VALUES (7369,'SMITH','CLERK',7902,'17-DEC-80',800,NULL,20);
INSERT INTO emp VALUES (7876,'ADAMS','CLERK',7788,'23-MAY-87',1100,NULL,20);

--Select all details from emp
select * from emp;

--Select only eno and ename from emp
select eno, ename from emp;

--Select details of all employees who are clerks
select * from emp where job='CLERK';

--Show eno, name, sal for emp who are managers


--Display eno, ename, hiredate of emps who joined after 01-06-1981
select eno, ename, hiredate from emp where hiredate > '01-JUN-81';

--Display eno, ename, sal, dno of emps in ascending order based on dno
select eno, ename, sal, deptno from emp order by deptno ASC;

--Display eno, ename, sal, dno of emps in descending order based on dno
select eno, ename, sal, deptno from emp order by deptno DESC;

--Display eno, ename, sal, dno of emps in ascending order based on dno descending order based on sal
select eno, ename, sal, deptno from emp order by deptno ASC, sal DESC;

--Display the employee names of the clerks with salary > 2000
select ename from emp where job = 'CLERK' and sal > 2000;

--Display the details of all employees whose salaries are between 1000 and 1500
select * from emp where sal> 1000 and sal< 1500;

--Display the details of all employees with deptno 10 or 30
select * from emp where deptno = 10 or deptno = 30;

--Display maximum, minimum, and average salary of all employees with deptno 10
select max(sal), min(sal), avg(sal) from emp where deptno = 10;

--Display total number of employees working in deptno 20
select count(eno) from emp where deptno = 20;

--Display the total salary paid to clerks
select sum(sal) from emp where job='CLERK';