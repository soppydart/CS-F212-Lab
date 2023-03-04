--Using the same tables and records used in Lab 04

--Get maximum, minimum and average salary for dept no 10
select max(sal), min(sal), avg(sal) from emp group by deptno having deptno = 10;

--Print the total number of employees in dept 10 and 20 separately
select deptno, count(*) from emp group by deptno having deptno in (10,20);

--Print total salary paid to clerks
select sum(sal) from emp where job = 'CLERK';

--For each job, print job, number of employees and average salary
select job, count(*), avg(sal) from emp group by job;

--Get eid, ename, dname for those whose names end with 'EN' or 'ER'
select e.eno, e.ename, d.dname from emp e, dept d where e.deptno = d.dnum 
and e.ename like '%EN' or e.ename like '%ER' and e.deptno = d.dnum;

--Perform explicit join, left outer join, right outer join, full outer join
--on EMP and DEPT and observer the results
--FULL OUTER JOIN
select e.eno, d.dname from emp e full join dept d on e.deptno = d.dnum;

--Get the eid, ename and manager name for the employees working in the SALES department
select e1.eno, e1.ename, e2.ename from emp e1, emp e2, dept d where e1.mgr = e2.eno
and e1.deptno = d.dnum and d.dname = 'SALES';
--using explicit join
select e.eno, e.ename, m.ename as mgrname from emp e join emp m on e.mgr = m.eno
join dept d on e.deptno = d.dnum where d.dname = 'SALES';

--Get the eid, ename and manager name for the employees working in SALES department (use IN operator)
select e.eno, e.ename, m.ename from emp e, emp m where e.mgr = m.eno and e.deptno IN
(select dnum from dept where dname = 'SALES');

--For each department print dnum, dname and number of employees whose salary is greater than 1300.
select d.dnum, d.dname, count(*) from emp e, dept d where e.deptno = d.dnum and 
e.sal >= 1300 group by d.dnum, d.dname;

--For each department having at least 5 employees, print dnum, dname and the number of employees woking in that department
select dnum, dname, count(*) from emp join dept on deptno = dnum group by dnum, dname having count(*) >= 5;

--Print eid, ename for those who are managing at least one employee
select m.eno, m.ename from emp e join emp m on e.mgr = m.eno group by m.eno, m.ename having count(e.eno) > 0;

--For each employee print eid, ename and the number of employees he manages (only for those managing at least one employee)
select m.eno, m.ename, count(*) from emp e join emp m on e.mgr = m.eno group by m.eno, m.ename;

--Get eid, ename for those who do not get any commission
select eno, ename from emp where comm is null or comm = 0;

--Get eid, ename for those not working with the sales dept
select eno, ename from emp, dept where dname != 'SALES' and emp.deptno = dept.dnum;

--Get eid, ename for those not working in a company located in BOSTON
select e.eno, e.ename from emp e, dept d where d.dloc <> 'BOSTON' and e.deptno = d.dnum;

--For each employee get eid, name and their manager id and name
select e.eno, e.ename, m.eno as mgr#, m.ename as mgrname from emp e, emp m where e.mgr = m.eno;

--For employees having salary > 2500 get eid, ename and sal
select eno, ename, sal from emp where sal > 2500;

--For employees having salary > 2500 get eid, ename and sal using EXISTS
select eno, ename, sal from emp a where exists (select * from emp b where a.sal > 2500 and a.eno = b.eno);