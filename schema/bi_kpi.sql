# ************************************************************
# Sequel Pro SQL dump
# Version 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 117.50.8.212 (MySQL 5.7.19)
# Database: bi_kpi
# Generation Time: 2017-09-30 17:34:37 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table active
# ------------------------------------------------------------

DROP TABLE IF EXISTS `active`;

CREATE TABLE `active` (
  `date` datetime NOT NULL,
  `dau` int(11) DEFAULT NULL COMMENT '日活人数',
  `mau` int(11) DEFAULT NULL COMMENT '月活人数',
  `server_id` int(11) NOT NULL COMMENT '服务器id',
  PRIMARY KEY (`date`,`server_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='活跃表';



# Dump of table new_active
# ------------------------------------------------------------

DROP TABLE IF EXISTS `new_active`;

CREATE TABLE `new_active` (
  `date` datetime NOT NULL,
  `server_id` int(11) NOT NULL COMMENT '服务器id',
  `active_num` int(11) NOT NULL DEFAULT '0' COMMENT '新增人数',
  PRIMARY KEY (`date`,`server_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='每日新增用户';



# Dump of table pay
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pay`;

CREATE TABLE `pay` (
  `date` datetime NOT NULL,
  `server_id` int(11) NOT NULL COMMENT '服务器id',
  `pay` int(11) NOT NULL DEFAULT '0' COMMENT '付费汇总',
  PRIMARY KEY (`date`,`server_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='支付汇总表';



# Dump of table pay_number
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pay_number`;

CREATE TABLE `pay_number` (
  `date` datetime NOT NULL,
  `server_id` int(11) NOT NULL COMMENT '服务器id',
  `pay_number` int(11) NOT NULL DEFAULT '0' COMMENT '支付人数',
  PRIMARY KEY (`date`,`server_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='支付人数';



# Dump of table retention
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retention`;

CREATE TABLE `retention` (
  `date` datetime NOT NULL,
  `diff` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `dau` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `rate` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
