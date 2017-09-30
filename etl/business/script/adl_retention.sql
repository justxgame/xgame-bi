-- kpi 留存表表

replace into bi_kpi.retention (server_id,date,diff,dau,num ,rate )
select result.server_id,result.date,result.diff ,result.dau ,result.num , IF(0=dau,0,num/dau) as rate
from (
select list.server_id, list.date,list.diff, IFNULL(dd.dau,0) as dau ,IFNULL(dd.num,0) as num  from (
 select server_id, date,diff from bi.bdl_date join bi.bdl_diff join xgame.server_info where date <= '2017-09-30' and date >= '2017-09-20'
) list
 left join
 (
 	select  a.date , a.dau , r.diff , num  from bi_kpi.active a  left join bi.bdl_retention_num r on a.server_id = r.server_id and a.date = r.first_time
 )  dd  on list.date=dd.date and list.diff=dd.diff
) result



-- 留存表准备

truncate bi.bdl_diff;
insert into bi.bdl_diff (diff) values  (1),(2),(3),(4),(5),(6),(7)