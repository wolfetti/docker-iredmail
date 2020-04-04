
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
DROP DATABASE IF EXISTS `amavisd`;
CREATE DATABASE `amavisd`;
USE `amavisd`;

DROP TABLE IF EXISTS `maddr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maddr` (
  `partition_tag` int(11) DEFAULT 0,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varbinary(255) NOT NULL,
  `email_raw` varbinary(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `part_email` (`partition_tag`,`email`),
  KEY `maddr_idx_email` (`email`),
  KEY `maddr_idx_email_raw` (`email_raw`),
  KEY `maddr_idx_domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `maddr` WRITE;
/*!40000 ALTER TABLE `maddr` DISABLE KEYS */;
/*!40000 ALTER TABLE `maddr` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `maddr_email_raw`
    BEFORE INSERT
    ON `maddr`
    FOR EACH ROW
    BEGIN
        IF (NEW.email LIKE '%+%') THEN
            SET NEW.email_raw = CONCAT(SUBSTRING_INDEX(NEW.email, '+', 1), '@', SUBSTRING_INDEX(new.email, '@', -1));
        ELSE
            SET NEW.email_raw = NEW.email;
        END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
DROP TABLE IF EXISTS `mailaddr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailaddr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT 7,
  `email` varbinary(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `mailaddr` WRITE;
/*!40000 ALTER TABLE `mailaddr` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailaddr` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `msgrcpt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msgrcpt` (
  `partition_tag` int(11) NOT NULL DEFAULT 0,
  `mail_id` varbinary(16) NOT NULL,
  `rseqnum` int(11) NOT NULL DEFAULT 0,
  `rid` bigint(20) unsigned NOT NULL,
  `is_local` char(1) NOT NULL DEFAULT '',
  `content` char(1) NOT NULL DEFAULT '',
  `ds` char(1) NOT NULL,
  `rs` char(1) NOT NULL,
  `bl` char(1) DEFAULT '',
  `wl` char(1) DEFAULT '',
  `bspam_level` float DEFAULT NULL,
  `smtp_resp` varchar(255) DEFAULT '',
  PRIMARY KEY (`partition_tag`,`mail_id`,`rseqnum`),
  KEY `msgrcpt_idx_mail_id` (`mail_id`),
  KEY `msgrcpt_idx_rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `msgrcpt` WRITE;
/*!40000 ALTER TABLE `msgrcpt` DISABLE KEYS */;
/*!40000 ALTER TABLE `msgrcpt` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `msgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msgs` (
  `partition_tag` int(11) NOT NULL DEFAULT 0,
  `mail_id` varbinary(16) NOT NULL,
  `secret_id` varbinary(16) DEFAULT '',
  `am_id` varchar(20) NOT NULL,
  `time_num` int(10) unsigned NOT NULL,
  `time_iso` char(16) NOT NULL,
  `sid` bigint(20) unsigned NOT NULL,
  `policy` varchar(255) DEFAULT '',
  `client_addr` varchar(255) DEFAULT '',
  `size` int(10) unsigned NOT NULL,
  `originating` char(1) NOT NULL DEFAULT '',
  `content` char(1) DEFAULT NULL,
  `quar_type` char(1) DEFAULT NULL,
  `quar_loc` varbinary(255) DEFAULT '',
  `dsn_sent` char(1) DEFAULT NULL,
  `spam_level` float DEFAULT NULL,
  `message_id` varchar(255) DEFAULT '',
  `from_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '',
  `host` varchar(255) NOT NULL,
  PRIMARY KEY (`partition_tag`,`mail_id`),
  KEY `msgs_idx_sid` (`sid`),
  KEY `msgs_idx_mess_id` (`message_id`),
  KEY `msgs_idx_time_num` (`time_num`),
  KEY `msgs_idx_mail_id` (`mail_id`),
  KEY `msgs_idx_content` (`content`),
  KEY `msgs_idx_quar_type` (`quar_type`),
  KEY `msgs_idx_content_time_num` (`content`,`time_num`),
  KEY `msgs_idx_spam_level` (`spam_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `msgs` WRITE;
/*!40000 ALTER TABLE `msgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `msgs` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `outbound_wblist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbound_wblist` (
  `rid` int(10) unsigned NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  `wb` varchar(10) NOT NULL,
  PRIMARY KEY (`rid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `outbound_wblist` WRITE;
/*!40000 ALTER TABLE `outbound_wblist` DISABLE KEYS */;
/*!40000 ALTER TABLE `outbound_wblist` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(255) NOT NULL DEFAULT '',
  `virus_lover` char(1) DEFAULT NULL,
  `spam_lover` char(1) DEFAULT NULL,
  `unchecked_lover` char(1) DEFAULT NULL,
  `banned_files_lover` char(1) DEFAULT NULL,
  `bad_header_lover` char(1) DEFAULT NULL,
  `bypass_virus_checks` char(1) DEFAULT NULL,
  `bypass_spam_checks` char(1) DEFAULT NULL,
  `bypass_banned_checks` char(1) DEFAULT NULL,
  `bypass_header_checks` char(1) DEFAULT NULL,
  `virus_quarantine_to` varchar(64) DEFAULT NULL,
  `spam_quarantine_to` varchar(64) DEFAULT NULL,
  `banned_quarantine_to` varchar(64) DEFAULT NULL,
  `unchecked_quarantine_to` varchar(64) DEFAULT NULL,
  `bad_header_quarantine_to` varchar(64) DEFAULT NULL,
  `clean_quarantine_to` varchar(64) DEFAULT NULL,
  `archive_quarantine_to` varchar(64) DEFAULT NULL,
  `spam_tag_level` float DEFAULT NULL,
  `spam_tag2_level` float DEFAULT NULL,
  `spam_tag3_level` float DEFAULT NULL,
  `spam_kill_level` float DEFAULT NULL,
  `spam_dsn_cutoff_level` float DEFAULT NULL,
  `spam_quarantine_cutoff_level` float DEFAULT NULL,
  `addr_extension_virus` varchar(64) DEFAULT NULL,
  `addr_extension_spam` varchar(64) DEFAULT NULL,
  `addr_extension_banned` varchar(64) DEFAULT NULL,
  `addr_extension_bad_header` varchar(64) DEFAULT NULL,
  `warnvirusrecip` char(1) DEFAULT NULL,
  `warnbannedrecip` char(1) DEFAULT NULL,
  `warnbadhrecip` char(1) DEFAULT NULL,
  `newvirus_admin` varchar(64) DEFAULT NULL,
  `virus_admin` varchar(64) DEFAULT NULL,
  `banned_admin` varchar(64) DEFAULT NULL,
  `bad_header_admin` varchar(64) DEFAULT NULL,
  `spam_admin` varchar(64) DEFAULT NULL,
  `spam_subject_tag` varchar(64) DEFAULT NULL,
  `spam_subject_tag2` varchar(64) DEFAULT NULL,
  `spam_subject_tag3` varchar(64) DEFAULT NULL,
  `message_size_limit` int(11) DEFAULT NULL,
  `banned_rulenames` varchar(64) DEFAULT NULL,
  `disclaimer_options` varchar(64) DEFAULT NULL,
  `forward_method` varchar(64) DEFAULT NULL,
  `sa_userconf` varchar(64) DEFAULT NULL,
  `sa_username` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `policy_idx_policy_name` (`policy_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `policy` WRITE;
/*!40000 ALTER TABLE `policy` DISABLE KEYS */;
INSERT INTO `policy` VALUES (1,'@.','N','Y',NULL,'Y','Y','N','N','N','N','virus-quarantine','','',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `policy` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `quarantine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quarantine` (
  `partition_tag` int(11) NOT NULL DEFAULT 0,
  `mail_id` varbinary(16) NOT NULL,
  `chunk_ind` int(10) unsigned NOT NULL,
  `mail_text` blob NOT NULL,
  PRIMARY KEY (`partition_tag`,`mail_id`,`chunk_ind`),
  KEY `quar_idx_mail_id` (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `quarantine` WRITE;
/*!40000 ALTER TABLE `quarantine` DISABLE KEYS */;
/*!40000 ALTER TABLE `quarantine` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT 7,
  `policy_id` int(10) unsigned NOT NULL DEFAULT 1,
  `email` varbinary(255) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,0,1,'@.',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `wblist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wblist` (
  `rid` int(10) unsigned NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  `wb` varchar(10) NOT NULL,
  PRIMARY KEY (`rid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `wblist` WRITE;
/*!40000 ALTER TABLE `wblist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wblist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

