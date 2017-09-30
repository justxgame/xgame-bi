#!/usr/bin/env python
# -*- coding:utf-8 -*-

import MySQLdb
import traceback
import dbConfig
import sys

# =========================================================#
# 脚本说明 ， 1. 生成 kpi的 retention       // 留存表
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


sql1= "truncate bi.bdl_diff"

print 'retention sql1=%s' %sql1

sql2= "insert into bi.bdl_diff (diff) values  (1),(2),(3),(4),(5),(6),(7)"

print 'retention sql2=%s' %sql2

sql3 = "replace into bi_kpi.retention (server_id,date,diff,dau,num ,rate ) " \
       "select result.server_id,result.date,result.diff ,result.dau ,result.num , IF(0=dau,0,num/dau) as rate " \
       "from ( select list.server_id, list.date,list.diff, IFNULL(dd.dau,0) as dau ,IFNULL(dd.num,0) as num  from (" \
       " select server_id, date,diff from bi.bdl_date join bi.bdl_diff join xgame.server_info " \
       " where date <= '{1}' and date >= '{0}') list " \
       "left join" \
       " ( select  a.date , a.dau , r.diff , num  from bi_kpi.active a  " \
       "left join bi.bdl_retention_num r on a.server_id = r.server_id and a.date = r.first_time)  " \
       "dd  on list.date=dd.date and list.diff=dd.diff) result"

formatSql3 = sql3.format(startTimeStr,endTimeStr)
print 'retention sql3=%s' %formatSql3

# 打开数据库连接
db = MySQLdb.connect(host=dbConfig.db_host, user=dbConfig.db_user,
                     port=dbConfig.db_port, passwd=dbConfig.db_pass)
try:
    cursor = db.cursor()
    cursor.execute(sql1)
    cursor.execute(sql2)
    cursor.execute(formatSql3)
    ret = cursor.fetchone()
    print "result1 = %s" % ret

except:
    print "Error: unable to fecth data"
    traceback.print_exc()

# 关闭数据库连接
db.close()