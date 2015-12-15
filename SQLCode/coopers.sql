
select PeriodEndDate,idPeriod,dPeriodDate
from _bvGLPeriodsFull
order by idPeriod

select *
from _evTaxBoxReport
where (TxDate >= '2015-02-01') and (TxDate <= '2015-02-28') and (iBoxNumber > 0) and ((isnull(BranchID,0) = 0))
order by  iBoxNumber, TaxTypeId 

