select * from invnum
where invnumber = 'INR37808'

update invnum
set invdate = '2015-10-16', orderdate = '2015-10-16', duedate = '2015-10-16', DeliveryDate = '2015-10-16'
where invnumber = 'INR37808'

select * from _btblinvoicelines
where iinvoiceid =  37487

update _btblinvoicelines
set dDeliveryDate = '2015-10-16'
where idinvoicelines in (92612,92613)

select * from postAR
where reference = 'INR37808'

update postAR
set txdate = '2015-10-16'
where autoidx = 45081

select * from postgl
where Reference = 'INR37808'

update postgl
set txdate = '2015-10-16'
where Reference = 'INR37808'

