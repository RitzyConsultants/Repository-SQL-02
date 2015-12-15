select * from postgl
where accountlink in (2304,1278) 
--1278 2304
-- 8647,65698,13648,146173,209479

update postgl
set accountlink = 1278
where autoidx = 209479


select * from accounts
where Master_Sub_Account = '8200.010'


select * from _bvGLTransactionsFull
where  autoidx in (8647,65698,13648,146173,209479)


