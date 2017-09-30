  --sql1 生成 bdl pay 表

  replace into bi.bdl_pay (id,player_id,server_id,pay_time,old_value )
  select  id,player_id , server_id, DATE_FORMAT(FROM_UNIXTIME(timestamp),'%Y-%m-%d') as pay_time , old_value
  from bi_log.bi_log where timestamp > UNIX_TIMESTAMP('2017-09-15') and timestamp  < UNIX_TIMESTAMP('2017-09-30')  and op_id = 8
  and op_result=0