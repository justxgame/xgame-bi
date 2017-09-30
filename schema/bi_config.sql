# ************************************************************
# Sequel Pro SQL dump
# Version 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 117.50.8.212 (MySQL 5.7.19)
# Database: bi_config
# Generation Time: 2017-09-30 17:32:07 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table op_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `op_config`;

CREATE TABLE `op_config` (
  `op_id` int(11) unsigned NOT NULL,
  `op_decribe` varchar(128) DEFAULT '',
  PRIMARY KEY (`op_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

LOCK TABLES `op_config` WRITE;
/*!40000 ALTER TABLE `op_config` DISABLE KEYS */;

INSERT INTO `op_config` (`op_id`, `op_decribe`)
VALUES
	(1,'登陆'),
	(2,'登出'),
	(3,'金币变动'),
	(4,'钻石变动'),
	(5,'门票变动'),
	(6,'兑换券变动'),
	(7,'参加比赛，老的数值为参加比赛的id'),
	(8,'充值'),
	(9,'比赛开始 老的数值为比赛类型（参考配置文件的id字段）'),
	(10,'比赛结束'),
	(11,'比赛解散');

/*!40000 ALTER TABLE `op_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table reason_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reason_config`;

CREATE TABLE `reason_config` (
  `reason_id` int(11) unsigned NOT NULL,
  `reason_describe` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `reason_config` WRITE;
/*!40000 ALTER TABLE `reason_config` DISABLE KEYS */;

INSERT INTO `reason_config` (`reason_id`, `reason_describe`)
VALUES
	(101,'台费'),
	(102,'输赢'),
	(103,'报名扣除'),
	(104,'充值获得'),
	(105,'兑换变动'),
	(110,'每日签到奖励'),
	(111,'GM后台修改');

/*!40000 ALTER TABLE `reason_config` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
