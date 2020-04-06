
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP DATABASE IF EXISTS `iredadmin`;
CREATE DATABASE `iredadmin`;
USE `iredadmin`;

DROP TABLE IF EXISTS `deleted_mailboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_mailboxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `username` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `maildir` varchar(255) NOT NULL DEFAULT '',
  `admin` varchar(255) NOT NULL DEFAULT '',
  `delete_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timestamp` (`timestamp`),
  KEY `username` (`username`),
  KEY `domain` (`domain`),
  KEY `admin` (`admin`),
  KEY `delete_date` (`delete_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `deleted_mailboxes` WRITE;
/*!40000 ALTER TABLE `deleted_mailboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_mailboxes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `domain_ownership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_ownership` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `alias_domain` varchar(255) NOT NULL DEFAULT '',
  `verify_code` varchar(100) NOT NULL DEFAULT '',
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `message` text DEFAULT NULL,
  `last_verify` timestamp NULL DEFAULT NULL,
  `expire` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin` (`admin`,`domain`,`alias_domain`),
  KEY `verified` (`verified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `domain_ownership` WRITE;
/*!40000 ALTER TABLE `domain_ownership` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_ownership` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `admin` varchar(255) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `event` varchar(20) NOT NULL DEFAULT '',
  `loglevel` varchar(10) NOT NULL DEFAULT 'info',
  `msg` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `timestamp` (`timestamp`),
  KEY `admin` (`admin`),
  KEY `ip` (`ip`),
  KEY `domain` (`domain`),
  KEY `username` (`username`),
  KEY `event` (`event`),
  KEY `loglevel` (`loglevel`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2020-04-04 11:10:42','cron_backup_sql','127.0.0.1','','','backup','info','Database: mysql, size: 104K (original: 564K)'),(2,'2020-04-04 11:10:42','cron_backup_sql','127.0.0.1','','','backup','info','Database: vmail, size: 4,0K (original: 24K)'),(3,'2020-04-04 11:10:42','cron_backup_sql','127.0.0.1','','','backup','info','Database: roundcubemail, size: 4,0K (original: 16K)'),(4,'2020-04-04 11:10:42','cron_backup_sql','127.0.0.1','','','backup','info','Database: amavisd, size: 4,0K (original: 12K)');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `newsletter_subunsub_confirms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_subunsub_confirms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mail` varchar(255) NOT NULL DEFAULT '',
  `mlid` varchar(255) NOT NULL DEFAULT '',
  `subscriber` varchar(255) NOT NULL DEFAULT '',
  `kind` varchar(20) NOT NULL DEFAULT '',
  `token` varchar(255) NOT NULL DEFAULT '',
  `expired` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mlid` (`mlid`,`subscriber`,`kind`),
  KEY `mail` (`mail`),
  KEY `token` (`token`),
  KEY `expired` (`expired`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `newsletter_subunsub_confirms` WRITE;
/*!40000 ALTER TABLE `newsletter_subunsub_confirms` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletter_subunsub_confirms` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` char(128) NOT NULL,
  `atime` timestamp NOT NULL DEFAULT current_timestamp(),
  `data` text DEFAULT NULL,
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL DEFAULT 'global',
  `k` varchar(255) NOT NULL,
  `v` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`,`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `k` varchar(255) NOT NULL,
  `v` text DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `k` (`k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatelog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `updatelog` WRITE;
/*!40000 ALTER TABLE `updatelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `updatelog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
