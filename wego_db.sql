# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.16)
# Database: wego
# Generation Time: 2016-11-17 02:46:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table drinks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drinks`;

CREATE TABLE `drinks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `drinks` WRITE;
/*!40000 ALTER TABLE `drinks` DISABLE KEYS */;

INSERT INTO `drinks` (`id`, `name`)
VALUES
	(1,'Espresso'),
	(2,'Latte'),
	(3,'Capuccino'),
	(4,'Green Tea'),
	(5,'Hot Tea');

/*!40000 ALTER TABLE `drinks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table menus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `menus`;

CREATE TABLE `menus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `drink_id` int(11) unsigned NOT NULL,
  `type_id` int(11) unsigned NOT NULL,
  `size_id` int(11) unsigned NOT NULL,
  `price` float(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `menu_type_fk` (`type_id`),
  KEY `menu_size_fk` (`size_id`),
  KEY `menu_drink_fk` (`drink_id`),
  CONSTRAINT `menu_drink_fk` FOREIGN KEY (`drink_id`) REFERENCES `drinks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_size_fk` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_type_fk` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;

INSERT INTO `menus` (`id`, `drink_id`, `type_id`, `size_id`, `price`)
VALUES
	(1,1,1,1,1.95),
	(2,1,1,2,2.05),
	(3,1,1,3,2.35),
	(4,2,1,1,3.40),
	(5,2,1,2,4.45),
	(6,2,1,3,4.65),
	(7,3,1,1,3.15),
	(8,3,1,2,3.75),
	(9,3,1,3,4.15),
	(10,4,2,1,3.45),
	(11,4,2,2,4.25),
	(12,4,2,3,4.45),
	(13,5,2,2,1.95);

/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) unsigned NOT NULL,
  `status_id` int(11) unsigned NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `price` float(11,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_menu_fk` (`menu_id`),
  KEY `order_status_fk` (`status_id`),
  CONSTRAINT `order_menu_fk` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_status_fk` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;

INSERT INTO `orders` (`id`, `menu_id`, `status_id`, `quantity`, `price`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,1,2,1,0.00,NULL,NULL,NULL),
	(29,5,2,2,8.90,'2016-11-15 15:13:18','2016-11-15 15:13:18',NULL),
	(30,11,2,4,17.00,'2016-11-15 17:50:32','2016-11-15 17:50:32',NULL),
	(31,5,2,2,8.90,'2016-11-15 19:08:36','2016-11-15 19:08:36',NULL),
	(32,5,2,2,8.90,'2016-11-16 11:04:47','2016-11-16 11:04:47',NULL),
	(33,5,1,3,13.35,'2016-11-16 11:05:44','2016-11-16 11:05:44',NULL),
	(34,5,2,3,13.35,'2016-11-16 11:07:00','2016-11-16 11:07:00',NULL),
	(35,5,2,3,13.35,'2016-11-16 11:08:49','2016-11-16 11:08:49',NULL);

/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sizes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sizes`;

CREATE TABLE `sizes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;

INSERT INTO `sizes` (`id`, `name`)
VALUES
	(1,'Tall'),
	(2,'Grande'),
	(3,'Venti');

/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `statuses`;

CREATE TABLE `statuses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;

INSERT INTO `statuses` (`id`, `name`)
VALUES
	(1,'Ice'),
	(2,'Hot');

/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `types`;

CREATE TABLE `types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;

INSERT INTO `types` (`id`, `name`)
VALUES
	(1,'Coffee'),
	(2,'Tea');

/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
