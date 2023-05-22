--CREATE TRIGGER TO PRINT NO. OF RECORDS IN BOOK TABLE AFTER EACH INSERT
/*
AFTER : after operation on the table
BEFORE : before operation on table
*/
CREATE or replace TRIGGER T1 AFTER INSERT ON BOOK
DECLARE
N INTEGER;
BEGIN
SELECT COUNT(*) INTO N FROM BOOK;
dbms_output.put_line('no. of records : ' || N);
END;
/

--to select triggers on a paticular table 
select * from all_triggers where table_name='BOOK';

--row and table level triggers
--Table level (executes only once irrespective of how many rows inserted)
--(for update trigger we can specify which columns need to be updated for trigger to be executed
-- if multiple columns are mentioned then trigger will execute when any one of them will be updated )
create or replace trigger t2 before UPDATE of price on book
BEGIN
dbms_output.put_line('table updated');
end;
/

--Row level trigger(executes for each row that is inserted,updated,deleted in table)
create or replace trigger t3 before UPDATE of price on book
for each row
BEGIN
dbms_output.put_line('rows updated');
end;
/

-- :old and :new (to  reference old and new values of the tuple after update)
--here trigger is before update but :old :new is indifferent to before or after operation
create or replace trigger t4 before update of price on book
for each row
BEGIN
dbms_output.put_line('old price : ' || :old.price || 'new price: '|| :new.price);
end;
/


--multi-row update triggers

create or replace trigger t4 after update of name,price on book
for each row
BEGIN
dbms_output.put_line('old price : ' || :old.price || 'new price: '|| :new.price);
dbms_output.put_line('old name : ' || :old.name || 'new name: '|| :new.name);
end;
/
--update book set name = 'bye',price=700;
/*
output:
rows updated
old price : 500new price: 700
old name : hinew name: bye
rows updated
old price : 500new price: 700
old name : hinew name: bye
rows updated
old price : 500new price: 700
old name : hinew name: bye
*/

--CURSORS
/*
Cursors are used to iterate over all tuples from a query
open : allocates memory for cursor
fetch : fetches data from current tuple into variables provided
%notfound : returns true if no more tuples are available
close : destructor
*/
--PRINT BID AND PRICE OF EACH BOOK
CREATE OR REPLACE PROCEDURE curTest as
CURSOR c is select bid,price from book;
id integer;
prc integer;
begin
open c;
loop
exit when c%notfound;
fetch c into id,prc;
dbms_output.put_line('id: '||id||' prc: '||prc);
end loop;
close c;
end;
/

-- implicit cursor
-- sql is implicit system defined cursor
-- %rowcount : gives row count accessed by cursor
-- no open, close required for this sort of cursor
create or replace procedure impCur as
begin
update book set price = 200;
if sql%notfound then
dbms_output.put_line('no books updated');
else 
dbms_output.put_line('no. of rows updated: '||sql%rowcount);
end if;
end;
/

-- remember: Without the where clause,in the update book set price = 200 thing, all records will be updated

/*
create a procedure to print vendor id, vname and no of parts they supply (from labs 6,7)
*/

--noting down the question: write stored procedure to print vid, vname, number of parts they supply for each vendor from the database with tables Vendor, Supply, Part
create or replace procedure vendorPartSupply as
cursor c is select vendor.vid as id,vname,count(pid) as cnt from vendor left outer join supply on vendor.vid = supply.vid group by vendor.vid,vendor.vname;
begin
for sup_data in c
loop
dbms_output.put_line('id : '||sup_data.id ||' name: '||sup_data.vname||' count: '||sup_data.cnt);
end loop;
end;
/

--here the for loop replaces the open, fetch and close. If you try to supplant an open statement along with the for loop, it will gice an error. Without the open statement and with the close statement however, it will work but will ultimately show an error since the cursor would already have been closed once.