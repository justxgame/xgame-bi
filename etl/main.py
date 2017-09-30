#!/usr/bin/env python
# -*- coding:utf-8 -*-

import os
import sys
from datetime import date, timedelta ,datetime

# 增加脚本
scriptList = [];
scriptList.append("business/init.py");
scriptList.append("business/bdl_login.py");
scriptList.append("business/bdl_pay.py");
scriptList.append("business/adl_active.py");
scriptList.append("business/adl_pay.py");
scriptList.append("business/adl_retention.py");

#主程序启动
print '['+str(datetime.now()) +"]" + " main start"

if len(sys.argv) != 3:
    print "[mode] = default"
    #yesterday = date.today() - timedelta(1)
    today = date.today()
    tomorrow = date.today() + timedelta(1)
    startTimeStr = today.strftime('%Y-%m-%d')
    endTimeStr = tomorrow.strftime('%Y-%m-%d')
else :
    print "[mode] = custome"
    startTimeStr = sys.argv[1]
    endTimeStr = sys.argv[2]

print '[time args] = startTimeStr=%s,endTimeStr=%s' %(startTimeStr,endTimeStr)

for script in scriptList:   # Python's for loops are a "for each" loop
    print '[%s]-[run script] %s =========================================' %(str(datetime.now()),script)
    os.system("%s %s %s" %(script,startTimeStr,endTimeStr))

print '['+str(datetime.now()) +"]" + " main end"
