  --sql 1生成每日付费汇总表
  replace into bi_kpi.pay (date,server_id,pay)
  select  DATE_FORMAT(pay_time,'%Y-%m-%d') as date, server_id, sum(old_value) as pay
  from bi.bdl_pay where pay_time > STR_TO_DATE('2017-09-20', '%Y-%m-%d')
  and pay_time  < STR_TO_DATE('2017-09-30', '%Y-%m-%d') group by date , server_id

    --sql 2 生成每日付费人数
    replace into bi_kpi.pay_number (date,server_id,pay_number)
    select DATE_FORMAT(pay_time,'%Y-%m-%d') as date,server_id , count(*) as pay_number
    from bi.bdl_pay where pay_time > STR_TO_DATE('2017-09-20', '%Y-%m-%d')
    and pay_time  < STR_TO_DATE('2017-09-30', '%Y-%m-%d') group by date , server_id