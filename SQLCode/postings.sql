-- tracking postings
select txdate, DTStamp, username, debit, credit, description, JobCodeLink, WarehouseID, id 
from PostST
where txdate between '2014-09-01' and getdate()
and id = 'JCS' 
and Reference in  ('JOB51056','JOB51057') 
-- 51111, 51112

select txdate, username, count(*)
from PostST
where txdate between '2014-09-01' and getdate()
and id = 'JCS' 
group by txdate, username
order by username, txdate

set rowcount 0

select txdate, id, convert(money,debit) 'dr', convert(money,credit) 'cr', taxtypeid, Reference, 
      convert(money,tax_amount) 'tax', convert(money,fForeignTax), igltaxaccountid, cReference2
from PostGL
where txdate between '2015-02-01' and '2015-02-28' and Reference = '111782'


select convert(money, debit), * 
from postgl
where Reference = '111782'

select * from accounts
where account = '9600'


select a.taxtypeid, b.Description, sum(convert(money,a.debit)) 'dr', sum(convert(money,a.credit)) 'cr',  
      sum(convert(money,a.tax_amount)) 'tax', sum(convert(money,a.fForeignTax)) 'ftax'
from PostGL a, taxrate b
where a.txdate between '2015-02-01' and '2015-02-28'
and a.TaxTypeID = b.idTaxRate
--and AccountLink = '104'
group by a.taxtypeid, b.description

select * from taxrate

select a.taxtypeid, b.Description, sum(convert(money,a.debit)) 'dr', sum(convert(money,a.credit)) 'cr',  
      sum(convert(money,a.tax_amount)) 'tax', sum(convert(money,a.fForeignTax)) 'ftax'
from PostGL a, taxrate b
where a.txdate between '2015-02-01' and '2015-02-28'
--and AccountLink = '104'
and TaxTypeID <> 0
group by a.taxtypeid, b.description
