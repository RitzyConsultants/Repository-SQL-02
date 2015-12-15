-- Bud 16 Dept 205 issue
-- inputC
select --sum(bst.inputc_bud16)
--a.memb_name, A.MEMB_DESCR, b.memb_name, B.MEMB_DESCR, bst.b_memb_key, bst.c_memb_key, bst.t_memb_key, D.MEMB_NAME, to_number(bst.inputc_bud16)
bst.*
from bud16_stk_ws bst,
at_bmdefkey b,
at_amdefkey a,
at_tmdefkey d
where 
bst.b_memb_key = b.memb_key
and a.GROUP_NAME = 'SUBCLASS' and a.MEMB_NAME like 'B205%'
--and b.MEMB_NAME = 'S0010267'
--and bst.inputu_bud16 is not null
and bst.a_memb_key = a.memb_key
and D.MEMB_KEY = BST.T_MEMB_KEY
and bst.t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604') 
                   --between 'W201549' and 'W201752')
--and c_memb_key <> 1 --and b.memb_name like 'S%'

-- closing stock
-- ws
select a.memb_name, b.memb_name, cbst.b_memb_key, cbst.c_memb_key, cbst.t_memb_key, D.MEMB_NAME, cast(CBST.CSTOCKC_BUD16 as number(8,2))
select cbst.* from bud16_cstk_ws cbst,
at_bmdefkey b,
at_amdefkey a,
at_tmdefkey d
where 
cbst.b_memb_key = b.memb_key
and a.GROUP_NAME = 'SUBCLASS' and  a.MEMB_NAME like 'B205%'
--and b.MEMB_NAME = 'S0010267'
and cbst.a_memb_key = a.memb_key
and D.MEMB_KEY = CBST.T_MEMB_KEY
and cbst.t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604')
-- wd
--select a.memb_name, b.memb_name, cbst.b_memb_key, cbst.c_memb_key, cbst.t_memb_key, D.MEMB_NAME, cast(CBST.CSTOCKC_BUD16 as number(8,2))
select cbst.* from bud16_cstk_wd cbst,
at_bmdefkey b,
at_amdefkey a,
at_tmdefkey d
where 
cbst.b_memb_key = b.memb_key
and a.GROUP_NAME = 'DEPARTMENT' and  a.MEMB_NAME = 'D205'
and cbst.a_memb_key = a.memb_key
and D.MEMB_KEY = CBST.T_MEMB_KEY
and cbst.t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604')
-- wc
select cbst.* from bud16_cstk_wc cbst,
at_bmdefkey b,
at_amdefkey a,
at_tmdefkey d
where 
cbst.b_memb_key = b.memb_key
and a.GROUP_NAME = 'CLASS' and  a.MEMB_NAME like 'CL205%'
and cbst.a_memb_key = a.memb_key
and D.MEMB_KEY = CBST.T_MEMB_KEY
and cbst.t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604')


-- salesC
select 
a.memb_name, b.memb_name, sbst.b_memb_key, sbst.c_memb_key, sbst.t_memb_key, D.MEMB_NAME,
SBST.SALESC_BUD16, SBST.SALESXVAT_BUD16
from bud16_sls_ws sbst,
at_bmdefkey b,
at_amdefkey a,
at_tmdefkey d
where 
sbst.b_memb_key = b.memb_key
and a.GROUP_NAME = 'SUBCLASS' and  a.MEMB_NAME = 'B060010002'
and b.MEMB_NAME = 'S0010267'
and sbst.a_memb_key = a.memb_key
and D.MEMB_KEY = SBST.T_MEMB_KEY
and sbst.t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201752')
                   
                   
---- updates
update bud16_stk_ws
set inputc_bud16 = null, inputu_bud16 = null
where t_memb_key in   (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604')
and a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'SUBCLASS' and MEMB_NAME like 'B205%')
and inputc_bud16 is not null 

update bud16_stk_wc
set inputc_bud16 = null, inputu_bud16 = null
where t_memb_key in   (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604')
and a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'CLASS' and MEMB_NAME like 'CL205%')
and inputc_bud16 is not null 

update bud16_stk_wd
set inputc_bud16 = null, inputu_bud16 = null
where t_memb_key in   (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604')
and a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'DEPARTMENT' and MEMB_NAME = 'D205')
and inputc_bud16 is not null 

-- ws
update bud16_cstk_ws
set cstockc_bud16 = null, cstocku_bud16 = null
where t_memb_key in   (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201726')
and a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'SUBCLASS' and MEMB_NAME like 'B205%')
and cstockc_bud16 is not null 

-- wc
update bud16_cstk_wc
set cstockc_bud16 = null, cstocku_bud16 = null
where t_memb_key in   (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201726')
and a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'CLASS' and MEMB_NAME like 'CL205%')
and cstockc_bud16 is not null 

-- wd
update bud16_cstk_wd
set cstockc_bud16 = null, cstocku_bud16 = null
where t_memb_key in   (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201726')
and a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'DEPARTMENT' and MEMB_NAME = 'D205')
and cstockc_bud16 is not null 



------------------
and b_memb_key in (select 
bst.b_memb_key
from bud16_stk_ws bst,
at_bmdefkey b,
at_amdefkey a,
at_tmdefkey d
where 
bst.b_memb_key = b.memb_key
and a.GROUP_NAME = 'SUBCLASS' and a.MEMB_NAME like 'B205%'
and bst.inputc_bud16 is not null
and bst.a_memb_key = a.memb_key
and D.MEMB_KEY = BST.T_MEMB_KEY
and bst.t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604'))
                    

                   
select *
from bud16_stk_ws
where 
a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'SUBCLASS' and MEMB_NAME like 'B205%')
and inputc_bud16 is not null
and t_memb_key in 
                  (select memb_key from at_tmdefkey
                   where group_name = 'WEEK'
                   and memb_name between 'W201549' and 'W201604') 
                   --between 'W201549' and 'W201752')


select * from at_amdefkey where GROUP_NAME = 'SUBCLASS' and MEMB_NAME like 'B205%'
select * from at_amdefkey where GROUP_NAME = 'CLASS' and MEMB_NAME like 'CL205%'
select * from at_amdefkey where GROUP_NAME = 'DEPARTMENT' and MEMB_NAME = 'D205'
select * from at_bmdefkey where memb_key = 139

select *
from bud16_stk_ws
where 
a_memb_key in (select memb_key from at_amdefkey where GROUP_NAME = 'CLASS' and MEMB_NAME like '%205%')

