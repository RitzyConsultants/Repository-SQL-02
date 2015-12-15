(select iStockID as LastStockID, iWarehouseID,  MAX(dTxDate) as LastTxDate
from _etblInvCostTracking  where (dTxDate<'2015-04-01') 
group by iStockID, iWarehouseID )
order by istockid

select * from _bvSTTransactionsFull
where Accountlink = 3022

select * from _evInvCostTracking
where iStockid = 3022


select ST.*,GroupByField = '',GroupByFieldCode = '',GroupByFieldDesc = '',SecondGroupByField = '',SecondGroupByFieldCode = '',
       SecondGroupByFieldDesc = '(None)',LineValue = ST.ItemCost * ST.QtyInStock,UnitCost = ST.ItemCost,
	   QtyBalance = ST.QtyInStockExclLots 
	   - IsNull( (select case when ST.ServiceItem = 0 then IsNull(sum (QtyOut),0) else 0 end from _bvSTTransactionsFull 
	   where (AccountLink=S.StockLink) and (IsNull(WarehouseID,0)=IsNull(ST.iWarehouseID,0))  and TxDate<='2015-03-31') 
	   + (select case when ST.ServiceItem = 0 then IsNull(sum (QtyIn), 0) else 0 end from _bvSTTransactionsFull 
	   where (AccountLink=S.StockLink) and (IsNull(WarehouseID,0)=IsNull(ST.iWarehouseID,0))  and TxDate<='2015-03-31'), 0) --- St.fJobQty
from _evInvCostTracking ST join (select iStockID as LastStockID, iWarehouseID,  MAX(dTxDate) as LastTxDate
from _etblInvCostTracking  where (dTxDate<'2015-04-01') 
group by iStockID, iWarehouseID ) CT on ST.StockLink = CT.LastStockID and ST.iWarehouseID = CT.iWarehouseID  
     and ST.dTxDate = CT.LastTxDate Left outer join StkItem S on S.StockLink = ST.StockLink
where ((((ST.Whseitem = 0) or ((ST.Whseitem = 1) and (ST.iWarehouseID > 0)))) and (ST.Code>='#O') and (ST.Code<='Z28') 
  and (ST.ItemActive=1)) and (ST.ServiceItem<>1)
and s.Description_1 = 'Gary'
order by ST.Code

--3022
