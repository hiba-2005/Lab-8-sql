CREATE DATABASE  IF NOT EXISTS `universite` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `universite`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: universite
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  `code` varchar(50) NOT NULL,
  `credits` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cours`
--

LOCK TABLES `cours` WRITE;
/*!40000 ALTER TABLE `cours` DISABLE KEYS */;
INSERT INTO `cours` VALUES (1,'Intro SQL','CS101',3),(2,'Algo','CS102',4),(3,'Math DiscrÃ¨tes','MA201',3);
/*!40000 ALTER TABLE `cours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enseignement`
--

DROP TABLE IF EXISTS `enseignement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cours_id` int(11) NOT NULL,
  `professeur_id` int(11) DEFAULT NULL,
  `semestre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cours_id` (`cours_id`,`professeur_id`,`semestre`),
  KEY `fk_ens_prof` (`professeur_id`),
  CONSTRAINT `fk_ens_cours` FOREIGN KEY (`cours_id`) REFERENCES `cours` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ens_prof` FOREIGN KEY (`professeur_id`) REFERENCES `professeur` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignement`
--

LOCK TABLES `enseignement` WRITE;
/*!40000 ALTER TABLE `enseignement` DISABLE KEYS */;
INSERT INTO `enseignement` VALUES (1,1,1,'S1'),(2,2,1,'S1');
/*!40000 ALTER TABLE `enseignement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant`
--

LOCK TABLES `etudiant` WRITE;
/*!40000 ALTER TABLE `etudiant` DISABLE KEYS */;
INSERT INTO `etudiant` VALUES (1,'Alice','alice@mail.com'),(2,'Youssef','youssef@mail.com');
/*!40000 ALTER TABLE `etudiant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examen`
--

DROP TABLE IF EXISTS `examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `etudiant_id` int(11) NOT NULL,
  `enseignement_id` int(11) NOT NULL,
  `date_inscription` date NOT NULL,
  `date_examen` date NOT NULL,
  `score` decimal(4,2) NOT NULL,
  `commentaire` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_inscription` (`etudiant_id`,`enseignement_id`,`date_inscription`),
  CONSTRAINT `fk_exam_inscription` FOREIGN KEY (`etudiant_id`, `enseignement_id`, `date_inscription`) REFERENCES `inscription` (`etudiant_id`, `enseignement_id`, `date_inscription`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_score` CHECK (`score` between 0 and 20)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examen`
--

LOCK TABLES `examen` WRITE;
/*!40000 ALTER TABLE `examen` DISABLE KEYS */;
INSERT INTO `examen` VALUES (1,1,1,'2025-01-10','2025-12-14',15.00,NULL),(2,1,2,'2025-01-12','2025-12-14',15.00,NULL),(3,2,1,'2025-01-11','2025-12-14',15.00,NULL),(4,2,2,'2025-01-13','2025-12-14',15.00,NULL);
/*!40000 ALTER TABLE `examen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscription`
--

DROP TABLE IF EXISTS `inscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscription` (
  `etudiant_id` int(11) NOT NULL,
  `enseignement_id` int(11) NOT NULL,
  `date_inscription` date NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (`etudiant_id`,`enseignement_id`,`date_inscription`),
  UNIQUE KEY `uq_ins_unique` (`etudiant_id`,`enseignement_id`),
  KEY `fk_ins_enseignement` (`enseignement_id`),
  CONSTRAINT `fk_ins_enseignement` FOREIGN KEY (`enseignement_id`) REFERENCES `enseignement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ins_etudiant` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscription`
--

