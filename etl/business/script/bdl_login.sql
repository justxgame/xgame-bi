  --sql1 生成 bdl login表

  replace into bi.bdl_login (player_id,server_id,login_time )
  select  player_id , server_id, DATE_FORMAT(FROM_UNIXTIME(timestamp),'%Y-%m-%d') as login_time
  from bi_log.bi_log where timestamp > UNIX_TIMESTAMP('2017-09-15') and timestamp  < UNIX_TIMESTAMP('2017-09-25')  and op_id = 1
  group by player_id , server_id,  login_time


  -- sql 2 生成 bdl retention 表
   replace into bi.bdl_retention_num  (num,server_id,first_time,diff)
   select count(*) as num , mid.server_id , mid.login_time , mid.diff from
   (
   select a.player_id ,a.server_id, a.login_time, datediff(b.login_time,a.login_time) as diff
    from bdl_login a inner join bdl_login b on  a.player_id = b.player_id   and a.server_id = b.server_id
    ) mid
   where diff > 0 group by diff ,login_time , server_id
