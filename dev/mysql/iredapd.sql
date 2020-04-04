
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
DROP DATABASE IF EXISTS `iredapd`;
CREATE DATABASE `iredapd`;
USE `iredapd`;

DROP TABLE IF EXISTS `greylisting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `greylisting` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(100) NOT NULL DEFAULT '',
  `priority` tinyint(2) NOT NULL DEFAULT 0,
  `sender` varchar(100) NOT NULL DEFAULT '',
  `sender_priority` tinyint(2) NOT NULL DEFAULT 0,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`,`sender`),
  KEY `comment` (`comment`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `greylisting` WRITE;
/*!40000 ALTER TABLE `greylisting` DISABLE KEYS */;
INSERT INTO `greylisting` VALUES (1,'@.',0,'@.',0,'',1);
/*!40000 ALTER TABLE `greylisting` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `greylisting_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `greylisting_tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(255) NOT NULL,
  `recipient` varchar(255) NOT NULL,
  `client_address` varchar(40) NOT NULL,
  `sender_domain` varchar(255) NOT NULL DEFAULT '',
  `rcpt_domain` varchar(255) NOT NULL DEFAULT '',
  `init_time` int(10) unsigned NOT NULL DEFAULT 0,
  `block_expired` int(10) unsigned NOT NULL DEFAULT 0,
  `record_expired` int(10) unsigned NOT NULL DEFAULT 0,
  `blocked_count` bigint(20) NOT NULL DEFAULT 0,
  `passed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sender` (`sender`,`recipient`,`client_address`),
  KEY `sender_domain` (`sender_domain`),
  KEY `rcpt_domain` (`rcpt_domain`),
  KEY `client_address_passed` (`client_address`,`passed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `greylisting_tracking` WRITE;
/*!40000 ALTER TABLE `greylisting_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `greylisting_tracking` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `greylisting_whitelist_domain_spf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `greylisting_whitelist_domain_spf` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(100) NOT NULL DEFAULT '',
  `sender` varchar(100) NOT NULL DEFAULT '',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`,`sender`),
  KEY `comment` (`comment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `greylisting_whitelist_domain_spf` WRITE;
/*!40000 ALTER TABLE `greylisting_whitelist_domain_spf` DISABLE KEYS */;
/*!40000 ALTER TABLE `greylisting_whitelist_domain_spf` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `greylisting_whitelist_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `greylisting_whitelist_domains` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `greylisting_whitelist_domains` WRITE;
/*!40000 ALTER TABLE `greylisting_whitelist_domains` DISABLE KEYS */;
INSERT INTO `greylisting_whitelist_domains` VALUES (1,'amazon.com'),(2,'aol.com'),(3,'cloudfiltering.com'),(4,'cloudflare.com'),(5,'constantcontact.com'),(6,'craigslist.org'),(7,'cust-spf.exacttarget.com'),(8,'ebay.com'),(9,'exacttarget.com'),(10,'facebook.com'),(11,'facebookmail.com'),(12,'fbmta.com'),(13,'fishbowl.com'),(14,'github.com'),(15,'gmx.com'),(16,'google.com'),(17,'hotmail.com'),(18,'icloud.com'),(19,'icontact.com'),(20,'inbox.com'),(21,'instagram.com'),(22,'iredmail.org'),(23,'linkedin.com'),(24,'mail.com'),(25,'mailchimp.com'),(26,'mailgun.com'),(27,'mailjet.com'),(28,'messagelabs.com'),(29,'microsoft.com'),(30,'outlook.com'),(31,'paypal.com'),(32,'pinterest.com'),(33,'reddit.com'),(34,'salesforce.com'),(35,'sbcglobal.net'),(36,'sendgrid.com'),(37,'sendgrid.net'),(38,'serverfault.com'),(39,'stackoverflow.com'),(40,'tumblr.com'),(41,'twitter.com'),(42,'yahoo.com'),(43,'yandex.ru'),(44,'zendesk.com'),(45,'zoho.com');
/*!40000 ALTER TABLE `greylisting_whitelist_domains` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `greylisting_whitelists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `greylisting_whitelists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(100) NOT NULL DEFAULT '',
  `sender` varchar(100) NOT NULL DEFAULT '',
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`,`sender`),
  KEY `comment` (`comment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `greylisting_whitelists` WRITE;
/*!40000 ALTER TABLE `greylisting_whitelists` DISABLE KEYS */;
/*!40000 ALTER TABLE `greylisting_whitelists` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `senderscore_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `senderscore_cache` (
  `client_address` varchar(40) NOT NULL DEFAULT '',
  `score` int(3) unsigned DEFAULT 0,
  `time` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`client_address`),
  KEY `score` (`score`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `senderscore_cache` WRITE;
/*!40000 ALTER TABLE `senderscore_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `senderscore_cache` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `smtp_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smtp_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_num` int(10) unsigned NOT NULL DEFAULT 0,
  `action` varchar(20) NOT NULL DEFAULT '',
  `reason` varchar(150) NOT NULL DEFAULT '',
  `instance` varchar(40) NOT NULL DEFAULT '',
  `client_address` varchar(40) NOT NULL DEFAULT '',
  `client_name` varchar(255) NOT NULL DEFAULT '',
  `reverse_client_name` varchar(255) NOT NULL DEFAULT '',
  `helo_name` varchar(255) NOT NULL DEFAULT '',
  `sender` varchar(255) NOT NULL DEFAULT '',
  `sender_domain` varchar(255) NOT NULL DEFAULT '',
  `sasl_username` varchar(255) NOT NULL DEFAULT '',
  `sasl_domain` varchar(255) NOT NULL DEFAULT '',
  `recipient` varchar(255) NOT NULL DEFAULT '',
  `recipient_domain` varchar(255) NOT NULL DEFAULT '',
  `encryption_protocol` varchar(20) NOT NULL DEFAULT '',
  `encryption_cipher` varchar(50) NOT NULL DEFAULT '',
  `server_address` varchar(40) NOT NULL DEFAULT '',
  `server_port` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `time_num` (`time_num`),
  KEY `action` (`action`),
  KEY `reason` (`reason`),
  KEY `instance` (`instance`),
  KEY `client_address` (`client_address`),
  KEY `client_name` (`client_name`),
  KEY `reverse_client_name` (`reverse_client_name`),
  KEY `helo_name` (`helo_name`),
  KEY `sender` (`sender`),
  KEY `sender_domain` (`sender_domain`),
  KEY `sasl_username` (`sasl_username`),
  KEY `sasl_domain` (`sasl_domain`),
  KEY `recipient` (`recipient`),
  KEY `recipient_domain` (`recipient_domain`),
  KEY `encryption_protocol` (`encryption_protocol`),
  KEY `encryption_cipher` (`encryption_cipher`),
  KEY `server_address` (`server_address`),
  KEY `server_port` (`server_port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `smtp_sessions` WRITE;
/*!40000 ALTER TABLE `smtp_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `smtp_sessions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `srs_exclude_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `srs_exclude_domains` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `srs_exclude_domains` WRITE;
/*!40000 ALTER TABLE `srs_exclude_domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `srs_exclude_domains` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `throttle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `throttle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `kind` varchar(10) NOT NULL DEFAULT 'outbound',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `period` int(10) unsigned NOT NULL DEFAULT 0,
  `msg_size` bigint(20) NOT NULL DEFAULT -1,
  `max_msgs` bigint(20) NOT NULL DEFAULT -1,
  `max_quota` bigint(20) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_kind` (`account`,`kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `throttle` WRITE;
/*!40000 ALTER TABLE `throttle` DISABLE KEYS */;
/*!40000 ALTER TABLE `throttle` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `throttle_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `throttle_tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tid` bigint(20) unsigned NOT NULL DEFAULT 0,
  `account` varchar(255) NOT NULL DEFAULT '',
  `period` int(10) unsigned NOT NULL DEFAULT 0,
  `cur_msgs` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `cur_quota` int(10) unsigned NOT NULL DEFAULT 0,
  `init_time` int(10) unsigned NOT NULL DEFAULT 0,
  `last_time` int(10) unsigned NOT NULL DEFAULT 0,
  `last_notify_time` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tid_account` (`tid`,`account`),
  CONSTRAINT `throttle_tracking_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `throttle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `throttle_tracking` WRITE;
/*!40000 ALTER TABLE `throttle_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `throttle_tracking` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `wblist_rdns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wblist_rdns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rdns` varchar(255) NOT NULL DEFAULT '',
  `wb` varchar(10) NOT NULL DEFAULT 'B',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rdns` (`rdns`),
  KEY `wb` (`wb`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `wblist_rdns` WRITE;
/*!40000 ALTER TABLE `wblist_rdns` DISABLE KEYS */;
INSERT INTO `wblist_rdns` VALUES (1,'.dynamic.163data.com.cn','B'),(2,'.cable.dyn.cableonline.com.mx','B'),(3,'.dyn.user.ono.com','B'),(4,'.static.skysever.com.br','B'),(5,'.castelecom.com.br','B'),(6,'.clients.your-server.de','B');
/*!40000 ALTER TABLE `wblist_rdns` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
