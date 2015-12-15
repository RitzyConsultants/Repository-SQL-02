--EXEC cAllocs_Seperator @FROM_DATE = '2010-01-01', @TO_DATE = '2014-12-31'

select * from temp_allocation
where allocamountF is not null

order by accountlink
