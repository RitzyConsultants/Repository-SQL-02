--select * from Accounts
--ORDER BY Master_Sub_Account


select 'Not REV - January 2015', round(sum(a.debit),2), round(sum(a.credit),2) 
from _bvGLTransactionsFull a, Accounts b
where a.AccountLink = b.AccountLink
and a.AccountLink in (757, 18)
and a.TxDate between '2015-01-01' and '2015-01-31' and a.cReference2 not like 'REV%'

select 'REV - January 2015', round(sum(a.debit),2), round(sum(a.credit),2) 
from _bvGLTransactionsFull a, Accounts b
where a.AccountLink = b.AccountLink
and a.AccountLink in (757, 18)
and a.TxDate between '2015-01-01' and '2015-01-31' and a.cReference2 like 'REV%'

select 'Not REV - February 2015', round(sum(a.debit),2), round(sum(a.credit),2) 
from _bvGLTransactionsFull a, Accounts b
where a.AccountLink = b.AccountLink
and a.AccountLink in (757, 18)
and a.TxDate between '2015-02-01' and '2015-02-28' and a.cReference2 not like 'REV%'

select 'REV - February 2015', round(sum(a.debit),2), round(sum(a.credit),2) 
from _bvGLTransactionsFull a, Accounts b
where a.AccountLink = b.AccountLink
and a.AccountLink in (757, 18)
and a.TxDate between '2015-02-01' and '2015-02-28' and a.cReference2 like 'REV%'

-- all
select left(a.Account,20) 'acc', left(a.AccountDesc,25) 'accdesc', left(a.cReference2,15) 'ref', a.TxDate, convert(money,a.debit), convert(money,a.credit)
from _bvGLTransactionsFull a, Accounts b
where a.AccountLink = b.AccountLink
and a.AccountLink in (757,18)
and a.TxDate between '2015-01-01' and '2015-02-28'
