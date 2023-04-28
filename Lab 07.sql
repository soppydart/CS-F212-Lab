--Use the tables created in Lab 06

--Get pid, pname for those not supplied by any vendor and having price greater than average price
select p.pid, p.pname from part p where pid not in 
(select distinct pid from supply) and price > (select avg (price) from part);

--Get pid, pname for tose not supplied by any vendors from 'Chennai'
select p.pid, p.pname from part p where not exists 
(select * from vendor v, supply s where s.vid = v.vid and p.pid = s.pid and vloc = 'Chennai');

--Get vid and name for vendors not supplying any part with price>100
select v.vid, v.vname from vendor v where v.vid not in 
(select s.vid from supply s, part p where p.pid = s.pid  and p.price > 100);

--Get vid and name for vendors not supplying atleast one part where the name starts with 'S'
select v.vid, v.vname from vendor v, supply s where v.vid = s.vid minus 
(select v.vid, v.vname from vendor v, supply s where v.vid = s.vid and s.pid in 
(select pid from part where pname like 'S%') group by v.vid, v.vname);

--For each vendor get vid, vname and the number of parts he is supplying with qty>=200
select v.vid, v.vname, count (*) from vendor v, supply s 
where v.vid = s.vid and qty >= 200 group by v.vid, v.vname;

--Create a view with name PVS to have partid, part_name, vendorid, vendor_name and qty as attributes
create view PVS as select part.pid as partid, pname as part_name, vendor.vid as vendorid, vname as vendor_name, qty 
from part, vendor, supply where part.pid = supply.pid and vendor.vid = supply.vid;

--On the above view PVS write query to get vendorid, vname and total_qty only for those from Delhi. 
--In subquery, never use Supply table, may use other tables if necessary
select vendorid, vendor_name, sum(qty) as total_qty from pvs, vendor v 
where v.vid = vendorid and vloc = 'Delhi' group by vendorid, vendor_name;