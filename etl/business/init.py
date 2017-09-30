#!/usr/bin/env python
# -*- coding:utf-8 -*-

import MySQLdb
import traceback
import dbConfig
import sys

# =========================================================#
# 脚本说明 ， 生成 临时的中间表
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


sql1=  "replace into bi.bdl_date(date) select date from " \
       "(" \
       "select adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) date from " \
       "(select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0," \
       "(select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1," \
       "(select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2," \
       " (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3," \
       " (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4" \
       ")" \
       "v where date >='{0}' and date< '{1}'"

formatSql1 = sql1.format(startTimeStr,endTimeStr)
print 'init sql1=%s' %formatSql1


sql2 = "truncate bi.bdl_mid_tmp;"
formatSql2 = sql2.format(startTimeStr,endTimeStr)
print 'init sql2=%s' %formatSql2

sql3 = "insert into bi.bdl_mid_tmp (date,server_id) " \
      "select date,server_id from bi.bdl_date join xgame.server_info  " \
      "where date >= STR_TO_DATE('{0}', '%Y-%m-%d') and date < STR_TO_DATE('{1}', '%Y-%m-%d')"

formatSql3 = sql3.format(startTimeStr,endTimeStr)
print 'init sql3=%s' %formatSql3

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


    cursor.execute(formatSql3)
    ret = cursor.fetchone()
    print "result3 = %s" % ret

except:
    print "Error: unable to fecth data"
    traceback.print_exc()

# 关闭数据库连接
db.close()