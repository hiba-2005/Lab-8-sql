-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: universite
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credits` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enseignement`
--

DROP TABLE IF EXISTS `enseignement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cours_id` int NOT NULL,
  `professeur_id` int DEFAULT NULL,
  `semestre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cours_id` (`cours_id`,`professeur_id`,`semestre`),
  KEY `fk_ens_prof` (`professeur_id`),
  CONSTRAINT `fk_ens_cours` FOREIGN KEY (`cours_id`) REFERENCES `cours` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ens_prof` FOREIGN KEY (`professeur_id`) REFERENCES `professeur` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `examen`
--

DROP TABLE IF EXISTS `examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `etudiant_id` int NOT NULL,
  `enseignement_id` int NOT NULL,
  `date_inscription` date NOT NULL,
  `date_examen` date NOT NULL,
  `score` decimal(4,2) NOT NULL,
  `commentaire` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `fk_exam_inscription` (`etudiant_id`,`enseignement_id`,`date_inscription`),
  CONSTRAINT `fk_exam_inscription` FOREIGN KEY (`etudiant_id`, `enseignement_id`, `date_inscription`) REFERENCES `inscription` (`etudiant_id`, `enseignement_id`, `date_inscription`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ck_score` CHECK ((`score` between 0 and 20))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inscription`
--

DROP TABLE IF EXISTS `inscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscription` (
  `etudiant_id` int NOT NULL,
  `enseignement_id` int NOT NULL,
  `date_inscription` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`etudiant_id`,`enseignement_id`,`date_inscription`),
  UNIQUE KEY `uq_ins_unique` (`etudiant_id`,`enseignement_id`),
  KEY `fk_ins_enseignement` (`enseignement_id`),
  CONSTRAINT `fk_ins_enseignement` FOREIGN KEY (`enseignement_id`) REFERENCES `enseignement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ins_etudiant` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `professeur`
--

DROP TABLE IF EXISTS `professeur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professeur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `departement` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!50001 VIEW `vue_etudiant_charges` AS select `e`.`id` AS `id`,`e`.`nom` AS `nom`,count(`i`.`enseignement_id`) AS `nb_inscriptions`,coalesce(sum(`c`.`credits`),0) AS `total_credits` from (((`etudiant` `e` left join `inscription` `i` on((`i`.`etudiant_id` = `e`.`id`))) left join `enseignement` `en` on((`en`.`id` = `i`.`enseignement_id`))) left join `cours` `c` on((`c`.`id` = `en`.`cours_id`))) group by `e`.`id`,`e`.`nom` */;
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
/*!50001 VIEW `vue_performances` AS select `et`.`id` AS `etudiant_id`,`et`.`nom` AS `nom`,avg(`ex`.`score`) AS `moyenne_score` from (`etudiant` `et` left join `examen` `ex` on((`ex`.`etudiant_id` = `et`.`id`))) group by `et`.`id`,`et`.`nom` */;
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

-- Dump completed on 2025-12-16 20:02:59
