#!/usr/bin/env python
# -*- coding:utf-8 -*-

import MySQLdb
import traceback
import dbConfig
import sys

# =========================================================#
# 脚本说明 ， 生成 kpi的 active
# 参数:
#       1, 其实时间 例:  2017-09-20
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

sql = "replace into bi_kpi.active (date,dau,server_id) " \
      "select DATE_FORMAT(login_time,'%Y-%m-%d') as date, count(*) , server_id as dau from bi.bdl_login " \
      "where login_time >= STR_TO_DATE('{0}', '%Y-%m-%d') and login_time  < STR_TO_DATE('{1}', '%Y-%m-%d') " \
      "group by date , server_id "

formatSql = sql.format(startTimeStr,endTimeStr)
print 'active sql=%s' %formatSql

# 打开数据库连接
db = MySQLdb.connect(host=dbConfig.db_host, user=dbConfig.db_user,
                     port=dbConfig.db_port, passwd=dbConfig.db_pass)
try:
    cursor = db.cursor()
    cursor.execute(formatSql)
    ret = cursor.fetchone()
    print "result = %s" % ret

except:
    print "Error: unable to fecth data"
    traceback.print_exc()

# 关闭数据库连接
db.close()