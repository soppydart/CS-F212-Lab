--Creating the tables and adding the data
create table part(pid int primary key, pname varchar(10), price int);
create table vendor(vid int primary key, vname varchar(10), vloc varchar(10));
create table supply(pid int, vid int, qty int, constraint pk primary key(pid,vid), foreign key (pid) references part 
(pid), foreign key (vid) references vendor(vid));

INSERT INTO part VALUES(101, 'Scale',30);
INSERT INTO part VALUES(104, 'Sketch',10);
INSERT INTO part VALUES(105, 'Tape',15);
INSERT INTO part VALUES(107, 'Pad',160);
INSERT INTO part VALUES(110, 'Ink',25);
INSERT INTO part VALUES(112, 'Pin',5);
INSERT INTO part VALUES(124, 'Chalk',120);
INSERT INTO part VALUES(135, 'Paper',80);

INSERT INTO vendor VALUES(3, 'Crown','Delhi');
INSERT INTO vendor VALUES(5, 'Topper','Delhi');
INSERT INTO vendor VALUES(7, 'Avon','Mumbai');
INSERT INTO vendor VALUES(11, 'Swan','Hyderabad');
INSERT INTO vendor VALUES(13, 'Rally','Chennai');
INSERT INTO vendor VALUES(15, 'Buddy','Chennai');

INSERT INTO supply VALUES(104, 7, 420);
INSERT INTO supply VALUES(104,13, 380);
INSERT INTO supply VALUES(105,13, 350);
INSERT INTO supply VALUES(107, 5, 500);
INSERT INTO supply VALUES(107, 11, 200);
INSERT INTO supply VALUES(107, 7, 10);
INSERT INTO supply VALUES(110, 3, 22);
INSERT INTO supply VALUES(110, 5, 35);
INSERT INTO supply VALUES(110, 13, 150);
INSERT INTO supply VALUES(110, 15, 20);
INSERT INTO supply VALUES(124, 7, 300);
INSERT INTO supply VALUES(124, 11, 34);
INSERT INTO supply VALUES(124, 13, 12);

--Get pid, pname for those not supplied by any vendor
select pid, pname from part minus (select part.pid, part.pname from part, supply where part.pid = supply.pid);

--Get pid, pname which are supplied by all vendoes from DELHI
select p.pid, p.pname,v.vloc from part p, supply s, vendor v where p.pid = s.pid and s.vid = v.vid and v.vloc = 'Delhi'
group by p.pid, p.pname, v.vloc having count(*)=(select count(*) from vendor where vloc='Delhi' group by vloc);

--Get for Delhi based vendor vid and name if they supply atleast 3 parts
select s.vid, v.vname from vendor v, supply s where s.vid = v.vid and vloc = 'Delhi' 
group by s.vid, v.vname having count (pid) >= 3;

--Get vid, vname for those vendors not supplying any/some part with price greater than 100
select vid, vname from vendor where vid not in 
(select vid from supply where pid in (select pid from part where price>100));

--For each part get pid, pname and number of 'Chennai' based vendors supplying it
select p.pid, p.pname, count(*) from part p, supply s where p.pid=s.pid and s.vid in 
(select vid from vendor where vloc='Chennai') group by p.pid, p.pname;

--Get vid, vname for those vendors supplying all parts with price greater than 100
select v.vid, v.vname from vendor v, supply s where v.vid = s.vid and s.pid in 
(select p.pid from part p where p.price>100) group by v.vid, v.vname 
having count(*)=(select count(*) from part p where p.price>100);

--For each part get pid, pname and number of vendors supplying it
select p.pid, p.pname, count(vid) from part p, supply where p.pid = supply.pid group by p.pid, p.pname;

--Get vendor id , vname if they are supplying at least 3 parts
select v.vid, v.vname from vendor v, supply s where v.vid = s.vid group by v.vid,v.vname having count(*) >= 3;

--Get vid, vname for those supplying part ‘Pad’
select v.vid, v.vname from vendor v, supply s where v.vid = s.vid and pid in(select pid from part where pname = 'Pad');

--Get vid, vname for those supplying at least one part in qty greater than 250.
select v.vid, v.vname from vendor v, supply s where v.vid = s.vid and qty > 250 group by v.vid, v.vname;

--Get vid, vname and number parts they supply with qty greater than 100.
select v.vid, v.vname, count (*) from vendor v, supply s where v.vid = s.vid and qty > 100 group by v.vid, v.vname;