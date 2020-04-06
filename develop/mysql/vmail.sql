
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
DROP DATABASE IF EXISTS `vmail`;
CREATE DATABASE `vmail`;
USE `vmail`;

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `language` varchar(5) NOT NULL DEFAULT '',
  `passwordlastchange` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `settings` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`username`),
  KEY `passwordlastchange` (`passwordlastchange`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alias` (
  `address` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `accesspolicy` varchar(30) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`address`),
  KEY `domain` (`domain`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `alias` WRITE;
/*!40000 ALTER TABLE `alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `alias` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `alias_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alias_domain` (
  `alias_domain` varchar(255) NOT NULL,
  `target_domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`alias_domain`),
  KEY `target_domain` (`target_domain`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `alias_domain` WRITE;
/*!40000 ALTER TABLE `alias_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `alias_domain` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `anyone_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anyone_shares` (
  `from_user` varchar(255) NOT NULL,
  `dummy` char(1) DEFAULT '1',
  PRIMARY KEY (`from_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `anyone_shares` WRITE;
/*!40000 ALTER TABLE `anyone_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `anyone_shares` ENABLE KEYS */;
UNLOCK TABLES;
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
  KEY `id` (`id`),
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
DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `domain` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `disclaimer` text DEFAULT NULL,
  `aliases` int(10) NOT NULL DEFAULT 0,
  `mailboxes` int(10) NOT NULL DEFAULT 0,
  `maillists` int(10) NOT NULL DEFAULT 0,
  `maxquota` bigint(20) NOT NULL DEFAULT 0,
  `quota` bigint(20) NOT NULL DEFAULT 0,
  `transport` varchar(255) NOT NULL DEFAULT 'dovecot',
  `backupmx` tinyint(1) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`domain`),
  KEY `backupmx` (`backupmx`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` VALUES ('wolfetti.example',NULL,NULL,0,0,0,0,0,'dovecot',0,'default_user_quota:1024;','2020-04-04 15:08:03','1970-01-01 01:01:01','9999-12-31 00:00:00',1);
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `domain_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_admins` (
  `username` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `domain` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`username`,`domain`),
  KEY `username` (`username`),
  KEY `domain` (`domain`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `domain_admins` WRITE;
/*!40000 ALTER TABLE `domain_admins` DISABLE KEYS */;
INSERT INTO `domain_admins` VALUES ('postmaster@wolfetti.example','ALL','2020-04-04 15:08:03','1970-01-01 01:01:01','9999-12-31 00:00:00',1);
/*!40000 ALTER TABLE `domain_admins` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `forwardings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forwardings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL DEFAULT '',
  `forwarding` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `dest_domain` varchar(255) NOT NULL DEFAULT '',
  `is_maillist` tinyint(1) NOT NULL DEFAULT 0,
  `is_list` tinyint(1) NOT NULL DEFAULT 0,
  `is_forwarding` tinyint(1) NOT NULL DEFAULT 0,
  `is_alias` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`,`forwarding`),
  KEY `domain` (`domain`),
  KEY `dest_domain` (`dest_domain`),
  KEY `is_maillist` (`is_maillist`),
  KEY `is_list` (`is_list`),
  KEY `is_alias` (`is_alias`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `forwardings` WRITE;
/*!40000 ALTER TABLE `forwardings` DISABLE KEYS */;
INSERT INTO `forwardings` VALUES (1,'postmaster@wolfetti.example','postmaster@wolfetti.example','wolfetti.example','wolfetti.example',0,0,1,0,1);
/*!40000 ALTER TABLE `forwardings` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `last_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_login` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `last_login` int(11) DEFAULT NULL,
  PRIMARY KEY (`username`),
  KEY `domain` (`domain`),
  KEY `last_login` (`last_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `last_login` WRITE;
/*!40000 ALTER TABLE `last_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `last_login` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `mailbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailbox` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `language` varchar(5) NOT NULL DEFAULT '',
  `mailboxformat` varchar(50) NOT NULL DEFAULT 'maildir',
  `mailboxfolder` varchar(50) NOT NULL DEFAULT 'Maildir',
  `storagebasedirectory` varchar(255) NOT NULL DEFAULT '/var/vmail',
  `storagenode` varchar(255) NOT NULL DEFAULT 'vmail1',
  `maildir` varchar(255) NOT NULL DEFAULT '',
  `quota` bigint(20) NOT NULL DEFAULT 0,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `transport` varchar(255) NOT NULL DEFAULT '',
  `department` varchar(255) NOT NULL DEFAULT '',
  `rank` varchar(255) NOT NULL DEFAULT 'normal',
  `employeeid` varchar(255) DEFAULT '',
  `isadmin` tinyint(1) NOT NULL DEFAULT 0,
  `isglobaladmin` tinyint(1) NOT NULL DEFAULT 0,
  `enablesmtp` tinyint(1) NOT NULL DEFAULT 1,
  `enablesmtpsecured` tinyint(1) NOT NULL DEFAULT 1,
  `enablepop3` tinyint(1) NOT NULL DEFAULT 1,
  `enablepop3secured` tinyint(1) NOT NULL DEFAULT 1,
  `enablepop3tls` tinyint(1) NOT NULL DEFAULT 1,
  `enableimap` tinyint(1) NOT NULL DEFAULT 1,
  `enableimapsecured` tinyint(1) NOT NULL DEFAULT 1,
  `enableimaptls` tinyint(1) NOT NULL DEFAULT 1,
  `enabledeliver` tinyint(1) NOT NULL DEFAULT 1,
  `enablelda` tinyint(1) NOT NULL DEFAULT 1,
  `enablemanagesieve` tinyint(1) NOT NULL DEFAULT 1,
  `enablemanagesievesecured` tinyint(1) NOT NULL DEFAULT 1,
  `enablesieve` tinyint(1) NOT NULL DEFAULT 1,
  `enablesievesecured` tinyint(1) NOT NULL DEFAULT 1,
  `enablesievetls` tinyint(1) NOT NULL DEFAULT 1,
  `enableinternal` tinyint(1) NOT NULL DEFAULT 1,
  `enabledoveadm` tinyint(1) NOT NULL DEFAULT 1,
  `enablelib-storage` tinyint(1) NOT NULL DEFAULT 1,
  `enablequota-status` tinyint(1) NOT NULL DEFAULT 1,
  `enableindexer-worker` tinyint(1) NOT NULL DEFAULT 1,
  `enablelmtp` tinyint(1) NOT NULL DEFAULT 1,
  `enabledsync` tinyint(1) NOT NULL DEFAULT 1,
  `enablesogo` tinyint(1) NOT NULL DEFAULT 1,
  `allow_nets` text DEFAULT NULL,
  `lastlogindate` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `lastloginipv4` int(4) unsigned NOT NULL DEFAULT 0,
  `lastloginprotocol` char(255) NOT NULL DEFAULT '',
  `disclaimer` text DEFAULT NULL,
  `allowedsenders` text DEFAULT NULL,
  `rejectedsenders` text DEFAULT NULL,
  `allowedrecipients` text DEFAULT NULL,
  `rejectedrecipients` text DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `passwordlastchange` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`username`),
  KEY `domain` (`domain`),
  KEY `department` (`department`),
  KEY `employeeid` (`employeeid`),
  KEY `isadmin` (`isadmin`),
  KEY `isglobaladmin` (`isglobaladmin`),
  KEY `enablesmtp` (`enablesmtp`),
  KEY `enablesmtpsecured` (`enablesmtpsecured`),
  KEY `enablepop3` (`enablepop3`),
  KEY `enablepop3secured` (`enablepop3secured`),
  KEY `enablepop3tls` (`enablepop3tls`),
  KEY `enableimap` (`enableimap`),
  KEY `enableimapsecured` (`enableimapsecured`),
  KEY `enableimaptls` (`enableimaptls`),
  KEY `enabledeliver` (`enabledeliver`),
  KEY `enablelda` (`enablelda`),
  KEY `enablemanagesieve` (`enablemanagesieve`),
  KEY `enablemanagesievesecured` (`enablemanagesievesecured`),
  KEY `enablesieve` (`enablesieve`),
  KEY `enablesievesecured` (`enablesievesecured`),
  KEY `enablesievetls` (`enablesievetls`),
  KEY `enablelmtp` (`enablelmtp`),
  KEY `enableinternal` (`enableinternal`),
  KEY `enabledoveadm` (`enabledoveadm`),
  KEY `enablelib-storage` (`enablelib-storage`),
  KEY `enablequota-status` (`enablequota-status`),
  KEY `enableindexer-worker` (`enableindexer-worker`),
  KEY `enabledsync` (`enabledsync`),
  KEY `enablesogo` (`enablesogo`),
  KEY `passwordlastchange` (`passwordlastchange`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `mailbox` WRITE;
/*!40000 ALTER TABLE `mailbox` DISABLE KEYS */;
INSERT INTO `mailbox` VALUES ('postmaster@wolfetti.example','{SSHA512}ZdnbREkrEgYb0lEi3kXq+dExus4wUpxl1aNOeUSJMn52mBwA9VmAMitsN8CtpBg6FosCPitIvYxm1SqjkR56GgkmLmIivZP4','postmaster','','maildir','Maildir','/var/vmail','vmail1','wolfetti.example/p/o/s/postmaster/',1024,'wolfetti.example','','','normal','',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,NULL,'1970-01-01 01:01:01',0,'',NULL,NULL,NULL,NULL,NULL,NULL,'1970-01-01 01:01:01','2020-04-04 15:08:03','1970-01-01 01:01:01','9999-12-31 00:00:00',1);
/*!40000 ALTER TABLE `mailbox` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `maillists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maillists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `transport` varchar(255) NOT NULL DEFAULT '',
  `accesspolicy` varchar(30) NOT NULL DEFAULT '',
  `maxmsgsize` bigint(20) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `mlid` varchar(36) NOT NULL DEFAULT '',
  `is_newsletter` tinyint(1) NOT NULL DEFAULT 0,
  `settings` text DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`),
  UNIQUE KEY `mlid` (`mlid`),
  KEY `is_newsletter` (`is_newsletter`),
  KEY `domain` (`domain`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `maillists` WRITE;
/*!40000 ALTER TABLE `maillists` DISABLE KEYS */;
/*!40000 ALTER TABLE `maillists` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `moderators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moderators` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL DEFAULT '',
  `moderator` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `dest_domain` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`,`moderator`),
  KEY `domain` (`domain`),
  KEY `dest_domain` (`dest_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `moderators` WRITE;
/*!40000 ALTER TABLE `moderators` DISABLE KEYS */;
/*!40000 ALTER TABLE `moderators` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `recipient_bcc_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipient_bcc_domain` (
  `domain` varchar(255) NOT NULL DEFAULT '',
  `bcc_address` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`domain`),
  KEY `bcc_address` (`bcc_address`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `recipient_bcc_domain` WRITE;
/*!40000 ALTER TABLE `recipient_bcc_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipient_bcc_domain` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `recipient_bcc_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipient_bcc_user` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `bcc_address` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`username`),
  KEY `bcc_address` (`bcc_address`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `recipient_bcc_user` WRITE;
/*!40000 ALTER TABLE `recipient_bcc_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipient_bcc_user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sender_bcc_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sender_bcc_domain` (
  `domain` varchar(255) NOT NULL DEFAULT '',
  `bcc_address` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`domain`),
  KEY `bcc_address` (`bcc_address`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sender_bcc_domain` WRITE;
/*!40000 ALTER TABLE `sender_bcc_domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `sender_bcc_domain` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sender_bcc_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sender_bcc_user` (
  `username` varchar(255) NOT NULL DEFAULT '',
  `bcc_address` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `modified` datetime NOT NULL DEFAULT '1970-01-01 01:01:01',
  `expired` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`username`),
  KEY `bcc_address` (`bcc_address`),
  KEY `domain` (`domain`),
  KEY `expired` (`expired`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sender_bcc_user` WRITE;
/*!40000 ALTER TABLE `sender_bcc_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sender_bcc_user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `sender_relayhost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sender_relayhost` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL DEFAULT '',
  `relayhost` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `sender_relayhost` WRITE;
/*!40000 ALTER TABLE `sender_relayhost` DISABLE KEYS */;
/*!40000 ALTER TABLE `sender_relayhost` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `share_folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_folder` (
  `from_user` varchar(255) CHARACTER SET ascii NOT NULL,
  `to_user` varchar(255) CHARACTER SET ascii NOT NULL,
  `dummy` char(1) DEFAULT NULL,
  PRIMARY KEY (`from_user`,`to_user`),
  KEY `from_user` (`from_user`),
  KEY `to_user` (`to_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `share_folder` WRITE;
/*!40000 ALTER TABLE `share_folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `share_folder` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `used_quota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `used_quota` (
  `username` varchar(255) NOT NULL,
  `bytes` bigint(20) NOT NULL DEFAULT 0,
  `messages` bigint(20) NOT NULL DEFAULT 0,
  `domain` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`username`),
  KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `used_quota` WRITE;
/*!40000 ALTER TABLE `used_quota` DISABLE KEYS */;
/*!40000 ALTER TABLE `used_quota` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `used_quota_before_insert`
    BEFORE INSERT ON `used_quota` FOR EACH ROW
    BEGIN
        SET NEW.domain = SUBSTRING_INDEX(NEW.username, '@', -1);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
