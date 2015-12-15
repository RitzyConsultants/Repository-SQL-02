SELECT * from _bvPurchaseOrdersFull
where OrderNum = 'PO0299'


select AccountID,iInvoiceID,idInvoiceLines,OrderNum,Account,DocVersion,OrderDate,Code,WarehouseCode,fQuantity,UOMUnitCode,fQtyProcessed,DocState,idNotes,INVNum_iBranchID
from _bvPurchaseOrdersFull left join _btblNotes on (upper(_btblNotes.cNOTETBLTableName) = upper('INVNum')) 
and (_btblNotes.cNOTETBLTableID = cast(iInvoiceID as varchar(20))) left join _etblBranch on (INVNum_iBranchID=idBranch)
where (OrderNum>='PO0299') and (OrderNum<='PO0299') and (OrderDate<='2015-03-18') and ((DocState in (1,2,3,4,7,9))
)
