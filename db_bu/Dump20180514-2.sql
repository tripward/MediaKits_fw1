CREATE DATABASE  IF NOT EXISTS `mediakits` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mediakits`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: mediakits
-- ------------------------------------------------------
-- Server version	5.7.19-log

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

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awards` (
  `awardid` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `PresentedBy` longtext,
  `PresentedDate` date DEFAULT NULL,
  `description` longtext,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `influencerProfileid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`awardid`),
  KEY `FKAC40D1B6B69A57D3` (`influencerProfileid`),
  CONSTRAINT `FKAC40D1B6B69A57D3` FOREIGN KEY (`influencerProfileid`) REFERENCES `influencerprofiles` (`influencerProfileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` VALUES ('4028a18a633c4a7b01633c4b765a0001','my award','','icf','2018-02-08','dfvdfvsdfv',NULL,NULL,'4028a18a6337faf9016338069cdc000f'),('4028a18a633c4a7b01633c4cf2980002','NFCM2018','','1969','2018-02-02','sdscds',NULL,NULL,'4028a18a6337faf9016338069cdc000f');
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categoryid` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` longtext,
  `sortOrder` double DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('4028a18a6337faf901633806a6230015','cat1','cat1','cat1',1,NULL,NULL),('4028a18a6337faf901633806a6230016','cat2','cat2','cat2',1,NULL,NULL),('4028a18a6337faf901633806a6230017','cat23','cat23','cat23',1,NULL,NULL),('4028a18a6337faf901633806a6230018','cat3','cat3','cat3',1,NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conferences`
--

DROP TABLE IF EXISTS `conferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conferences` (
  `conferenceid` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `description` longtext,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `influencerProfileid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`conferenceid`),
  KEY `FK40895ED7B69A57D3` (`influencerProfileid`),
  CONSTRAINT `FK40895ED7B69A57D3` FOREIGN KEY (`influencerProfileid`) REFERENCES `influencerprofiles` (`influencerProfileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conferences`
--

LOCK TABLES `conferences` WRITE;
/*!40000 ALTER TABLE `conferences` DISABLE KEYS */;
INSERT INTO `conferences` VALUES ('4028a18a633c4a7b01633c64d6ef000e','my c onf','','2018-04-25','sd sdscsc',NULL,NULL,'4028a18a6337faf9016338069cdc000f');
/*!40000 ALTER TABLE `conferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demographics`
--

DROP TABLE IF EXISTS `demographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographics` (
  `demographicid` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` longtext,
  `sortOrder` double DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  PRIMARY KEY (`demographicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demographics`
--

LOCK TABLES `demographics` WRITE;
/*!40000 ALTER TABLE `demographics` DISABLE KEYS */;
INSERT INTO `demographics` VALUES ('4028a18a6337faf901633806a1ae0011','Male 18-25','dumb broke','dumb and broke and easily taken advantage of',1,NULL,NULL),('4028a18a6337faf901633806a1ae0012','Male 26-39','disposiable income','not dumb, but still not smart, still easy',2,NULL,NULL),('4028a18a6337faf901633806a1ae0013','Male 40-59','saving for retirement','already married, but looking',1,NULL,NULL),('4028a18a6337faf901633806a1ae0014','Male 60+','retired','Bingo anyone?',3,NULL,NULL);
/*!40000 ALTER TABLE `demographics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `influenceraccounts`
--

DROP TABLE IF EXISTS `influenceraccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influenceraccounts` (
  `influenceraccountid` varchar(255) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `isActive` bit(1) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `discountPercent` double DEFAULT NULL,
  `discountDuration` double DEFAULT NULL,
  `discountStart` date DEFAULT NULL,
  `subscriptionStart` date DEFAULT NULL,
  PRIMARY KEY (`influenceraccountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `influenceraccounts`
--

LOCK TABLES `influenceraccounts` WRITE;
/*!40000 ALTER TABLE `influenceraccounts` DISABLE KEYS */;
INSERT INTO `influenceraccounts` VALUES ('4028a18a6337faf9016338069ceb0010','trip3','ward3','king@werwards.com','fgbdfb',NULL,NULL,'','407 monticello dr','','','','Stafford','AL','22556','',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `influenceraccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `influencerprofiles`
--

DROP TABLE IF EXISTS `influencerprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influencerprofiles` (
  `influencerProfileid` varchar(255) NOT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` longtext,
  `lastStatUdate` datetime DEFAULT NULL,
  `twitterUserName` varchar(50) DEFAULT NULL,
  `twitterPassword` varchar(50) DEFAULT NULL,
  `twitterResponse` longtext,
  `twitterResponseDate` datetime DEFAULT NULL,
  `twitterFollowedByCount` double DEFAULT NULL,
  `twitterFollowingCount` double DEFAULT NULL,
  `twitterLastUpdate` datetime DEFAULT NULL,
  `instagramUserName` varchar(50) DEFAULT NULL,
  `instagramPassword` varchar(50) DEFAULT NULL,
  `instagramResponse` longtext,
  `instagramAccessToken` longtext,
  `instagramAccessTokenSetUpdate` datetime DEFAULT NULL,
  `instagramFollowersCount` double DEFAULT NULL,
  `instagramLastUpdate` datetime DEFAULT NULL,
  `FacebookID` varchar(50) DEFAULT NULL,
  `FacebookUsername` varchar(50) DEFAULT NULL,
  `facebookPassword` varchar(50) DEFAULT NULL,
  `facebookShortLivedAccessToken` longtext,
  `facebookShortLivedAccessTokenSetDate` datetime DEFAULT NULL,
  `facebookLongLivedAccessToken` longtext,
  `facebookLongLivedAccessTokenType` longtext,
  `facebookResponse` longtext,
  `facebookLongLivedAccessTokenExpiresIn` varchar(50) DEFAULT NULL,
  `facebookLongLivedAccessTokenSetDate` datetime DEFAULT NULL,
  `facebookFriendsCount` double DEFAULT NULL,
  `facebookBusinesspageLink` varchar(255) DEFAULT NULL,
  `facebookStatsLastUpdate` datetime DEFAULT NULL,
  `pintrestUserName` varchar(50) DEFAULT NULL,
  `pintrestPassword` varchar(50) DEFAULT NULL,
  `PintrestResponse` longtext,
  `pintrestFollowersCount` double DEFAULT NULL,
  `pintrestFollowingCount` double DEFAULT NULL,
  `pintrestLastUpdate` datetime DEFAULT NULL,
  `mediakitTemplateID` double DEFAULT NULL,
  `googleAnalyticsUsername` varchar(50) DEFAULT NULL,
  `googleAnalyticsPassword` varchar(50) DEFAULT NULL,
  `googleLastUpdate` datetime DEFAULT NULL,
  `blogURL` varchar(100) DEFAULT NULL,
  `webURL` varchar(100) DEFAULT NULL,
  `headshotFilename` varchar(100) DEFAULT NULL,
  `BaseInfluenceZipCode` varchar(11) DEFAULT NULL,
  `BaseInfluencerRadius` varchar(255) DEFAULT NULL,
  `BaseInfluencelat` varchar(255) DEFAULT NULL,
  `BaseInfluencelong` varchar(255) DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `influenceraccountid` varchar(255) DEFAULT NULL,
  `instagramUserid` varchar(50) DEFAULT NULL,
  `instagramprofile_picture` varchar(250) DEFAULT NULL,
  `instagrammedia` double DEFAULT NULL,
  `instagramfollows` double DEFAULT NULL,
  `instagramfollowed_by` double DEFAULT NULL,
  PRIMARY KEY (`influencerProfileid`),
  UNIQUE KEY `influenceraccountid` (`influenceraccountid`),
  KEY `FK77E763273CAA87BB` (`influenceraccountid`),
  CONSTRAINT `FK77E763273CAA87BB` FOREIGN KEY (`influenceraccountid`) REFERENCES `influenceraccounts` (`influenceraccountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `influencerprofiles`
--

LOCK TABLES `influencerprofiles` WRITE;
/*!40000 ALTER TABLE `influencerprofiles` DISABLE KEYS */;
INSERT INTO `influencerprofiles` VALUES ('4028a18a6337faf9016338069cdc000f','vdfvsdv','my desc',NULL,'king@werwards.com','','','2018-05-14 00:00:00',0,0,NULL,'trip.ward','','','6362926280.1103427.3aa2d98283f34c63894e312d7265cf91',NULL,0,'2018-05-11 14:08:54','10156087191719596','','','',NULL,'EAAcrAkgFkjYBACeNYUr7ZBX6HnZCO4z8K6BXGJcxQkk2yUWZAlUxhleH5c1pTW45ip9CuOqasZAYg4oN2ihEuwJWXuZBSGOSe5xMa2q2CEAU3G2K3xnHAXiFOTFeZBGZBCjuNfbFWeLrn7lsnXI4eRyw2HuPB4XIFRSAyXoaxAZCmAZDZD','bearer','{\"profile_response\":{\"charset\":\"UTF-8\",\"status_text\":\"OK\",\"text\":true,\"cookies\":{\"COLUMNS\":[\"NAME\",\"VALUE\",\"PATH\",\"DOMAIN\",\"EXPIRES\",\"SECURE\",\"HTTPONLY\"],\"DATA\":[]},\"errordetail\":\"\",\"filecontent\":\"{\\\"name\\\":\\\"Trip Ward\\\",\\\"id\\\":\\\"10156087191719596\\\"}\",\"responseheader\":{\"Content-Length\":\"45\",\"Date\":\"Thu, 10 May 2018 04:03:28 GMT\",\"x-fb-trace-id\":\"HpqDG/nUB3Q\",\"Access-Control-Allow-Origin\":\"*\",\"X-FB-Debug\":\"lYairtXinkIH5xIptHe1Be+y4MLcIEsSBxieCHkEovykd+nSuk4t5G4ZmNWcvm+s1NM6p7SFnlSrOqaZ+HqaiA==\",\"Expires\":\"Sat, 01 Jan 2000 00:00:00 GMT\",\"x-fb-rev\":\"3894725\",\"ETag\":\"\\\"fa9040d5873da372d4d22134bb7042065d51e04f\\\"\",\"facebook-api-version\":\"v2.11\",\"Strict-Transport-Security\":\"max-age=15552000; preload\",\"status_code\":200,\"Pragma\":\"no-cache\",\"Content-Type\":\"text/javascript; charset=UTF-8\",\"Cache-Control\":\"private, no-cache, no-store, must-revalidate\",\"Connection\":\"keep-alive\",\"explanation\":\"OK\"},\"header\":\"HTTP/1.1 200 OK ETag: \\\"fa9040d5873da372d4d22134bb7042065d51e04f\\\" Strict-Transport-Security: max-age=15552000; preload x-fb-trace-id: HpqDG/nUB3Q x-fb-rev: 3894725 Expires: Sat, 01 Jan 2000 00:00:00 GMT Content-Type: text/javascript; charset=UTF-8 facebook-api-version: v2.11 Cache-Control: private, no-cache, no-store, must-revalidate Pragma: no-cache Access-Control-Allow-Origin: * X-FB-Debug: lYairtXinkIH5xIptHe1Be+y4MLcIEsSBxieCHkEovykd+nSuk4t5G4ZmNWcvm+s1NM6p7SFnlSrOqaZ+HqaiA== Date: Thu, 10 May 2018 04:03:28 GMT Connection: keep-alive Content-Length: 45 \",\"statuscode\":\"200 OK\",\"status_code\":200,\"http_version\":\"HTTP/1.1\",\"mimetype\":\"text/javascript\"},\"Tokne_response\":{\"content\":\"{\\\"access_token\\\":\\\"EAAcrAkgFkjYBACeNYUr7ZBX6HnZCO4z8K6BXGJcxQkk2yUWZAlUxhleH5c1pTW45ip9CuOqasZAYg4oN2ihEuwJWXuZBSGOSe5xMa2q2CEAU3G2K3xnHAXiFOTFeZBGZBCjuNfbFWeLrn7lsnXI4eRyw2HuPB4XIFRSAyXoaxAZCmAZDZD\\\",\\\"token_type\\\":\\\"bearer\\\",\\\"expires_in\\\":5124671}\",\"success\":true},\"set_date\":\"May, 09 2018 21:03:28 -0700\"}','','2018-05-09 21:03:29',0,'',NULL,'tripward','','',0,0,NULL,1,'','',NULL,'blogURL3','webURL3','','22556','','','',NULL,NULL,'4028a18a6337faf9016338069ceb0010','6362926280','https://scontent.cdninstagram.com/vp/93d0f8f7e3c452de8947423a0c6ad6b9/5B8F9338/t51.2885-19/s150x150/23347511_839337416239956_2341585340503949312_n.jpg',0,0,24);
/*!40000 ALTER TABLE `influencerprofiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `influencerprofiletocategories`
--

DROP TABLE IF EXISTS `influencerprofiletocategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influencerprofiletocategories` (
  `InfluencerProfileToCategoryid` varchar(255) NOT NULL,
  `InfluencerProfileID` varchar(255) DEFAULT NULL,
  `categoryid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`InfluencerProfileToCategoryid`),
  KEY `FK7B7FFBC3B69A57D3` (`InfluencerProfileID`),
  KEY `FK7B7FFBC3504A3F97` (`categoryid`),
  CONSTRAINT `FK7B7FFBC3504A3F97` FOREIGN KEY (`categoryid`) REFERENCES `categories` (`categoryid`),
  CONSTRAINT `FK7B7FFBC3B69A57D3` FOREIGN KEY (`InfluencerProfileID`) REFERENCES `influencerprofiles` (`influencerProfileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `influencerprofiletocategories`
--

LOCK TABLES `influencerprofiletocategories` WRITE;
/*!40000 ALTER TABLE `influencerprofiletocategories` DISABLE KEYS */;
INSERT INTO `influencerprofiletocategories` VALUES ('0E938194-C5BF-4B49-B395BB7BF473C51F','4028a18a6337faf9016338069cdc000f','4028a18a6337faf901633806a6230015');
/*!40000 ALTER TABLE `influencerprofiletocategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `influencerprofiletodemographics`
--

DROP TABLE IF EXISTS `influencerprofiletodemographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influencerprofiletodemographics` (
  `InfluencerProfileToDemographicsid` varchar(255) NOT NULL,
  `InfluencerProfileID` varchar(255) DEFAULT NULL,
  `demographicID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`InfluencerProfileToDemographicsid`),
  KEY `FK9572FD5565C7725` (`demographicID`),
  KEY `FK9572FD55B69A57D3` (`InfluencerProfileID`),
  CONSTRAINT `FK9572FD5565C7725` FOREIGN KEY (`demographicID`) REFERENCES `demographics` (`demographicid`),
  CONSTRAINT `FK9572FD55B69A57D3` FOREIGN KEY (`InfluencerProfileID`) REFERENCES `influencerprofiles` (`influencerProfileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `influencerprofiletodemographics`
--

LOCK TABLES `influencerprofiletodemographics` WRITE;
/*!40000 ALTER TABLE `influencerprofiletodemographics` DISABLE KEYS */;
INSERT INTO `influencerprofiletodemographics` VALUES ('2AED7AC2-B2D8-48FE-9B2E0544052D64CC','4028a18a6337faf9016338069cdc000f','4028a18a6337faf901633806a1ae0011');
/*!40000 ALTER TABLE `influencerprofiletodemographics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `influencersubscriptions`
--

DROP TABLE IF EXISTS `influencersubscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influencersubscriptions` (
  `Subscriptionid` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `level` longtext,
  `description` longtext,
  `sort_order` double DEFAULT NULL,
  `duration` double DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `isActive` bit(1) DEFAULT NULL,
  `isOffered` bit(1) DEFAULT NULL,
  `paymentGateway` longtext,
  `transactionid` longtext,
  PRIMARY KEY (`Subscriptionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `influencersubscriptions`
--

LOCK TABLES `influencersubscriptions` WRITE;
/*!40000 ALTER TABLE `influencersubscriptions` DISABLE KEYS */;
INSERT INTO `influencersubscriptions` VALUES ('4028a18a6337faf9016338067956000b','Im a good trial','Premiere','Short paid trial',1,3,1,'','','',''),('4028a18a6337faf9016338067966000c','Willing to see it over time','Standard','Long enough to ',1,6,5,'','','',''),('4028a18a6337faf9016338067966000d','Im all in','Premiere','Im all in',1,12,10,'','','','');
/*!40000 ALTER TABLE `influencersubscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `influencersubscriptiontoaccount`
--

DROP TABLE IF EXISTS `influencersubscriptiontoaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `influencersubscriptiontoaccount` (
  `InfluencerSubscriptionToAccountid` varchar(255) NOT NULL,
  `discountPercent` double DEFAULT NULL,
  `discountDuration` double DEFAULT NULL,
  `discountStart` date DEFAULT NULL,
  `subscriptionStart` date DEFAULT NULL,
  `isActive` bit(1) DEFAULT NULL,
  `paymentGateway` longtext,
  `transactionid` longtext,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `influenceraccountid` varchar(255) DEFAULT NULL,
  `IInfluencerSubscriptionID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`InfluencerSubscriptionToAccountid`),
  KEY `FK85EF46583CAA87BB` (`influenceraccountid`),
  KEY `FK85EF46583597DB77` (`IInfluencerSubscriptionID`),
  CONSTRAINT `FK85EF46583597DB77` FOREIGN KEY (`IInfluencerSubscriptionID`) REFERENCES `influencersubscriptions` (`Subscriptionid`),
  CONSTRAINT `FK85EF46583CAA87BB` FOREIGN KEY (`influenceraccountid`) REFERENCES `influenceraccounts` (`influenceraccountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `influencersubscriptiontoaccount`
--

LOCK TABLES `influencersubscriptiontoaccount` WRITE;
/*!40000 ALTER TABLE `influencersubscriptiontoaccount` DISABLE KEYS */;
INSERT INTO `influencersubscriptiontoaccount` VALUES ('4028a18a6337faf9016338069c8e000e',NULL,NULL,NULL,NULL,'','','',NULL,NULL,'4028a18a6337faf9016338069ceb0010','4028a18a6337faf9016338067956000b');
/*!40000 ALTER TABLE `influencersubscriptiontoaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presslinks`
--

DROP TABLE IF EXISTS `presslinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presslinks` (
  `presslinkid` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `publication` longtext,
  `DisplayDate` date DEFAULT NULL,
  `description` longtext,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `influencerProfileid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`presslinkid`),
  KEY `FK703EDD56B69A57D3` (`influencerProfileid`),
  CONSTRAINT `FK703EDD56B69A57D3` FOREIGN KEY (`influencerProfileid`) REFERENCES `influencerprofiles` (`influencerProfileid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presslinks`
--

LOCK TABLES `presslinks` WRITE;
/*!40000 ALTER TABLE `presslinks` DISABLE KEYS */;
INSERT INTO `presslinks` VALUES ('4028a18a633c4a7b01633c57ef470005','my presslink','','my presslink news','2018-03-12','fvfvd',NULL,NULL,'4028a18a6337faf9016338069cdc000f');
/*!40000 ALTER TABLE `presslinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mediakits'
--

--
-- Dumping routines for database 'mediakits'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-14 17:10:20
