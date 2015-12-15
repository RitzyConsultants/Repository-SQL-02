Updates:

Update lactplan_sls_md
set salesc_lactplan = null,  salesu_lactplan = null, slsx_disc_lactplan = null, slsx_mkd_lactplan = null,
slsx_norm_lactplan = null, slsx_prom_lactplan = null
--Select count (*) from lactplan_sls_md
where b_memb_key NOT in (select memb_key from at_bmdefkey)

Update lactplan_sls_wd
set salesc_lactplan = null,  salesu_lactplan = null, slsx_disc_lactplan = null, slsx_mkd_lactplan = null,
slsx_norm_lactplan = null, slsx_prom_lactplan = null
--Select count (*) from lactplan_sls_md
where b_memb_key NOT in (select memb_key from at_bmdefkey)




select * from lactplan_sls_md
where b_memb_key = 13
and a_memb_key = 2856
and t_memb_key = 474



select * from at_bmdefkey
where group_name = 'COUNTRY_CHAIN'
-- C001ZA 13

select * from at_tmdefkey
where GROUP_NAME = 'MONTH' and memb_name = 'M2015MAY'
-- may 2015 474


select * from at_amdefkey
where group_name = 'DEPARTMENT'
-- D025 - 2856

select * from at_au_bmmap

-- game rsa
select * from lactplan_sls_md
where b_memb_key in 
(select a.memb_key from at_bmdefkey a, at_au_bmmap b 
where p_memb_name = 'C001ZA'
and a.memb_name = b.memb_name)
and a_memb_key = 2856
and t_memb_key = 474
and c_memb_key <> 1

-- all sites -193
select a.*
from lactplan_sls_md a
where a.a_memb_key = 2856
and a.t_memb_key = 474
and a.c_memb_key <> 1
and a.slsx_norm_lactplan = 9776.2


-- back to 184
select a.b_memb_key, b.MEMB_DESCR, a.SLSX_NORM_LACTPLAN
from lactplan_sls_md a, at_bmdefkey b
where a.a_memb_key = 2856
and a.t_memb_key = 474
and a.c_memb_key <> 1
and a.slsx_norm_lactplan = 9776.2
and a.B_MEMB_KEY = b.memb_key


select * from lactplan_sls_md
where b_memb_key in 
(select a.memb_key from at_bmdefkey a, at_au_bmmap b 
where a.memb_name = b.memb_name)
and a_memb_key = 2856
and t_memb_key = 474
and c_memb_key <> 1
and slsx_norm_lactplan = 9776.2

Select * from at_bmdefkey
where memb_key = 68