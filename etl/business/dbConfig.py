# !/usr/bin/env python
# -*- coding:utf-8 -*-
# __init__.py

import ConfigParser

cf = ConfigParser.ConfigParser()

# cf.read("test.ini")
cf.read("db.ini")

#read by type
db_host = cf.get("db", "db_host")
db_port = cf.getint("db", "db_port")
db_user = cf.get("db", "db_user")
db_pass = cf.get("db", "db_password")

print "db_host:", db_host
print "db_port:", db_port
print "db_user:", db_user
print "db_pass:", db_pass
