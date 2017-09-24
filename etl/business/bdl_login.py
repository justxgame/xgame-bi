# !/usr/bin/env python
# -*- coding:utf-8 -*-
# __init__.py

import MySQLdb
import traceback
import dbConfig
import sys
import re
import time
import datetime

# =========================================================#
# 脚本说明 ， 生成 bi的login的中间表
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

sql = "replace into bi.bdl_login (player_id,server_id,login_time) " \
      "select player_id , server_id, DATE_FORMAT(FROM_UNIXTIME(timestamp),'%Y-%m-%d') as login_time  " \
      "from bi_log.bi_log where timestamp > UNIX_TIMESTAMP('{0}') and timestamp  < UNIX_TIMESTAMP('{1}')  " \
      "and op_id = 1 group by player_id , server_id,  login_time"

formatSql = sql.format(startTimeStr,endTimeStr)
print 'login sql=%s' %formatSql

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
