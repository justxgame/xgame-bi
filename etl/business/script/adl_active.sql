  --sql 1生成每日DAU kpi表
  replace into bi_kpi.active (date,dau,server_id) select  DATE_FORMAT(login_time,'%Y-%m-%d') as date, count(*) as dau,
  server_id from bi.bdl_login where login_time > STR_TO_DATE('2017-09-20', '%Y-%m-%d')
  and login_time  < STR_TO_DATE('2017-09-25', '%Y-%m-%d') group by date , server_id


  -- sql2 生成每日新增用户 KPI表
    replace into bi_kpi.new_active (date,server_id,active_num)
   select  DATE_FORMAT(login_time,'%Y-%m-%d') as date,  server_id , count(*) as active_num from
    (
    	select server_id , player_id , min(login_time) as login_time from bi.bdl_login
    	 where login_time > STR_TO_DATE('2017-09-20', '%Y-%m-%d') and login_time  < STR_TO_DATE('2017-09-30', '%Y-%m-%d')
    	 group by player_id ,server_id
    ) as active_all_table  group by date , server_id