LOCK TABLES `inscription` WRITE;
/*!40000 ALTER TABLE `inscription` DISABLE KEYS */;
INSERT INTO `inscription` VALUES (1,1,'2025-01-10'),(1,2,'2025-01-12'),(2,1,'2025-01-11'),(2,2,'2025-01-13');
/*!40000 ALTER TABLE `inscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professeur`
--

DROP TABLE IF EXISTS `professeur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professeur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `departement` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professeur`
--

LOCK TABLES `professeur` WRITE;
/*!40000 ALTER TABLE `professeur` DISABLE KEYS */;
INSERT INTO `professeur` VALUES (1,'Prof A','prof.a@uni.ma','Informatique'),(2,'Prof B','prof.b@uni.ma','Math');
/*!40000 ALTER TABLE `professeur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vue_etudiant_charges`
--

DROP TABLE IF EXISTS `vue_etudiant_charges`;
/*!50001 DROP VIEW IF EXISTS `vue_etudiant_charges`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vue_etudiant_charges` AS SELECT 
 1 AS `id`,
 1 AS `nom`,
 1 AS `nb_inscriptions`,
 1 AS `total_credits`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vue_performances`
--

DROP TABLE IF EXISTS `vue_performances`;
/*!50001 DROP VIEW IF EXISTS `vue_performances`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vue_performances` AS SELECT 
 1 AS `etudiant_id`,
 1 AS `nom`,
 1 AS `moyenne_score`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'universite'
--

--
-- Dumping routines for database 'universite'
--

--
-- Final view structure for view `vue_etudiant_charges`
--

/*!50001 DROP VIEW IF EXISTS `vue_etudiant_charges`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vue_etudiant_charges` AS select `e`.`id` AS `id`,`e`.`nom` AS `nom`,count(`i`.`enseignement_id`) AS `nb_inscriptions`,coalesce(sum(`c`.`credits`),0) AS `total_credits` from (((`etudiant` `e` left join `inscription` `i` on(`i`.`etudiant_id` = `e`.`id`)) left join `enseignement` `en` on(`en`.`id` = `i`.`enseignement_id`)) left join `cours` `c` on(`c`.`id` = `en`.`cours_id`)) group by `e`.`id`,`e`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vue_performances`
--

/*!50001 DROP VIEW IF EXISTS `vue_performances`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vue_performances` AS select `et`.`id` AS `etudiant_id`,`et`.`nom` AS `nom`,avg(`ex`.`score`) AS `moyenne_score` from (`etudiant` `et` left join `examen` `ex` on(`ex`.`etudiant_id` = `et`.`id`)) group by `et`.`id`,`et`.`nom` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-16 13:55:34
    ->  Le volume dans le lecteur C n?a pas de nom.
    ->  Le num‚ro de s‚rie du volume est 5C61-410B
    -> 
    ->  
ERROR: 
Unknown command '\U'.
--------------
Bye





 Le volume dans le lecteur C n?a pas de nom.
 Le num‚ro de s‚rie du volume est 5C61-410B

 R‚pertoire de C:\Users
--------------

ERROR: 
Unknown command '\D'.
ERROR: 
Unknown command '\3'.
ERROR: 
Unknown command '\S'.
Currently logging to file 'universite_full.sql'
    -> 
    -> 16/12/2025  13:55            11 087 universite_full.sql
    ->                1 fichier(s)           11 087 octets
    ->                0 R‚p(s)   7 166 533 632 octets libres
    -> 
    -> C:\Users\pc\Documents\3 eme annee\SQL\TP8>"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p -P 3307 universite < universite_full.sql
ERROR: 
Unknown command '\U'.
--------------
Bye




 Le volume dans le lecteur C n?a pas de nom.
 Le num‚ro de s‚rie du volume est 5C61-410B

 
16/12/2025  13:55            11 087 universite_full.sql
               1 fichier(s)           11 087 octets
               0 R‚p(s)   7 166 533 632 octets libres

C:\Users
--------------

ERROR: 
Unknown command '\D'.
ERROR: 
Unknown command '\3'.
ERROR: 
Unknown command '\S'.
    ->  Le volume dans le lecteur C n?a pas de nom.
    ->  Le num‚ro de s‚rie du volume est 5C61-410B
    -> 
    ->  R‚pertoire de C:\Users\pc\Documents\3 eme annee\SQL\TP8
ERROR: 
Unknown command '\U'.
--------------
Bye






 Le volume dans le lecteur C n?a pas de nom.
 Le num‚ro de s‚rie du volume est 5C61-410B

 R‚pertoire de C:\Users
--------------

ERROR: 
Unknown command '\D'.
ERROR: 
Unknown command '\3'.
ERROR: 
Unknown command '\S'.
Currently logging to file 'universite_full.sql'
    -> 
    -> 16/12/2025  13:55            11 087 universite_full.sql
    ->                1 fichier(s)           11 087 octets
    ->                0 R‚p(s)   7 166 533 632 octets libres
    -> 
    -> 
ERROR: 
Unknown command '\U'.
--------------
Bye


C:\Usersc\Documents\3 eme annee\SQL
 Le volume dans le lecteur C n?a pas de nom.
 Le num‚ro de s‚rie du volume est 5C61-410B

 

16/12/2025  13:55            11 087 universite_full.sql
               1 fichier(s)           11 087 octets
               0 R‚p(s)   7 166 533 632 octets libres

C:\Users
--------------

ERROR: 
Unknown command '\D'.
ERROR: 
Unknown command '\3'.
ERROR: 
Unknown command '\S'.
    ->  Le volume dans le lecteur C n?a pas de nom.
    ->  Le num‚ro de s‚rie du volume est 5C61-410B
    -> 
    ->  R‚pertoire de C:\Users\pc\Documents\3 eme annee\SQL\TP8
ERROR: 
Unknown command '\U'.
--------------
Bye




C:\Usersc\Documents\3 eme annee\SQL
 Le volume dans le lecteur C n?a pas de nom.
 Le num‚ro de s‚rie du volume est 5C61-410B

 R‚pertoire de C:\Users
--------------

ERROR: 
Unknown command '\D'.
ERROR: 
Unknown command '\3'.
ERROR: 
Unknown command '\S'.
Currently logging to file 'universite_full.sql'
    -> 
    -> 16/12/2025  13:55            11 087 universite_full.sql
    ->                1 fichier(s)           11 087 octets
    ->                0 R‚p(s)   7 166 533 632 octets libres
    -> 
    -> C:\Users\pc\Documents\3 eme annee\SQL\TP8>"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p -P 3307 universite < universite_full.sql
ERROR: 
Unknown command '\U'.
--------------
Bye

C:\Program Files\MySQL\MySQL Server 8.0\bin>cd C:\Usersc

C:\Usersc>cd "C:\Users\pc\Documents\3 eme annee\SQL\TP8"

C:\Usersc\Documents\3 eme annee\SQL
 Le volume dans le lecteur C n?a pas de nom.
 Le num‚ro de s‚rie du volume est 5C61-410B

 R‚pertoire de C:\Usersc\Documents\3 eme annee\SQL

16/12/2025  13:55            11 087 universite_full.sql
               1 fichier(s)           11 087 octets
               0 R‚p(s)   7 166 533 632 octets libres

C:\Users
--------------

ERROR: 
Unknown command '\D'.
ERROR: 
Unknown command '\3'.
ERROR: 
Unknown command '\S'.
