# ************************************************************
# Sequel Pro SQL dump
# Version 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 117.50.8.212 (MySQL 5.7.19)
# Database: bi
# Generation Time: 2017-09-30 17:39:52 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table bdl_date
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bdl_date`;

CREATE TABLE `bdl_date` (
  `date` datetime NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;



# Dump of table bdl_diff
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bdl_diff`;

CREATE TABLE `bdl_diff` (
  `diff` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;



# Dump of table bdl_login
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bdl_login`;

CREATE TABLE `bdl_login` (
  `player_id` int(11) unsigned NOT NULL COMMENT '玩家id',
  `server_id` int(11) NOT NULL COMMENT '服务器id',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`player_id`,`server_id`,`login_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;



# Dump of table bdl_mid_tmp
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bdl_mid_tmp`;

CREATE TABLE `bdl_mid_tmp` (
  `date` date NOT NULL,
  `server_id` int(11) NOT NULL,
  UNIQUE KEY `date` (`date`,`server_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;



# Dump of table bdl_pay
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bdl_pay`;

CREATE TABLE `bdl_pay` (
  `id` int(11) unsigned NOT NULL COMMENT 'log id  日志id',
  `player_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `pay_time` datetime NOT NULL COMMENT '充值时间',
  `old_value` bigint(11) NOT NULL COMMENT '充值金额',
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;



# Dump of table bdl_retention_num
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bdl_retention_num`;

CREATE TABLE `bdl_retention_num` (
  `server_id` int(11) NOT NULL COMMENT '服务器id',
  `diff` int(11) NOT NULL COMMENT '几日',
  `first_time` datetime NOT NULL COMMENT '首次登陆时间',
  `num` int(11) NOT NULL COMMENT '留存人数'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='留存人数表';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
