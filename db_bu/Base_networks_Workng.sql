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
INSERT INTO `categories` VALUES ('4028a18a6379d7b5016379d88aa2000d','cat1','cat1','cat1',1,NULL,NULL),('4028a18a6379d7b5016379d88aa2000e','cat2','cat2','cat2',1,NULL,NULL),('4028a18a6379d7b5016379d88aa2000f','cat23','cat23','cat23',1,NULL,NULL),('4028a18a6379d7b5016379d88aa20010','cat3','cat3','cat3',1,NULL,NULL);
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
INSERT INTO `demographics` VALUES ('4028a18a6379d7b5016379d889980009','Male 18-25','dumb broke','dumb and broke and easily taken advantage of',1,NULL,NULL),('4028a18a6379d7b5016379d88998000a','Male 26-39','disposiable income','not dumb, but still not smart, still easy',2,NULL,NULL),('4028a18a6379d7b5016379d88998000b','Male 40-59','saving for retirement','already married, but looking',1,NULL,NULL),('4028a18a6379d7b5016379d88998000c','Male 60+','retired','Bingo anyone?',3,NULL,NULL);
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
INSERT INTO `influenceraccounts` VALUES ('4028a18a6379d7b5016379d8814b0008','trip','ward','king@werwards.com','fbfbfb',NULL,NULL,'','407 monticello dr','','','','Stafford','AL','22556','',NULL,NULL,NULL,NULL),('4028a18a6379d7b5016379d962460013','Patrick','Tisdel','patricktisdel@outlook.com','dfbdb',NULL,NULL,'','407 monticello dr','','','','Stafford','AL','22556','',NULL,NULL,NULL,NULL);
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
  `instagramUserid` varchar(50) DEFAULT NULL,
  `instagramUserName` varchar(50) DEFAULT NULL,
  `instagramprofile_picture` varchar(250) DEFAULT NULL,
  `instagramResponse` longtext,
  `instagramAccessToken` longtext,
  `instagramAccessTokenSetUpdate` datetime DEFAULT NULL,
  `instagrammedia` double DEFAULT NULL,
  `instagramfollows` double DEFAULT NULL,
  `instagramfollowed_by` double DEFAULT NULL,
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
  `pintrestid` varchar(50) DEFAULT NULL,
  `pintrestLongLivedAccessToken` longtext,
  `pintrestLongLivedAccessTokenType` longtext,
  `pintrestLongLivedAccessTokenSetDate` datetime DEFAULT NULL,
  `pintrestUserURL` longtext,
  `PintrestResponse` longtext,
  `pintrestPinsCount` double DEFAULT NULL,
  `pintrestfollowingCount` double DEFAULT NULL,
  `pintrestfollowersCount` double DEFAULT NULL,
  `pintrestboardsCount` double DEFAULT NULL,
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
INSERT INTO `influencerprofiles` VALUES ('4028a18a6379d7b5016379d8814b0007','','',NULL,'','','',NULL,0,0,NULL,'','','','','',NULL,0,0,0,NULL,'','','','',NULL,'','','','',NULL,0,'',NULL,'','','','','',NULL,'','',0,0,0,0,NULL,1,'','',NULL,'','','','','','','',NULL,NULL,'4028a18a6379d7b5016379d8814b0008'),('4028a18a6379d7b5016379d962460012','','',NULL,'','','',NULL,0,0,NULL,'','','','','',NULL,0,0,0,NULL,'','','','',NULL,'','','','',NULL,0,'',NULL,'','','','','',NULL,'','',0,0,0,0,NULL,1,'','',NULL,'','','','','','','',NULL,NULL,'4028a18a6379d7b5016379d962460013');
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
INSERT INTO `influencersubscriptions` VALUES ('4028a18a6379d7b5016379d84c220003','Im a good trial','Premiere','Short paid trial',1,3,1,'','','',''),('4028a18a6379d7b5016379d84c310004','Willing to see it over time','Standard','Long enough to ',1,6,5,'','','',''),('4028a18a6379d7b5016379d84c310005','Im all in','Premiere','Im all in',1,12,10,'','','','');
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
INSERT INTO `influencersubscriptiontoaccount` VALUES ('4028a18a6379d7b5016379d880ed0006',NULL,NULL,NULL,NULL,'','','',NULL,NULL,'4028a18a6379d7b5016379d8814b0008','4028a18a6379d7b5016379d84c220003'),('4028a18a6379d7b5016379d961e70011',NULL,NULL,NULL,NULL,'','','',NULL,NULL,'4028a18a6379d7b5016379d962460013','4028a18a6379d7b5016379d84c220003');
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

-- Dump completed on 2018-05-19 15:23:01
