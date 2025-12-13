-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: news_calendar
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'John Doe','john.doe@example.com'),(2,'Jane Smith','jane.smith@example.com'),(3,'Michael Brown','michael.brown@example.com'),(4,'Emily Davis','emily.davis@example.com'),(5,'David Wilson','david.wilson@example.com'),(6,'Sarah Taylor','sarah.taylor@example.com'),(7,'Chris Moore','chris.moore@example.com'),(8,'Jessica Anderson','jessica.anderson@example.com'),(9,'Matthew Thomas','matthew.thomas@example.com'),(10,'Laura Jackson','laura.jackson@example.com'),(11,'Daniel White','daniel.white@example.com'),(12,'Sophia Harris','sophia.harris@example.com'),(13,'James Martin','james.martin@example.com'),(14,'Olivia Thompson','olivia.thompson@example.com'),(15,'Ethan Garcia','ethan.garcia@example.com'),(16,'Emma Martinez','emma.martinez@example.com'),(17,'Alexander Robinson','alexander.robinson@example.com'),(18,'Isabella Clark','isabella.clark@example.com'),(19,'Benjamin Lewis','benjamin.lewis@example.com'),(20,'Mia Lee','mia.lee@example.com');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `news_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `publish_date` date DEFAULT NULL,
  `author_id` int unsigned NOT NULL,
  PRIMARY KEY (`news_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Breaking News: Market Updates','Today, the stock market saw unprecedented...','2025-01-01',1),(2,'Technology Trends in 2025','The latest advancements in AI and robotics...','2025-01-02',2),(3,'Health Tips for a Better Life','Explore these 10 simple habits to improve...','2025-01-03',3),(4,'Travel Destinations for 2025','Discover the most popular places to visit...','2025-01-04',4),(5,'The Future of Renewable Energy','How solar and wind energy are reshaping...','2025-01-05',5),(6,'Top 10 Books to Read This Year','Expand your mind with these must-read...','2025-01-06',6),(7,'Sports Highlights: January 2025','Catch up on the latest matches and scores...','2025-01-07',7),(8,'Global Economic Outlook','Experts predict significant growth in...','2025-01-08',8),(9,'Best Recipes for Quick Meals','Try these easy and delicious recipes...','2025-01-09',9),(10,'Fitness Trends to Watch','From wearable tech to personalized...','2025-01-10',10),(11,'Exploring the Metaverse','Virtual reality and the metaverse are...','2025-01-11',11),(12,'Climate Change Challenges','The latest reports show alarming...','2025-01-12',12),(13,'Cryptocurrency in 2025','Bitcoin and Ethereum continue to...','2025-01-13',13),(14,'Startup Success Stories','Learn from these inspiring entrepreneurs...','2025-01-14',14),(15,'Education in the Digital Age','How online platforms are transforming...','2025-01-15',15),(16,'Music Trends of the Year','Discover the genres and artists...','2025-01-16',16),(17,'Art Exhibitions to Visit','Explore these must-see art exhibitions...','2025-01-17',17),(18,'Top Movies of the Year','Check out the highest-grossing...','2025-01-18',18),(19,'The Rise of Electric Cars','Electric vehicles are becoming...','2025-01-19',19),(20,'Workplace Trends in 2025','Remote work and hybrid models...','2025-01-20',20),(21,'The Evolution of Social Media','How platforms like Instagram...','2025-01-21',1),(22,'Space Exploration Updates','NASA announces new missions to...','2025-01-22',2),(23,'The Psychology of Happiness','Understanding the science behind...','2025-01-23',3),(24,'Gaming Industry Insights','Video games continue to dominate...','2025-01-24',4),(25,'Urban Development Projects','Cities are undergoing rapid...','2025-01-25',5),(26,'The Role of AI in Healthcare','Artificial intelligence is revolutionizing...','2025-01-26',6),(27,'Fashion Trends in 2025','Sustainable materials and bold...','2025-01-27',7),(28,'The Future of Education','Innovative teaching methods are...','2025-01-28',8),(29,'Mental Health Awareness','Breaking the stigma around mental...','2025-01-29',9),(30,'The Science Behind Nutrition','Experts reveal what we should...','2025-01-30',10),(31,'The Power of Meditation','Learn how meditation can transform...','2025-01-31',11),(32,'Historical Discoveries in 2025','Archaeologists uncover...','2025-02-01',12),(33,'The Importance of Cybersecurity','Protecting your digital assets...','2025-02-02',13),(34,'Entrepreneurship in 2025','Tips for starting and growing...','2025-02-03',14),(35,'The Rise of Podcasts','Why more people are tuning in...','2025-02-04',15),(36,'Artificial Intelligence in Business','AI tools are streamlining...','2025-02-05',16),(37,'The Impact of Globalization','Understanding the pros and cons...','2025-02-06',17),(38,'The Rise of Sustainable Living','How individuals are adopting...','2025-02-07',18),(39,'The Digital Nomad Lifestyle','More people are working remotely...','2025-02-08',19),(40,'The Growth of E-Commerce','Online shopping continues to...','2025-02-09',20),(41,'The Role of Blockchain','Beyond cryptocurrency, blockchain...','2025-02-10',1),(42,'Advances in Medicine','From gene editing to personalized...','2025-02-11',2),(43,'The Future of Space Tourism','Commercial space flights are...','2025-02-12',3),(44,'The Impact of Automation','How automation is changing...','2025-02-13',4),(45,'The Role of Big Data','Data analytics are transforming...','2025-02-14',5),(46,'The Future of Work','AI and robotics are reshaping...','2025-02-15',6),(47,'The Evolution of Marketing','From influencers to AI...','2025-02-16',7),(48,'The Science of Sleep','How better sleep can improve...','2025-02-17',8),(49,'The Art of Storytelling','Why storytelling is crucial...','2025-02-18',9),(50,'The Future of Entertainment','Streaming platforms and...','2025-02-19',10),(51,'The Growth of Freelancing','More professionals are...','2025-02-20',11);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-05 21:23:09
