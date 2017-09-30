#!/usr/bin/env python
# -*- coding:utf-8 -*-

import MySQLdb
import traceback
import dbConfig
import sys

# =========================================================#
# 脚本说明 ， 1. 生成 kpi的 active          // 日活表
#            2. 生成 kpi的 new_active表    //每日新增
# 参数:
#       1, 起始时间 例:  2017-09-20
#       2, 结束时间 例:  2017-09-25
# =========================================================#

print 'args:', str(sys.argv)

# 参数个数不对，退出
if len(sys.argv) != 3:
    print "parameter is error ,exit "
    sys.exit(1)

argDateFormat = "%Y-%m-%d"
startTimeStr = sys.argv[1]
endTimeStr = sys.argv[2]

print 'startTimeStr=%s' %startTimeStr
print 'endTimeStr=%s' %endTimeStr

#startDate = datetime.datetime.strptime(startTimeStr, argDateFormat).date()
#endDate = datetime.datetime.strptime(endTimeStr, argDateFormat).date()

sql1 = "replace into bi_kpi.pay (date,server_id,pay) " \
       "select tmp.date,tmp.server_id,IFNULL(result.pay,0) as pay from bi.bdl_mid_tmp tmp left join " \
       "( select  DATE_FORMAT(pay_time,'%Y-%m-%d') as date,server_id , sum(old_value) as pay " \
       " from bi.bdl_pay where pay_time >= STR_TO_DATE('{0}', '%Y-%m-%d') and " \
       "pay_time  <= STR_TO_DATE('{1}', '%Y-%m-%d') group by date , server_id) " \
       "result on tmp.date = result.date and tmp.server_id = result.server_id"

formatSql1 = sql1.format(startTimeStr,endTimeStr)
print 'pay sql1=%s' %formatSql1

sql2 = "replace into bi_kpi.pay_number (date,server_id,pay_number) " \
       "select tmp.date,tmp.server_id,IFNULL(result.pay_number,0) as pay_number " \
       "from bi.bdl_mid_tmp tmp left join" \
       " (select DATE_FORMAT(pay_time,'%Y-%m-%d') as date,server_id ," \
       "  count(*) as pay_number  from bi.bdl_pay " \
       " where pay_time >= STR_TO_DATE('{0}', '%Y-%m-%d') " \
       " and pay_time  <= STR_TO_DATE('{1}', '%Y-%m-%d') " \
       " group by date , server_id) result on tmp.date = result.date and tmp.server_id = result.server_id"

formatSql2 = sql2.format(startTimeStr,endTimeStr)
print 'pay sql2=%s' %formatSql2

# 打开数据库连接
db = MySQLdb.connect(host=dbConfig.db_host, user=dbConfig.db_user,
                     port=dbConfig.db_port, passwd=dbConfig.db_pass)
try:
    cursor = db.cursor()
    cursor.execute(formatSql1)
    ret = cursor.fetchone()
    print "result1 = %s" % ret

    cursor.execute(formatSql2)
    ret = cursor.fetchone()
    print "result2 = %s" % ret

except:
    print "Error: unable to fecth data"
    traceback.print_exc()

# 关闭数据库连接
db.close()