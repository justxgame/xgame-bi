  -- 生成login表

  replace into bi.bdl_login (player_id,server_id,login_time )
  select  player_id , server_id, DATE_FORMAT(FROM_UNIXTIME(timestamp),'%Y-%m-%d') as login_time
  from bi_log.bi_log where timestamp > UNIX_TIMESTAMP('2017-09-15') and timestamp  < UNIX_TIMESTAMP('2017-09-25')  and op_id = 1
  group by player_id , server_id,  login_time

  -- 生成kpi表

  replace into bi_kpi.active (date,dau,server_id) select  DATE_FORMAT(login_time,'%Y-%m-%d') as date, count(*) ,
  server_id as dau from bi.bdl_login where login_time > STR_TO_DATE('2017-09-20', '%Y-%m-%d')
  and login_time  < STR_TO_DATE('2017-09-25', '%Y-%m-%d') group by date , server_id