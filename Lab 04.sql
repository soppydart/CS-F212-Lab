--Create the tables and add the records already used in Lab 03.
--Add the following records to DEPT and EMP

INSERT INTO dept VALUES(50, 'MARKETING','BOSTON');
INSERT INTO dept VALUES(60,'PRODUCTION', 'SAN FRANCISCO');

INSERT INTO emp VALUES(7947,'MIKE','CLERK',7900,'18-MAY-85',1500,200,50);
INSERT INTO emp VALUES(7954,'BILL','MANAGER',7782,'20-FEB-81',1000,0,NULL);

--Get employee id, name and department name for those whose name starts with 'J' and has 5 letters.
select e.eno, e.ename, d.dname from emp e, dept d where ename like 'J%' and length(ename) = 5
and e.deptno = d.dnum;

--Get employee id, name and department name for those whose name has 'IN' as substring
select e.eno, e.ename, d.dname from emp e, dept d where ename like '%IN%' and e.deptno = d.dnum;

--Get employee id, name and department name for those whose name has exactly 4 letters
select e.eno, e.ename, d.dname from emp e, dept d where length(ename) = 4 and e.deptno = d.dnum;

--Display emp id, name, deptno, and salary sorted by deptno in ascending order 
--and then by name in descending order
select eno, ename, deptno, sal from emp order by deptno, ename desc;

--Get eid, name, and department name for those not allotted to any department
select eno, ename, deptno from emp where deptno is null;

--Get eid, name, and department name for those not allotted to any department using MINUS operator
select eno, ename, deptno from emp MINUS (select eno, ename, deptno from emp where deptno is not null);

--Get eid, ename and dept name for those whose department is located in BOSTON
--without nested query
select e.eno, e.ename, d.dname from emp e, dept d where d.dloc = 'BOSTON' and
e.deptno = d.dnum;
--using EXISIS
select e.eno, e.ename, d.dname from emp e, dept d where e.deptno = d.dnum 
and exists (select dnum from dept where dloc = 'BOSTON' and e.deptno = dnum);

--Get eid, name and salary for those whose salary is greater than than average salary
select eno, ename, sal from emp where sal>(select avg(sal) from emp);

--Get dnum and dname for those not having any employee working with it
select dnum, dname from dept where dnum IN (select dnum from dept 
MINUS( select unique(deptno) from emp));
--OR
--select d.dnum, d.dname from dept d where NOT EXISTS (select * from emp e where e.deptno = d.dnum);

--For each employee get eid, ename, his manager's id and manager's name
select e.eno, e.ename, e.mgr mgr#, m.ename mgrname from emp e, emp m where e.mgr = m.eno;

--Get eid and ename for those whose managers are working in the SALES department
select eno emp#, ename employee from emp where mgr in (select eno from emp where deptno = 30);

--Get eid, ename for those managed by BLAKE
select eno, ename from emp where mgr in (select eno from emp where ename = 'BLAKE');

--Get eid, ename for those working with 'SALES' department using IN and EXISTS clauses.
select eno, ename from emp where deptno in (select dnum from dept where dname = 'SALES');
--OR
select eno, ename from emp e where exists (select dnum from dept d
where dname = 'SALES' and e.deptno = d.dnum);