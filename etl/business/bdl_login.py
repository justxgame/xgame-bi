#!/usr/bin/env python
# -*- coding:utf-8 -*-

import MySQLdb
import traceback
import dbConfig
import sys

# =========================================================#
# 脚本说明 ， 生成 bdl 的 login的中间表
#           生成 bdl 的 retention表
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

sql1 = "replace into bi.bdl_login (player_id,server_id,login_time) " \
      "select player_id , server_id, DATE_FORMAT(FROM_UNIXTIME(timestamp),'%Y-%m-%d') as login_time  " \
      "from bi_log.bi_log where op_result=0 and timestamp >= UNIX_TIMESTAMP('{0}') and timestamp  <= UNIX_TIMESTAMP('{1}')  " \
      "and op_id = 1 and op_result=0 group by player_id , server_id,  login_time"

formatSql1 = sql1.format(startTimeStr,endTimeStr)
print 'login1 sql=%s' %formatSql1

sql2 = " replace into bi.bdl_retention_num  (num,server_id,first_time,diff) select count(*) as num , mid.server_id , mid.login_time , mid.diff from " \
       "( select a.player_id ,a.server_id, a.login_time, datediff(b.login_time,a.login_time) as diff " \
       "from bi.bdl_login a inner join bi.bdl_login b on  a.player_id = b.player_id  and a.server_id = b.server_id) mid " \
       "where diff >= 0 group by diff ,login_time , server_id"

formatSql2 = sql2.format(startTimeStr,endTimeStr)
print 'login2 retention sql=%s' %formatSql2

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