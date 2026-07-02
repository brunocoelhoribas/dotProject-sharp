CREATE DATABASE  IF NOT EXISTS `dotproject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dotproject`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dotproject
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `dotp_acquisition_execution`
--

DROP TABLE IF EXISTS `dotp_acquisition_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_acquisition_execution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `is_delivered` int DEFAULT '0',
  `is_risk_contingency` int DEFAULT '0',
  `value` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` text,
  `reference_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_AQC_EXE` (`project_id`),
  CONSTRAINT `FK_PROJECT_AQC_EXE` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_acquisition_execution`
--

LOCK TABLES `dotp_acquisition_execution` WRITE;
/*!40000 ALTER TABLE `dotp_acquisition_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_acquisition_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_acquisition_planning`
--

DROP TABLE IF EXISTS `dotp_acquisition_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_acquisition_planning` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `items_to_be_acquired` text,
  `contract_type` text,
  `documents_to_acquisition` text,
  `criteria_for_supplier_selection` text,
  `additional_requirements` text,
  `supplier_management_process` text,
  `acquisition_roles` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_QUALITY` (`project_id`),
  CONSTRAINT `FK_PROJECT_QUALITY` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_acquisition_planning`
--

LOCK TABLES `dotp_acquisition_planning` WRITE;
/*!40000 ALTER TABLE `dotp_acquisition_planning` DISABLE KEYS */;
INSERT INTO `dotp_acquisition_planning` VALUES (2,8,'web designer','Fixed Price','The work to be carried out includes the following items:\r\n1. Development of screens for customers perform new requests, and a screen for employees see open requests.\r\n2. Follow the pizzeria identity in the proposed screens.','Formation (Weight: 1) <br />Hour/rate (Weight: 1) <br />Availability (Weight: 1) <br />','The service must be concluded within 2 months<br />','1. Request a quote\r\n2. Quote evaluation\r\n3. Confirm the quote acceptance\r\n4. Allocate the hired resources\r\n5. Track the work execution.\r\n6.Payment\r\n7. Contract closure.','Project Manager: Track the work execution.<br />Hired professional: Carry out the work him was hired for.<br />'),(3,2,'teste','Preço fixo','teste','critério 1 (Peso: 2) <br />critério 2 (Peso: 1) <br />','x<br />y<br />','teste','resp 1: teste<br />resp 2: teste<br />'),(4,2,'Servidor de Jogos (Hardware)','Tempo & material','Edital de compra','Empresa com CNPJ. (Peso: 10) <br />','Empresa do estado de Santa Catarina<br />','Consulta PÃºblica','Gerente de Projetos: Autorizar compra<br />');
/*!40000 ALTER TABLE `dotp_acquisition_planning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_acquisition_planning_criteria`
--

DROP TABLE IF EXISTS `dotp_acquisition_planning_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_acquisition_planning_criteria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acquisition_id` int DEFAULT NULL,
  `criteria` text,
  `weight` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ACQUISITION_CRITERIA` (`acquisition_id`),
  CONSTRAINT `FK_ACQUISITION_CRITERIA` FOREIGN KEY (`acquisition_id`) REFERENCES `dotp_acquisition_planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_acquisition_planning_criteria`
--

LOCK TABLES `dotp_acquisition_planning_criteria` WRITE;
/*!40000 ALTER TABLE `dotp_acquisition_planning_criteria` DISABLE KEYS */;
INSERT INTO `dotp_acquisition_planning_criteria` VALUES (2,2,'Formation',1),(3,2,'Hour/rate',1),(4,2,'Availability',1),(5,3,'critério 1',2),(6,3,'critério 2',1),(7,4,'Empresa com CNPJ.',10);
/*!40000 ALTER TABLE `dotp_acquisition_planning_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_acquisition_planning_requirements`
--

DROP TABLE IF EXISTS `dotp_acquisition_planning_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_acquisition_planning_requirements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acquisition_id` int DEFAULT NULL,
  `requirement` text,
  PRIMARY KEY (`id`),
  KEY `FK_AQUISITION_REQUIREMENT` (`acquisition_id`),
  CONSTRAINT `FK_AQUISITION_REQUIREMENT` FOREIGN KEY (`acquisition_id`) REFERENCES `dotp_acquisition_planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_acquisition_planning_requirements`
--

LOCK TABLES `dotp_acquisition_planning_requirements` WRITE;
/*!40000 ALTER TABLE `dotp_acquisition_planning_requirements` DISABLE KEYS */;
INSERT INTO `dotp_acquisition_planning_requirements` VALUES (2,2,'The service must be concluded within 2 months'),(3,3,'x'),(4,3,'y'),(5,4,'Empresa do estado de Santa Catarina');
/*!40000 ALTER TABLE `dotp_acquisition_planning_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_acquisition_planning_roles`
--

DROP TABLE IF EXISTS `dotp_acquisition_planning_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_acquisition_planning_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `acquisition_id` int DEFAULT NULL,
  `role` text,
  `responsability` text,
  PRIMARY KEY (`id`),
  KEY `FK_ACQUISITION_ROLE` (`acquisition_id`),
  CONSTRAINT `FK_ACQUISITION_ROLE` FOREIGN KEY (`acquisition_id`) REFERENCES `dotp_acquisition_planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_acquisition_planning_roles`
--

LOCK TABLES `dotp_acquisition_planning_roles` WRITE;
/*!40000 ALTER TABLE `dotp_acquisition_planning_roles` DISABLE KEYS */;
INSERT INTO `dotp_acquisition_planning_roles` VALUES (3,2,'Project Manager','Track the work execution.'),(4,2,'Hired professional','Carry out the work him was hired for.'),(5,3,'resp 1','teste'),(6,3,'resp 2','teste'),(7,4,'Gerente de Projetos','Autorizar compra');
/*!40000 ALTER TABLE `dotp_acquisition_planning_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_billingcode`
--

DROP TABLE IF EXISTS `dotp_billingcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_billingcode` (
  `billingcode_id` bigint NOT NULL AUTO_INCREMENT,
  `billingcode_name` varchar(25) NOT NULL DEFAULT '',
  `billingcode_value` float NOT NULL DEFAULT '0',
  `billingcode_desc` varchar(255) NOT NULL DEFAULT '',
  `billingcode_status` int NOT NULL DEFAULT '0',
  `company_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`billingcode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_billingcode`
--

LOCK TABLES `dotp_billingcode` WRITE;
/*!40000 ALTER TABLE `dotp_billingcode` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_billingcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_budget`
--

DROP TABLE IF EXISTS `dotp_budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_budget` (
  `budget_id` int NOT NULL AUTO_INCREMENT,
  `budget_project_id` int NOT NULL,
  `budget_reserve_management` decimal(9,2) NOT NULL,
  `budget_sub_total` decimal(9,2) NOT NULL,
  `budget_total` decimal(9,2) NOT NULL,
  PRIMARY KEY (`budget_id`),
  KEY `fk_budget_project_id` (`budget_project_id`),
  CONSTRAINT `fk_budget_project_id` FOREIGN KEY (`budget_project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_budget`
--

LOCK TABLES `dotp_budget` WRITE;
/*!40000 ALTER TABLE `dotp_budget` DISABLE KEYS */;
INSERT INTO `dotp_budget` VALUES (2,2,9.00,110275.00,120199.75),(8,8,9.00,26045.00,28389.05);
/*!40000 ALTER TABLE `dotp_budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_budget_reserve`
--

DROP TABLE IF EXISTS `dotp_budget_reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_budget_reserve` (
  `budget_reserve_id` int NOT NULL AUTO_INCREMENT,
  `budget_reserve_project_id` int NOT NULL,
  `budget_reserve_risk_id` int NOT NULL,
  `budget_reserve_description` varchar(250) DEFAULT NULL,
  `budget_reserve_financial_impact` int DEFAULT NULL,
  `budget_reserve_inicial_month` datetime DEFAULT NULL,
  `budget_reserve_final_month` datetime DEFAULT NULL,
  `budget_reserve_value_total` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`budget_reserve_id`),
  KEY `fk_budget_reserve_project_id` (`budget_reserve_project_id`),
  CONSTRAINT `fk_budget_reserve_project_id` FOREIGN KEY (`budget_reserve_project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_budget_reserve`
--

LOCK TABLES `dotp_budget_reserve` WRITE;
/*!40000 ALTER TABLE `dotp_budget_reserve` DISABLE KEYS */;
INSERT INTO `dotp_budget_reserve` VALUES (2,2,2,'Afastamento do analista de testes',5700,'2013-03-01 00:00:00','2013-07-31 00:00:00',5700.00),(4,2,5,'O cliente pode declarar falência durante o projeto.',12756,'2013-02-01 00:00:00','2013-07-31 00:00:00',12756.00),(5,2,7,'Greve de ônibus na Ilha do Silí­cio',2100,'2013-03-01 00:00:00','2013-07-31 00:00:00',2100.00),(6,2,8,'Extraviar o dispositivo móvel de testes.',2000,'2013-04-01 00:00:00','2013-07-02 00:00:00',2000.00),(9,8,17,'Programmer leave the project',1000,'2016-03-14 00:00:00','2016-09-01 00:00:00',1000.00);
/*!40000 ALTER TABLE `dotp_budget_reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_common_notes`
--

DROP TABLE IF EXISTS `dotp_common_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_common_notes` (
  `note_id` int unsigned NOT NULL AUTO_INCREMENT,
  `note_author` int unsigned NOT NULL DEFAULT '0',
  `note_module` int unsigned NOT NULL DEFAULT '0',
  `note_record_id` int unsigned NOT NULL DEFAULT '0',
  `note_category` int unsigned NOT NULL DEFAULT '0',
  `note_title` varchar(100) NOT NULL DEFAULT '',
  `note_body` text NOT NULL,
  `note_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `note_hours` float NOT NULL DEFAULT '0',
  `note_code` varchar(8) NOT NULL DEFAULT '',
  `note_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `note_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note_modified_by` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_common_notes`
--

LOCK TABLES `dotp_common_notes` WRITE;
/*!40000 ALTER TABLE `dotp_common_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_common_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_communication`
--

DROP TABLE IF EXISTS `dotp_communication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_communication` (
  `communication_id` int NOT NULL AUTO_INCREMENT,
  `communication_title` varchar(255) NOT NULL,
  `communication_information` varchar(2000) NOT NULL,
  `communication_frequency_id` int NOT NULL,
  `communication_channel_id` int NOT NULL,
  `communication_project_id` int NOT NULL,
  `communication_restrictions` varchar(2000) NOT NULL,
  `communication_date` varchar(30) NOT NULL,
  `communication_responsible_authorization` varchar(80) NOT NULL,
  PRIMARY KEY (`communication_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_communication`
--

LOCK TABLES `dotp_communication` WRITE;
/*!40000 ALTER TABLE `dotp_communication` DISABLE KEYS */;
INSERT INTO `dotp_communication` VALUES (1,'Plano do projeto','Publicar o plano do projeto para obter o acordo entre todos os stakeholders.',2,1,2,'','','2'),(2,'Relatório do progresso do projeto','Divulgar relatório do progresso do projeto para o cliente.',4,1,2,'Os relatórios do projeto serão divulgados no portal da organização, o qual o cliente terá acesso para acompanhamento.','',''),(3,'Relatório de conclusão do módulo web','Informar conclusão do módulo web ao cliente.',2,1,2,'O relatório será emitido somente após a realização de testes de sistema pelo analista de testes.','',''),(4,'Relatório de conclusão do módulo mobile','Comunicar a conclusão do desenvolvimento do módulo mobile.',2,1,2,'Esta comunicação será liberada somente com a autorização do analista de testes após passar pelos testes de sistema.','',''),(5,'teste','',1,1,5,'','','7'),(6,'Project plan is completed','The project plan is completed and now it is necessary your appreciation.',8,5,8,'','',''),(7,'TESTE TSI20','Teste',9,5,2,'Teste','09/12/2021','10');
/*!40000 ALTER TABLE `dotp_communication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_communication_channel`
--

DROP TABLE IF EXISTS `dotp_communication_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_communication_channel` (
  `communication_channel_id` int NOT NULL AUTO_INCREMENT,
  `communication_channel` varchar(255) NOT NULL,
  PRIMARY KEY (`communication_channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_communication_channel`
--

LOCK TABLES `dotp_communication_channel` WRITE;
/*!40000 ALTER TABLE `dotp_communication_channel` DISABLE KEYS */;
INSERT INTO `dotp_communication_channel` VALUES (3,'telefone'),(5,'e-mail'),(6,'e-mail'),(7,'Telephone');
/*!40000 ALTER TABLE `dotp_communication_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_communication_frequency`
--

DROP TABLE IF EXISTS `dotp_communication_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_communication_frequency` (
  `communication_frequency_id` int NOT NULL AUTO_INCREMENT,
  `communication_frequency` varchar(255) NOT NULL,
  `communication_frequency_hasdate` char(3) DEFAULT 'Nao',
  PRIMARY KEY (`communication_frequency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_communication_frequency`
--

LOCK TABLES `dotp_communication_frequency` WRITE;
/*!40000 ALTER TABLE `dotp_communication_frequency` DISABLE KEYS */;
INSERT INTO `dotp_communication_frequency` VALUES (1,'semanal','Nao'),(2,'única vez','Nao'),(3,'quinzenalmente','Nao'),(4,'bimestralmente','Nao'),(6,'Anualmente','Nao'),(7,'Weekly','Nao'),(8,'Once','Nao'),(9,'45 dias','Sim');
/*!40000 ALTER TABLE `dotp_communication_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_communication_issuing`
--

DROP TABLE IF EXISTS `dotp_communication_issuing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_communication_issuing` (
  `communication_issuing_id` int NOT NULL AUTO_INCREMENT,
  `communication_id` int NOT NULL,
  `communication_stakeholder_id` int NOT NULL,
  PRIMARY KEY (`communication_issuing_id`),
  KEY `fk_communication_issuing` (`communication_stakeholder_id`),
  CONSTRAINT `fk_communication_issuing` FOREIGN KEY (`communication_stakeholder_id`) REFERENCES `dotp_contacts` (`contact_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_communication_issuing`
--

LOCK TABLES `dotp_communication_issuing` WRITE;
/*!40000 ALTER TABLE `dotp_communication_issuing` DISABLE KEYS */;
INSERT INTO `dotp_communication_issuing` VALUES (1,1,2),(2,2,2),(3,3,3),(4,4,10),(5,5,2),(6,6,21),(7,7,13);
/*!40000 ALTER TABLE `dotp_communication_issuing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_communication_receptor`
--

DROP TABLE IF EXISTS `dotp_communication_receptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_communication_receptor` (
  `communication_receptor_id` int NOT NULL AUTO_INCREMENT,
  `communication_id` int NOT NULL,
  `communication_stakeholder_id` int NOT NULL,
  PRIMARY KEY (`communication_receptor_id`),
  KEY `fk_communication_receptor` (`communication_stakeholder_id`),
  CONSTRAINT `fk_communication_receptor` FOREIGN KEY (`communication_stakeholder_id`) REFERENCES `dotp_contacts` (`contact_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_communication_receptor`
--

LOCK TABLES `dotp_communication_receptor` WRITE;
/*!40000 ALTER TABLE `dotp_communication_receptor` DISABLE KEYS */;
INSERT INTO `dotp_communication_receptor` VALUES (1,1,2),(2,1,10),(3,1,13),(4,2,13),(5,3,2),(6,3,10),(7,3,13),(8,4,3),(9,5,3),(10,6,22),(11,6,23),(12,7,11);
/*!40000 ALTER TABLE `dotp_communication_receptor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_companies`
--

DROP TABLE IF EXISTS `dotp_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_companies` (
  `company_id` int NOT NULL AUTO_INCREMENT,
  `company_module` int NOT NULL DEFAULT '0',
  `company_name` varchar(100) DEFAULT '',
  `company_phone1` varchar(30) DEFAULT '',
  `company_phone2` varchar(30) DEFAULT '',
  `company_fax` varchar(30) DEFAULT '',
  `company_address1` varchar(50) DEFAULT '',
  `company_address2` varchar(50) DEFAULT '',
  `company_city` varchar(30) DEFAULT '',
  `company_state` varchar(30) DEFAULT '',
  `company_zip` varchar(11) DEFAULT '',
  `company_primary_url` varchar(255) DEFAULT '',
  `company_owner` int NOT NULL DEFAULT '0',
  `company_description` text,
  `company_type` int NOT NULL DEFAULT '0',
  `company_email` varchar(255) DEFAULT NULL,
  `company_custom` longtext,
  PRIMARY KEY (`company_id`),
  KEY `idx_cpy1` (`company_owner`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_companies`
--

LOCK TABLES `dotp_companies` WRITE;
/*!40000 ALTER TABLE `dotp_companies` DISABLE KEYS */;
INSERT INTO `dotp_companies` VALUES (1,0,'Grupo de Qualidade de Software','32374107','','','Trindade, Campus Universitário','','Florianópolis','Santa Catarina','88063530','',1,'',6,'rafael.queiroz@posgrad.ufsc.br',NULL),(2,0,'Tribunal de Contas do Estado do Rio de Janeiro','','','','','','','','','',1,'',0,'teste',NULL),(3,0,'Code+','','','','','','','','','',11,NULL,0,NULL,NULL),(4,0,'Quality Software Group','+55 48 3456-7890','','+55 48 3456-7891','Trindade, Campus Universitário','','Florianópolis','Santa Catarina','88045-567','http://www.gqs.ufsc.br/',11,NULL,0,'contact@gqs.com',NULL),(5,0,'USO PESSOAL S/A','4721040800','','4721040800','Rua Joaquimm Garcia, S/n','','CamboriÃº','SC','88310456','http://www.camboriu.ifc.edu.br/',12,'Empresa criada de forma didÃ¡tica.',6,'usopessoal@ifc.edu.br',NULL),(6,0,'EMPRESA BSI18 LTDA','4721040800','','4721040800','Rua Joaquimm Garcia, S/n','','CamboriÃº','SC','88340000','http://www.camboriu.ifc.edu.br/',1,'Empresa de carÃ¡cter didÃ¡tico para os primeiros passos.',6,'bsi18@ifc.edu.br',NULL),(7,0,'[TSI-EaD] Instituto Federal Catarinense','47999812970','','473346-1161','Rua Joaquim Garcia, S/N','','CamboriÃº','SC','88340-000','http://www.camboriu.ifc.edu.br',1,'Instituto tem a missÃ£o de educar e formar bons cidadÃ£os!',5,'andre.moraes@ifc.edu.br',NULL),(8,0,'Empresa do Bruno','32374107','',NULL,'Rua Antonio Saturnino Cardoso, 307','','Navegantes','Santa Catarina','88370709',NULL,21,'Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.\r\n\r\nLorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.\r\n\r\nLorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.\r\n\r\nLorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.\r\n\r\nLorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.',6,'bruno200coelho@hotmail.com',NULL);
/*!40000 ALTER TABLE `dotp_companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_company_policies`
--

DROP TABLE IF EXISTS `dotp_company_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_company_policies` (
  `company_policies_id` int NOT NULL AUTO_INCREMENT,
  `company_policies_recognition` text,
  `company_policies_policy` text,
  `company_policies_safety` text,
  `company_policies_company_id` int NOT NULL,
  PRIMARY KEY (`company_policies_id`),
  KEY `company_policies_company_id` (`company_policies_company_id`),
  CONSTRAINT `dotp_company_policies_ibfk_1` FOREIGN KEY (`company_policies_company_id`) REFERENCES `dotp_companies` (`company_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_company_policies`
--

LOCK TABLES `dotp_company_policies` WRITE;
/*!40000 ALTER TABLE `dotp_company_policies` DISABLE KEYS */;
INSERT INTO `dotp_company_policies` VALUES (1,'recompensas...','regulamentos...','seguranÃ§a...',1),(2,'recompensa','regulamento','seguranÃ§a',2);
/*!40000 ALTER TABLE `dotp_company_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_company_role`
--

DROP TABLE IF EXISTS `dotp_company_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_company_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `role_name` text,
  `identation` text,
  PRIMARY KEY (`id`),
  KEY `fk_role_company` (`company_id`),
  CONSTRAINT `fk_role_company` FOREIGN KEY (`company_id`) REFERENCES `dotp_companies` (`company_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_company_role`
--

LOCK TABLES `dotp_company_role` WRITE;
/*!40000 ALTER TABLE `dotp_company_role` DISABLE KEYS */;
INSERT INTO `dotp_company_role` VALUES (1,1,0,'Gerente de projetos',''),(2,1,1,'Analista de sistemas','&nbsp;&nbsp;&nbsp;'),(3,2,0,'Programador TCE',''),(4,2,1,'Analista TCE',''),(5,1,2,'Analista de teste','&nbsp;&nbsp;&nbsp;'),(6,1,3,'Programador','&nbsp;&nbsp;&nbsp;'),(7,1,4,'Gerente da qualidade',''),(8,4,0,'Project Manager',''),(9,4,1,'System Analyst','&nbsp;&nbsp;&nbsp;'),(10,4,2,'Programmer','&nbsp;&nbsp;&nbsp;'),(11,3,0,'X',''),(12,6,0,'Gerente de Projetos',''),(13,6,1,'Programador','');
/*!40000 ALTER TABLE `dotp_company_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_config`
--

DROP TABLE IF EXISTS `dotp_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_config` (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `config_name` varchar(255) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL DEFAULT '',
  `config_group` varchar(255) NOT NULL DEFAULT '',
  `config_type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `config_name` (`config_name`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_config`
--

LOCK TABLES `dotp_config` WRITE;
/*!40000 ALTER TABLE `dotp_config` DISABLE KEYS */;
INSERT INTO `dotp_config` VALUES (1,'host_locale','en','ui','text'),(2,'check_overallocation','false','tasks','checkbox'),(3,'currency_symbol','R$','ui','text'),(4,'host_style','default','ui','text'),(5,'company_name','IFC','ui','text'),(6,'page_title','dotProject+','ui','text'),(7,'site_domain','example.com','ui','text'),(8,'email_prefix','[dotProject]','ui','text'),(9,'admin_username','admin','ui','text'),(10,'username_min_len','4','auth','text'),(11,'password_min_len','4','auth','text'),(12,'enable_gantt_charts','true','tasks','checkbox'),(13,'log_changes','false','','checkbox'),(14,'check_task_dates','true','tasks','checkbox'),(15,'check_task_empty_dynamic','false','tasks','checkbox'),(16,'locale_warn','false','ui','checkbox'),(17,'locale_alert','^','ui','text'),(18,'daily_working_hours','8','tasks','text'),(19,'display_debug','false','ui','checkbox'),(20,'link_tickets_kludge','false','tasks','checkbox'),(21,'show_all_task_assignees','false','tasks','checkbox'),(22,'direct_edit_assignment','false','tasks','checkbox'),(23,'restrict_color_selection','false','ui','checkbox'),(24,'cal_day_view_show_minical','true','calendar','checkbox'),(25,'cal_day_start','8','calendar','text'),(26,'cal_day_end','17','calendar','text'),(27,'cal_day_increment','15','calendar','text'),(28,'cal_working_days','1,2,3,4,5','calendar','text'),(29,'restrict_task_time_editing','false','tasks','checkbox'),(30,'default_view_m','projects','ui','text'),(31,'default_view_a','index','ui','text'),(32,'default_view_tab','1','ui','text'),(33,'index_max_file_size','-1','file','text'),(34,'session_handling','app','session','select'),(35,'session_idle_time','2d','session','text'),(36,'session_max_lifetime','1m','session','text'),(37,'debug','1','','text'),(38,'parser_default','/usr/bin/strings','file','text'),(39,'parser_application/msword','/usr/bin/strings','file','text'),(40,'parser_text/html','/usr/bin/strings','file','text'),(41,'parser_application/pdf','/usr/bin/pdftotext','file','text'),(42,'files_ci_preserve_attr','true','file','checkbox'),(43,'files_show_versions_edit','false','file','checkbox'),(44,'auth_method','sql','auth','select'),(45,'ldap_host','localhost','ldap','text'),(46,'ldap_port','389','ldap','text'),(47,'ldap_version','3','ldap','text'),(48,'ldap_base_dn','dc=saki,dc=com,dc=au','ldap','text'),(49,'ldap_user_filter','(uid=%USERNAME%)','ldap','text'),(50,'postnuke_allow_login','true','auth','checkbox'),(51,'reset_memory_limit','32M','tasks','text'),(52,'mail_transport','php','mail','select'),(53,'mail_host','localhost','mail','text'),(54,'mail_port','25','mail','text'),(55,'mail_auth','false','mail','checkbox'),(56,'mail_user','','mail','text'),(57,'mail_pass','','mail','password'),(58,'mail_defer','false','mail','checkbox'),(59,'mail_timeout','30','mail','text'),(60,'session_gc_scan_queue','false','session','checkbox'),(61,'task_reminder_control','false','task_reminder','checkbox'),(62,'task_reminder_days_before','1','task_reminder','text'),(63,'task_reminder_repeat','100','task_reminder','text'),(64,'gacl_cache','false','gacl','checkbox'),(65,'gacl_expire','true','gacl','checkbox'),(66,'gacl_cache_dir','/tmp','gacl','text'),(67,'gacl_timeout','600','gacl','text'),(68,'mail_smtp_tls','false','mail','checkbox'),(69,'ldap_search_user','Manager','ldap','text'),(70,'ldap_search_pass','secret','ldap','password'),(71,'ldap_allow_login','true','ldap','checkbox'),(72,'user_contact_inactivate','true','auth','checkbox'),(73,'user_contact_activate','false','auth','checkbox'),(74,'task_reminder_batch','false','task_reminder','checkbox');
/*!40000 ALTER TABLE `dotp_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_config_list`
--

DROP TABLE IF EXISTS `dotp_config_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_config_list` (
  `config_list_id` int NOT NULL AUTO_INCREMENT,
  `config_id` int NOT NULL DEFAULT '0',
  `config_list_name` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`config_list_id`),
  KEY `config_id` (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_config_list`
--

LOCK TABLES `dotp_config_list` WRITE;
/*!40000 ALTER TABLE `dotp_config_list` DISABLE KEYS */;
INSERT INTO `dotp_config_list` VALUES (1,44,'sql'),(2,44,'ldap'),(3,44,'pn'),(4,34,'app'),(5,34,'php'),(6,52,'php'),(7,52,'smtp');
/*!40000 ALTER TABLE `dotp_config_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_contacts`
--

DROP TABLE IF EXISTS `dotp_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_contacts` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `contact_first_name` varchar(30) DEFAULT NULL,
  `contact_last_name` varchar(30) DEFAULT NULL,
  `contact_order_by` varchar(30) NOT NULL DEFAULT '',
  `contact_title` varchar(50) DEFAULT NULL,
  `contact_birthday` date DEFAULT NULL,
  `contact_job` varchar(255) DEFAULT NULL,
  `contact_company` varchar(100) NOT NULL DEFAULT '',
  `contact_department` tinytext,
  `contact_type` varchar(20) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_email2` varchar(255) DEFAULT NULL,
  `contact_url` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `contact_phone2` varchar(30) DEFAULT NULL,
  `contact_fax` varchar(30) DEFAULT NULL,
  `contact_mobile` varchar(30) DEFAULT NULL,
  `contact_address1` varchar(60) DEFAULT NULL,
  `contact_address2` varchar(60) DEFAULT NULL,
  `contact_city` varchar(30) DEFAULT NULL,
  `contact_state` varchar(30) DEFAULT NULL,
  `contact_zip` varchar(11) DEFAULT NULL,
  `contact_country` varchar(30) DEFAULT NULL,
  `contact_jabber` varchar(255) DEFAULT NULL,
  `contact_icq` varchar(20) DEFAULT NULL,
  `contact_msn` varchar(255) DEFAULT NULL,
  `contact_yahoo` varchar(255) DEFAULT NULL,
  `contact_aol` varchar(30) DEFAULT NULL,
  `contact_notes` text,
  `contact_project` int NOT NULL DEFAULT '0',
  `contact_icon` varchar(20) DEFAULT 'obj/contact',
  `contact_owner` int unsigned DEFAULT '0',
  `contact_private` tinyint unsigned DEFAULT '0',
  PRIMARY KEY (`contact_id`),
  KEY `idx_oby` (`contact_order_by`),
  KEY `idx_co` (`contact_company`),
  KEY `idx_prp` (`contact_project`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_contacts`
--

LOCK TABLES `dotp_contacts` WRITE;
/*!40000 ALTER TABLE `dotp_contacts` DISABLE KEYS */;
INSERT INTO `dotp_contacts` VALUES (1,'Admin','Person','',NULL,NULL,NULL,'',NULL,NULL,'admin@example.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(2,'Lula','Molusco','',NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(3,'Bob','Esponja','',NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(4,'B','B_Sobrenome','',NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(5,'A','A_Sobrenome','',NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(6,'Patrick','C_Sobrenome','',NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(7,'teste','sobrenome','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(8,'Stakeholde','Segundo','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(9,'Stakeholder','primeiro','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(10,'Patrick','Estrela','',NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(11,'Gary','Caracol','Caracol, Gary','','0000-00-00','','1','0','','','','','','','','','','','','','','','','','','','','',0,'obj/contact',1,0),(12,'Sr.','Siriguejo','',NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(13,'Tio','Chico','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(14,'Sandy','Bochecha','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(15,'Plankton','Balde de Lixo','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(16,'Larry','Salva-vidas','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(17,'Ciclano','beltrano','',NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(18,'patrocinador','x','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(19,'admin','EN','',NULL,NULL,NULL,'0',NULL,NULL,'admin_en@dp.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',1,0),(20,'Group','1','',NULL,NULL,NULL,'0',NULL,NULL,'g1@dpp.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',11,0),(21,'Sponge','Bob','',NULL,NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(22,'Patrick','Star','',NULL,NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(23,'Mr','Plankton','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(24,'Goku','SS','',NULL,NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(25,'Vedita','SS','',NULL,NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(26,'teste','-','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(27,'Aluno 1','BSI18','',NULL,NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(28,'Aluno 2','BSI18','',NULL,NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'obj/contact',0,0),(30,'Andre Fabiano de','Moraes','Andre','','0000-00-00','Sr.','7','0','','','','','','','','','','','','','','','','','','','','',0,'obj/contact',1,0),(31,'Bruno','Ribas','Ribas, Bruno','','0000-00-00','Desenvolvedor PhP','1','0','','','','','','','','','','','','','','','','','','','','',0,'obj/contact',1,0);
/*!40000 ALTER TABLE `dotp_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_costs`
--

DROP TABLE IF EXISTS `dotp_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_costs` (
  `cost_id` int NOT NULL AUTO_INCREMENT,
  `cost_type_id` int NOT NULL,
  `cost_project_id` int NOT NULL,
  `cost_description` varchar(150) NOT NULL,
  `cost_quantity` int DEFAULT NULL,
  `cost_date_begin` datetime DEFAULT NULL,
  `cost_date_end` datetime DEFAULT NULL,
  `cost_value_unitary` decimal(9,2) DEFAULT NULL,
  `cost_value_total` decimal(9,2) DEFAULT NULL,
  `cost_human_resource_id` int DEFAULT NULL,
  `cost_human_resource_role_id` int DEFAULT NULL,
  PRIMARY KEY (`cost_id`),
  KEY `fk_cost_project_id` (`cost_project_id`),
  KEY `fk_cost_human_resource_role_id` (`cost_human_resource_role_id`),
  KEY `fk_cost_human_resource_id` (`cost_human_resource_id`),
  CONSTRAINT `fk_cost_human_resource_id` FOREIGN KEY (`cost_human_resource_id`) REFERENCES `dotp_human_resource` (`human_resource_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cost_human_resource_role_id` FOREIGN KEY (`cost_human_resource_role_id`) REFERENCES `dotp_human_resources_role` (`human_resources_role_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cost_project_id` FOREIGN KEY (`cost_project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_costs`
--

LOCK TABLES `dotp_costs` WRITE;
/*!40000 ALTER TABLE `dotp_costs` DISABLE KEYS */;
INSERT INTO `dotp_costs` VALUES (3,0,2,'Lula Molusco - Gerente de projetos',80,'2013-02-01 00:00:00','2013-07-31 00:00:00',60.00,28800.00,1,1),(5,0,2,'Bob Esponja - Programador',80,'2013-02-01 00:00:00','2013-07-31 00:00:00',35.00,16800.00,2,2),(7,1,2,'Dispositivo Mobile para testes',1,'2013-04-11 00:00:00','2013-04-11 00:00:00',2000.00,2000.00,NULL,NULL),(9,0,2,'Patrick Estrela - Programador',40,'2013-02-01 00:00:00','2013-07-31 00:00:00',33.00,7920.00,6,2),(13,0,2,'Bob Esponja - Analista de sistemas',25,'2013-02-01 00:00:00','2013-07-31 00:00:00',35.00,875.00,2,6),(14,0,2,'Gary Caracol - Gerente da qualidade',20,'2013-02-01 00:00:00','2013-07-31 00:00:00',40.00,4800.00,7,7),(15,0,2,'Sr. Siriguejo - Programador',80,'2013-02-01 00:00:00','2013-07-31 00:00:00',19.00,9120.00,8,2),(16,1,2,'Ingressos para o cinema',5,'2013-08-01 00:00:00','2013-08-01 00:00:00',20.00,100.00,NULL,NULL),(17,1,2,'Internet sem fio (wi-fi) e cabeada (ethernet)',1,'2013-02-01 00:00:00','2013-07-31 00:00:00',1530.00,1530.00,NULL,NULL),(18,1,2,'Máquina de café expresso',1,'2013-02-04 00:00:00','2013-02-04 00:00:00',963.00,963.00,NULL,NULL),(19,1,2,'Mesa de sinuca',1,'2013-04-01 00:00:00','2013-04-01 00:00:00',3000.00,3000.00,NULL,NULL),(20,1,2,'Notebook para desenvolvimento',1,'2013-03-01 00:00:00','2013-03-01 00:00:00',3000.00,3000.00,NULL,NULL),(21,1,2,'Pacote de pizzas promocionais Tio Chico',1,'2013-05-01 00:00:00','2013-05-01 00:00:00',1.00,1.00,NULL,NULL),(22,1,2,'Projetor',1,'2013-06-10 00:00:00','2013-06-10 00:00:00',1560.00,1560.00,NULL,NULL),(23,1,2,'Sala de reuniões',1,'2013-02-01 00:00:00','2013-07-31 00:00:00',250.00,250.00,NULL,NULL),(24,1,2,'Servidor de aplicação para testes',1,'2013-05-01 00:00:00','2013-05-01 00:00:00',2340.00,2340.00,NULL,NULL),(25,0,2,'Sr. Siriguejo - Gerente da qualidade',5,'2013-05-01 00:00:00','2013-07-31 00:00:00',19.00,285.00,8,7),(33,0,8,'Patrick Star - Programmer',15,'2016-03-14 00:00:00','2016-09-01 00:00:00',89.00,6675.00,10,9),(34,0,8,'Patrick Star - System Analyst',80,'2016-03-14 00:00:00','2016-04-14 00:00:00',89.00,7120.00,10,10),(35,0,8,'Sponge Bob - Project Manager',15,'2016-03-14 00:00:00','2016-09-01 00:00:00',45.00,3375.00,9,8),(36,1,8,'Mobile devices',3,'2016-04-01 00:00:00','2016-07-29 00:00:00',1320.00,3960.00,NULL,NULL),(37,1,8,'Notebook',2,'2016-03-01 00:00:00','2016-09-01 00:00:00',1890.00,3780.00,NULL,NULL),(38,1,8,'Pizzas',3,'2016-05-02 00:00:00','2016-05-31 00:00:00',45.00,135.00,NULL,NULL);
/*!40000 ALTER TABLE `dotp_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_custom_fields_lists`
--

DROP TABLE IF EXISTS `dotp_custom_fields_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_custom_fields_lists` (
  `field_id` int DEFAULT NULL,
  `list_option_id` int DEFAULT NULL,
  `list_value` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_custom_fields_lists`
--

LOCK TABLES `dotp_custom_fields_lists` WRITE;
/*!40000 ALTER TABLE `dotp_custom_fields_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_custom_fields_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_custom_fields_struct`
--

DROP TABLE IF EXISTS `dotp_custom_fields_struct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_custom_fields_struct` (
  `field_id` int NOT NULL,
  `field_module` varchar(30) DEFAULT NULL,
  `field_page` varchar(30) DEFAULT NULL,
  `field_htmltype` varchar(20) DEFAULT NULL,
  `field_datatype` varchar(20) DEFAULT NULL,
  `field_order` int DEFAULT NULL,
  `field_name` varchar(100) DEFAULT NULL,
  `field_extratags` varchar(250) DEFAULT NULL,
  `field_description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_custom_fields_struct`
--

LOCK TABLES `dotp_custom_fields_struct` WRITE;
/*!40000 ALTER TABLE `dotp_custom_fields_struct` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_custom_fields_struct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_custom_fields_values`
--

DROP TABLE IF EXISTS `dotp_custom_fields_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_custom_fields_values` (
  `value_id` int DEFAULT NULL,
  `value_module` varchar(30) DEFAULT NULL,
  `value_object_id` int DEFAULT NULL,
  `value_field_id` int DEFAULT NULL,
  `value_charvalue` varchar(250) DEFAULT NULL,
  `value_intvalue` int DEFAULT NULL,
  KEY `idx_cfv_id` (`value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_custom_fields_values`
--

LOCK TABLES `dotp_custom_fields_values` WRITE;
/*!40000 ALTER TABLE `dotp_custom_fields_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_custom_fields_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_departments`
--

DROP TABLE IF EXISTS `dotp_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_departments` (
  `dept_id` int unsigned NOT NULL AUTO_INCREMENT,
  `dept_parent` int unsigned NOT NULL DEFAULT '0',
  `dept_company` int unsigned NOT NULL DEFAULT '0',
  `dept_name` tinytext NOT NULL,
  `dept_phone` varchar(30) DEFAULT NULL,
  `dept_fax` varchar(30) DEFAULT NULL,
  `dept_address1` varchar(30) DEFAULT NULL,
  `dept_address2` varchar(30) DEFAULT NULL,
  `dept_city` varchar(30) DEFAULT NULL,
  `dept_state` varchar(30) DEFAULT NULL,
  `dept_zip` varchar(11) DEFAULT NULL,
  `dept_url` varchar(25) DEFAULT NULL,
  `dept_desc` text,
  `dept_owner` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Department heirarchy under a company';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_departments`
--

LOCK TABLES `dotp_departments` WRITE;
/*!40000 ALTER TABLE `dotp_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_dotpermissions`
--

DROP TABLE IF EXISTS `dotp_dotpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_dotpermissions` (
  `acl_id` int NOT NULL DEFAULT '0',
  `user_id` varchar(80) NOT NULL DEFAULT '',
  `section` varchar(80) NOT NULL DEFAULT '',
  `axo` varchar(80) NOT NULL DEFAULT '',
  `permission` varchar(80) NOT NULL DEFAULT '',
  `allow` int NOT NULL DEFAULT '0',
  `priority` int NOT NULL DEFAULT '0',
  `enabled` int NOT NULL DEFAULT '0',
  KEY `user_id` (`user_id`,`section`,`permission`,`axo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_dotpermissions`
--

LOCK TABLES `dotp_dotpermissions` WRITE;
/*!40000 ALTER TABLE `dotp_dotpermissions` DISABLE KEYS */;
INSERT INTO `dotp_dotpermissions` VALUES (17,'12','users','12','access',1,1,1),(17,'12','users','12','edit',1,1,1),(17,'12','users','12','view',1,1,1),(12,'1','sys','acl','access',1,3,1),(12,'11','sys','acl','access',1,3,1),(16,'12','app','users','access',1,3,1),(16,'12','app','users','view',1,3,1),(11,'1','app','admin','access',1,4,1),(11,'1','app','calendar','access',1,4,1),(11,'1','app','events','access',1,4,1),(11,'1','app','companies','access',1,4,1),(11,'1','app','contacts','access',1,4,1),(11,'1','app','departments','access',1,4,1),(11,'1','app','files','access',1,4,1),(11,'1','app','file_folders','access',1,4,1),(11,'1','app','forums','access',1,4,1),(11,'1','app','help','access',1,4,1),(11,'1','app','projects','access',1,4,1),(11,'1','app','system','access',1,4,1),(11,'1','app','tasks','access',1,4,1),(11,'1','app','task_log','access',1,4,1),(11,'1','app','ticketsmith','access',1,4,1),(11,'1','app','public','access',1,4,1),(11,'1','app','roles','access',1,4,1),(11,'1','app','users','access',1,4,1),(11,'1','app','closure','access',1,4,1),(11,'1','app','communication','access',1,4,1),(11,'1','app','costs','access',1,4,1),(11,'1','app','monitoringandcontrol','access',1,4,1),(11,'1','app','dotproject_plus','access',1,4,1),(11,'1','app','human_resources','access',1,4,1),(11,'1','app','risks','access',1,4,1),(11,'1','app','timeplanning','access',1,4,1),(11,'1','app','projectdesigner','access',1,4,1),(11,'1','app','scopeplanning','access',1,4,1),(11,'1','app','resources','access',1,4,1),(11,'1','app','history','access',1,4,1),(11,'1','app','links','access',1,4,1),(11,'1','app','smartsearch','access',1,4,1),(11,'1','app','admin','add',1,4,1),(11,'1','app','calendar','add',1,4,1),(11,'1','app','events','add',1,4,1),(11,'1','app','companies','add',1,4,1),(11,'1','app','contacts','add',1,4,1),(11,'1','app','departments','add',1,4,1),(11,'1','app','files','add',1,4,1),(11,'1','app','file_folders','add',1,4,1),(11,'1','app','forums','add',1,4,1),(11,'1','app','help','add',1,4,1),(11,'1','app','projects','add',1,4,1),(11,'1','app','system','add',1,4,1),(11,'1','app','tasks','add',1,4,1),(11,'1','app','task_log','add',1,4,1),(11,'1','app','ticketsmith','add',1,4,1),(11,'1','app','public','add',1,4,1),(11,'1','app','roles','add',1,4,1),(11,'1','app','users','add',1,4,1),(11,'1','app','closure','add',1,4,1),(11,'1','app','communication','add',1,4,1),(11,'1','app','costs','add',1,4,1),(11,'1','app','monitoringandcontrol','add',1,4,1),(11,'1','app','dotproject_plus','add',1,4,1),(11,'1','app','human_resources','add',1,4,1),(11,'1','app','risks','add',1,4,1),(11,'1','app','timeplanning','add',1,4,1),(11,'1','app','projectdesigner','add',1,4,1),(11,'1','app','scopeplanning','add',1,4,1),(11,'1','app','resources','add',1,4,1),(11,'1','app','history','add',1,4,1),(11,'1','app','links','add',1,4,1),(11,'1','app','smartsearch','add',1,4,1),(11,'1','app','admin','delete',1,4,1),(11,'1','app','calendar','delete',1,4,1),(11,'1','app','events','delete',1,4,1),(11,'1','app','companies','delete',1,4,1),(11,'1','app','contacts','delete',1,4,1),(11,'1','app','departments','delete',1,4,1),(11,'1','app','files','delete',1,4,1),(11,'1','app','file_folders','delete',1,4,1),(11,'1','app','forums','delete',1,4,1),(11,'1','app','help','delete',1,4,1),(11,'1','app','projects','delete',1,4,1),(11,'1','app','system','delete',1,4,1),(11,'1','app','tasks','delete',1,4,1),(11,'1','app','task_log','delete',1,4,1),(11,'1','app','ticketsmith','delete',1,4,1),(11,'1','app','public','delete',1,4,1),(11,'1','app','roles','delete',1,4,1),(11,'1','app','users','delete',1,4,1),(11,'1','app','closure','delete',1,4,1),(11,'1','app','communication','delete',1,4,1),(11,'1','app','costs','delete',1,4,1),(11,'1','app','monitoringandcontrol','delete',1,4,1),(11,'1','app','dotproject_plus','delete',1,4,1),(11,'1','app','human_resources','delete',1,4,1),(11,'1','app','risks','delete',1,4,1),(11,'1','app','timeplanning','delete',1,4,1),(11,'1','app','projectdesigner','delete',1,4,1),(11,'1','app','scopeplanning','delete',1,4,1),(11,'1','app','resources','delete',1,4,1),(11,'1','app','history','delete',1,4,1),(11,'1','app','links','delete',1,4,1),(11,'1','app','smartsearch','delete',1,4,1),(11,'1','app','admin','edit',1,4,1),(11,'1','app','calendar','edit',1,4,1),(11,'1','app','events','edit',1,4,1),(11,'1','app','companies','edit',1,4,1),(11,'1','app','contacts','edit',1,4,1),(11,'1','app','departments','edit',1,4,1),(11,'1','app','files','edit',1,4,1),(11,'1','app','file_folders','edit',1,4,1),(11,'1','app','forums','edit',1,4,1),(11,'1','app','help','edit',1,4,1),(11,'1','app','projects','edit',1,4,1),(11,'1','app','system','edit',1,4,1),(11,'1','app','tasks','edit',1,4,1),(11,'1','app','task_log','edit',1,4,1),(11,'1','app','ticketsmith','edit',1,4,1),(11,'1','app','public','edit',1,4,1),(11,'1','app','roles','edit',1,4,1),(11,'1','app','users','edit',1,4,1),(11,'1','app','closure','edit',1,4,1),(11,'1','app','communication','edit',1,4,1),(11,'1','app','costs','edit',1,4,1),(11,'1','app','monitoringandcontrol','edit',1,4,1),(11,'1','app','dotproject_plus','edit',1,4,1),(11,'1','app','human_resources','edit',1,4,1),(11,'1','app','risks','edit',1,4,1),(11,'1','app','timeplanning','edit',1,4,1),(11,'1','app','projectdesigner','edit',1,4,1),(11,'1','app','scopeplanning','edit',1,4,1),(11,'1','app','resources','edit',1,4,1),(11,'1','app','history','edit',1,4,1),(11,'1','app','links','edit',1,4,1),(11,'1','app','smartsearch','edit',1,4,1),(11,'1','app','admin','view',1,4,1),(11,'1','app','calendar','view',1,4,1),(11,'1','app','events','view',1,4,1),(11,'1','app','companies','view',1,4,1),(11,'1','app','contacts','view',1,4,1),(11,'1','app','departments','view',1,4,1),(11,'1','app','files','view',1,4,1),(11,'1','app','file_folders','view',1,4,1),(11,'1','app','forums','view',1,4,1),(11,'1','app','help','view',1,4,1),(11,'1','app','projects','view',1,4,1),(11,'1','app','system','view',1,4,1),(11,'1','app','tasks','view',1,4,1),(11,'1','app','task_log','view',1,4,1),(11,'1','app','ticketsmith','view',1,4,1),(11,'1','app','public','view',1,4,1),(11,'1','app','roles','view',1,4,1),(11,'1','app','users','view',1,4,1),(11,'1','app','closure','view',1,4,1),(11,'1','app','communication','view',1,4,1),(11,'1','app','costs','view',1,4,1),(11,'1','app','monitoringandcontrol','view',1,4,1),(11,'1','app','dotproject_plus','view',1,4,1),(11,'1','app','human_resources','view',1,4,1),(11,'1','app','risks','view',1,4,1),(11,'1','app','timeplanning','view',1,4,1),(11,'1','app','projectdesigner','view',1,4,1),(11,'1','app','scopeplanning','view',1,4,1),(11,'1','app','resources','view',1,4,1),(11,'1','app','history','view',1,4,1),(11,'1','app','links','view',1,4,1),(11,'1','app','smartsearch','view',1,4,1),(11,'11','app','admin','access',1,4,1),(11,'11','app','calendar','access',1,4,1),(11,'11','app','events','access',1,4,1),(11,'11','app','companies','access',1,4,1),(11,'11','app','contacts','access',1,4,1),(11,'11','app','departments','access',1,4,1),(11,'11','app','files','access',1,4,1),(11,'11','app','file_folders','access',1,4,1),(11,'11','app','forums','access',1,4,1),(11,'11','app','help','access',1,4,1),(11,'11','app','projects','access',1,4,1),(11,'11','app','system','access',1,4,1),(11,'11','app','tasks','access',1,4,1),(11,'11','app','task_log','access',1,4,1),(11,'11','app','ticketsmith','access',1,4,1),(11,'11','app','public','access',1,4,1),(11,'11','app','roles','access',1,4,1),(11,'11','app','users','access',1,4,1),(11,'11','app','closure','access',1,4,1),(11,'11','app','communication','access',1,4,1),(11,'11','app','costs','access',1,4,1),(11,'11','app','monitoringandcontrol','access',1,4,1),(11,'11','app','dotproject_plus','access',1,4,1),(11,'11','app','human_resources','access',1,4,1),(11,'11','app','risks','access',1,4,1),(11,'11','app','timeplanning','access',1,4,1),(11,'11','app','projectdesigner','access',1,4,1),(11,'11','app','scopeplanning','access',1,4,1),(11,'11','app','resources','access',1,4,1),(11,'11','app','history','access',1,4,1),(11,'11','app','links','access',1,4,1),(11,'11','app','smartsearch','access',1,4,1),(11,'11','app','admin','add',1,4,1),(11,'11','app','calendar','add',1,4,1),(11,'11','app','events','add',1,4,1),(11,'11','app','companies','add',1,4,1),(11,'11','app','contacts','add',1,4,1),(11,'11','app','departments','add',1,4,1),(11,'11','app','files','add',1,4,1),(11,'11','app','file_folders','add',1,4,1),(11,'11','app','forums','add',1,4,1),(11,'11','app','help','add',1,4,1),(11,'11','app','projects','add',1,4,1),(11,'11','app','system','add',1,4,1),(11,'11','app','tasks','add',1,4,1),(11,'11','app','task_log','add',1,4,1),(11,'11','app','ticketsmith','add',1,4,1),(11,'11','app','public','add',1,4,1),(11,'11','app','roles','add',1,4,1),(11,'11','app','users','add',1,4,1),(11,'11','app','closure','add',1,4,1),(11,'11','app','communication','add',1,4,1),(11,'11','app','costs','add',1,4,1),(11,'11','app','monitoringandcontrol','add',1,4,1),(11,'11','app','dotproject_plus','add',1,4,1),(11,'11','app','human_resources','add',1,4,1),(11,'11','app','risks','add',1,4,1),(11,'11','app','timeplanning','add',1,4,1),(11,'11','app','projectdesigner','add',1,4,1),(11,'11','app','scopeplanning','add',1,4,1),(11,'11','app','resources','add',1,4,1),(11,'11','app','history','add',1,4,1),(11,'11','app','links','add',1,4,1),(11,'11','app','smartsearch','add',1,4,1),(11,'11','app','admin','delete',1,4,1),(11,'11','app','calendar','delete',1,4,1),(11,'11','app','events','delete',1,4,1),(11,'11','app','companies','delete',1,4,1),(11,'11','app','contacts','delete',1,4,1),(11,'11','app','departments','delete',1,4,1),(11,'11','app','files','delete',1,4,1),(11,'11','app','file_folders','delete',1,4,1),(11,'11','app','forums','delete',1,4,1),(11,'11','app','help','delete',1,4,1),(11,'11','app','projects','delete',1,4,1),(11,'11','app','system','delete',1,4,1),(11,'11','app','tasks','delete',1,4,1),(11,'11','app','task_log','delete',1,4,1),(11,'11','app','ticketsmith','delete',1,4,1),(11,'11','app','public','delete',1,4,1),(11,'11','app','roles','delete',1,4,1),(11,'11','app','users','delete',1,4,1),(11,'11','app','closure','delete',1,4,1),(11,'11','app','communication','delete',1,4,1),(11,'11','app','costs','delete',1,4,1),(11,'11','app','monitoringandcontrol','delete',1,4,1),(11,'11','app','dotproject_plus','delete',1,4,1),(11,'11','app','human_resources','delete',1,4,1),(11,'11','app','risks','delete',1,4,1),(11,'11','app','timeplanning','delete',1,4,1),(11,'11','app','projectdesigner','delete',1,4,1),(11,'11','app','scopeplanning','delete',1,4,1),(11,'11','app','resources','delete',1,4,1),(11,'11','app','history','delete',1,4,1),(11,'11','app','links','delete',1,4,1),(11,'11','app','smartsearch','delete',1,4,1),(11,'11','app','admin','edit',1,4,1),(11,'11','app','calendar','edit',1,4,1),(11,'11','app','events','edit',1,4,1),(11,'11','app','companies','edit',1,4,1),(11,'11','app','contacts','edit',1,4,1),(11,'11','app','departments','edit',1,4,1),(11,'11','app','files','edit',1,4,1),(11,'11','app','file_folders','edit',1,4,1),(11,'11','app','forums','edit',1,4,1),(11,'11','app','help','edit',1,4,1),(11,'11','app','projects','edit',1,4,1),(11,'11','app','system','edit',1,4,1),(11,'11','app','tasks','edit',1,4,1),(11,'11','app','task_log','edit',1,4,1),(11,'11','app','ticketsmith','edit',1,4,1),(11,'11','app','public','edit',1,4,1),(11,'11','app','roles','edit',1,4,1),(11,'11','app','users','edit',1,4,1),(11,'11','app','closure','edit',1,4,1),(11,'11','app','communication','edit',1,4,1),(11,'11','app','costs','edit',1,4,1),(11,'11','app','monitoringandcontrol','edit',1,4,1),(11,'11','app','dotproject_plus','edit',1,4,1),(11,'11','app','human_resources','edit',1,4,1),(11,'11','app','risks','edit',1,4,1),(11,'11','app','timeplanning','edit',1,4,1),(11,'11','app','projectdesigner','edit',1,4,1),(11,'11','app','scopeplanning','edit',1,4,1),(11,'11','app','resources','edit',1,4,1),(11,'11','app','history','edit',1,4,1),(11,'11','app','links','edit',1,4,1),(11,'11','app','smartsearch','edit',1,4,1),(11,'11','app','admin','view',1,4,1),(11,'11','app','calendar','view',1,4,1),(11,'11','app','events','view',1,4,1),(11,'11','app','companies','view',1,4,1),(11,'11','app','contacts','view',1,4,1),(11,'11','app','departments','view',1,4,1),(11,'11','app','files','view',1,4,1),(11,'11','app','file_folders','view',1,4,1),(11,'11','app','forums','view',1,4,1),(11,'11','app','help','view',1,4,1),(11,'11','app','projects','view',1,4,1),(11,'11','app','system','view',1,4,1),(11,'11','app','tasks','view',1,4,1),(11,'11','app','task_log','view',1,4,1),(11,'11','app','ticketsmith','view',1,4,1),(11,'11','app','public','view',1,4,1),(11,'11','app','roles','view',1,4,1),(11,'11','app','users','view',1,4,1),(11,'11','app','closure','view',1,4,1),(11,'11','app','communication','view',1,4,1),(11,'11','app','costs','view',1,4,1),(11,'11','app','monitoringandcontrol','view',1,4,1),(11,'11','app','dotproject_plus','view',1,4,1),(11,'11','app','human_resources','view',1,4,1),(11,'11','app','risks','view',1,4,1),(11,'11','app','timeplanning','view',1,4,1),(11,'11','app','projectdesigner','view',1,4,1),(11,'11','app','scopeplanning','view',1,4,1),(11,'11','app','resources','view',1,4,1),(11,'11','app','history','view',1,4,1),(11,'11','app','links','view',1,4,1),(11,'11','app','smartsearch','view',1,4,1),(15,'12','app','calendar','access',1,4,1),(15,'12','app','events','access',1,4,1),(15,'12','app','companies','access',1,4,1),(15,'12','app','contacts','access',1,4,1),(15,'12','app','departments','access',1,4,1),(15,'12','app','files','access',1,4,1),(15,'12','app','file_folders','access',1,4,1),(15,'12','app','forums','access',1,4,1),(15,'12','app','help','access',1,4,1),(15,'12','app','projects','access',1,4,1),(15,'12','app','tasks','access',1,4,1),(15,'12','app','task_log','access',1,4,1),(15,'12','app','ticketsmith','access',1,4,1),(15,'12','app','public','access',1,4,1),(15,'12','app','closure','access',1,4,1),(15,'12','app','communication','access',1,4,1),(15,'12','app','costs','access',1,4,1),(15,'12','app','monitoringandcontrol','access',1,4,1),(15,'12','app','dotproject_plus','access',1,4,1),(15,'12','app','human_resources','access',1,4,1),(15,'12','app','risks','access',1,4,1),(15,'12','app','timeplanning','access',1,4,1),(15,'12','app','projectdesigner','access',1,4,1),(15,'12','app','scopeplanning','access',1,4,1),(15,'12','app','resources','access',1,4,1),(15,'12','app','history','access',1,4,1),(15,'12','app','links','access',1,4,1),(15,'12','app','smartsearch','access',1,4,1),(15,'12','app','calendar','add',1,4,1),(15,'12','app','events','add',1,4,1),(15,'12','app','companies','add',1,4,1),(15,'12','app','contacts','add',1,4,1),(15,'12','app','departments','add',1,4,1),(15,'12','app','files','add',1,4,1),(15,'12','app','file_folders','add',1,4,1),(15,'12','app','forums','add',1,4,1),(15,'12','app','help','add',1,4,1),(15,'12','app','projects','add',1,4,1),(15,'12','app','tasks','add',1,4,1),(15,'12','app','task_log','add',1,4,1),(15,'12','app','ticketsmith','add',1,4,1),(15,'12','app','public','add',1,4,1),(15,'12','app','closure','add',1,4,1),(15,'12','app','communication','add',1,4,1),(15,'12','app','costs','add',1,4,1),(15,'12','app','monitoringandcontrol','add',1,4,1),(15,'12','app','dotproject_plus','add',1,4,1),(15,'12','app','human_resources','add',1,4,1),(15,'12','app','risks','add',1,4,1),(15,'12','app','timeplanning','add',1,4,1),(15,'12','app','projectdesigner','add',1,4,1),(15,'12','app','scopeplanning','add',1,4,1),(15,'12','app','resources','add',1,4,1),(15,'12','app','history','add',1,4,1),(15,'12','app','links','add',1,4,1),(15,'12','app','smartsearch','add',1,4,1),(15,'12','app','calendar','delete',1,4,1),(15,'12','app','events','delete',1,4,1),(15,'12','app','companies','delete',1,4,1),(15,'12','app','contacts','delete',1,4,1),(15,'12','app','departments','delete',1,4,1),(15,'12','app','files','delete',1,4,1),(15,'12','app','file_folders','delete',1,4,1),(15,'12','app','forums','delete',1,4,1),(15,'12','app','help','delete',1,4,1),(15,'12','app','projects','delete',1,4,1),(15,'12','app','tasks','delete',1,4,1),(15,'12','app','task_log','delete',1,4,1),(15,'12','app','ticketsmith','delete',1,4,1),(15,'12','app','public','delete',1,4,1),(15,'12','app','closure','delete',1,4,1),(15,'12','app','communication','delete',1,4,1),(15,'12','app','costs','delete',1,4,1),(15,'12','app','monitoringandcontrol','delete',1,4,1),(15,'12','app','dotproject_plus','delete',1,4,1),(15,'12','app','human_resources','delete',1,4,1),(15,'12','app','risks','delete',1,4,1),(15,'12','app','timeplanning','delete',1,4,1),(15,'12','app','projectdesigner','delete',1,4,1),(15,'12','app','scopeplanning','delete',1,4,1),(15,'12','app','resources','delete',1,4,1),(15,'12','app','history','delete',1,4,1),(15,'12','app','links','delete',1,4,1),(15,'12','app','smartsearch','delete',1,4,1),(15,'12','app','calendar','edit',1,4,1),(15,'12','app','events','edit',1,4,1),(15,'12','app','companies','edit',1,4,1),(15,'12','app','contacts','edit',1,4,1),(15,'12','app','departments','edit',1,4,1),(15,'12','app','files','edit',1,4,1),(15,'12','app','file_folders','edit',1,4,1),(15,'12','app','forums','edit',1,4,1),(15,'12','app','help','edit',1,4,1),(15,'12','app','projects','edit',1,4,1),(15,'12','app','tasks','edit',1,4,1),(15,'12','app','task_log','edit',1,4,1),(15,'12','app','ticketsmith','edit',1,4,1),(15,'12','app','public','edit',1,4,1),(15,'12','app','closure','edit',1,4,1),(15,'12','app','communication','edit',1,4,1),(15,'12','app','costs','edit',1,4,1),(15,'12','app','monitoringandcontrol','edit',1,4,1),(15,'12','app','dotproject_plus','edit',1,4,1),(15,'12','app','human_resources','edit',1,4,1),(15,'12','app','risks','edit',1,4,1),(15,'12','app','timeplanning','edit',1,4,1),(15,'12','app','projectdesigner','edit',1,4,1),(15,'12','app','scopeplanning','edit',1,4,1),(15,'12','app','resources','edit',1,4,1),(15,'12','app','history','edit',1,4,1),(15,'12','app','links','edit',1,4,1),(15,'12','app','smartsearch','edit',1,4,1),(15,'12','app','calendar','view',1,4,1),(15,'12','app','events','view',1,4,1),(15,'12','app','companies','view',1,4,1),(15,'12','app','contacts','view',1,4,1),(15,'12','app','departments','view',1,4,1),(15,'12','app','files','view',1,4,1),(15,'12','app','file_folders','view',1,4,1),(15,'12','app','forums','view',1,4,1),(15,'12','app','help','view',1,4,1),(15,'12','app','projects','view',1,4,1),(15,'12','app','tasks','view',1,4,1),(15,'12','app','task_log','view',1,4,1),(15,'12','app','ticketsmith','view',1,4,1),(15,'12','app','public','view',1,4,1),(15,'12','app','closure','view',1,4,1),(15,'12','app','communication','view',1,4,1),(15,'12','app','costs','view',1,4,1),(15,'12','app','monitoringandcontrol','view',1,4,1),(15,'12','app','dotproject_plus','view',1,4,1),(15,'12','app','human_resources','view',1,4,1),(15,'12','app','risks','view',1,4,1),(15,'12','app','timeplanning','view',1,4,1),(15,'12','app','projectdesigner','view',1,4,1),(15,'12','app','scopeplanning','view',1,4,1),(15,'12','app','resources','view',1,4,1),(15,'12','app','history','view',1,4,1),(15,'12','app','links','view',1,4,1),(15,'12','app','smartsearch','view',1,4,1);
/*!40000 ALTER TABLE `dotp_dotpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_dpversion`
--

DROP TABLE IF EXISTS `dotp_dpversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_dpversion` (
  `code_version` varchar(10) NOT NULL DEFAULT '',
  `db_version` int NOT NULL DEFAULT '0',
  `last_db_update` date NOT NULL DEFAULT '0000-00-00',
  `last_code_update` date NOT NULL DEFAULT '0000-00-00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_dpversion`
--

LOCK TABLES `dotp_dpversion` WRITE;
/*!40000 ALTER TABLE `dotp_dpversion` DISABLE KEYS */;
INSERT INTO `dotp_dpversion` VALUES ('2.1.8',2,'2013-01-05','2013-07-27');
/*!40000 ALTER TABLE `dotp_dpversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_eap_item_estimations`
--

DROP TABLE IF EXISTS `dotp_eap_item_estimations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_eap_item_estimations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `eap_item_id` int DEFAULT NULL,
  `size` float DEFAULT NULL,
  `size_unit` text,
  PRIMARY KEY (`id`),
  KEY `fk_estimation_eap_item` (`eap_item_id`),
  CONSTRAINT `fk_estimation_eap_item` FOREIGN KEY (`eap_item_id`) REFERENCES `dotp_project_eap_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_eap_item_estimations`
--

LOCK TABLES `dotp_eap_item_estimations` WRITE;
/*!40000 ALTER TABLE `dotp_eap_item_estimations` DISABLE KEYS */;
INSERT INTO `dotp_eap_item_estimations` VALUES (52,79,0,''),(53,80,0,''),(55,82,0,''),(56,83,0,''),(57,84,0,''),(58,85,0,''),(59,86,0,''),(60,87,90,'Slides'),(61,88,2,'documentos de aceite'),(62,89,3,'dispositivos configurados'),(63,90,4,'páginas web'),(66,93,320,'Pontos de Função'),(67,94,245,'Pontos de Função'),(69,96,292,'Pontos de Função'),(70,97,0,''),(71,98,87,'Pontos de Função'),(72,99,345,'Pontos de Função'),(73,100,267,'Pontos de Função'),(74,101,4,'protótipos de tela'),(75,102,9,'diagramas'),(76,103,4,'páginas'),(77,104,0,''),(78,105,0,''),(79,106,0,''),(80,107,15,'páginas'),(81,108,5,'contratos'),(82,109,1,'planilha de avaliação'),(83,110,1,'planilha de inspeção'),(84,111,12,'páginas'),(85,112,3,'reuniões'),(86,113,3,'páginas'),(87,114,2,'páginas'),(88,115,1,'documento assinado'),(130,158,0,''),(131,159,0,''),(132,160,0,''),(133,161,0,''),(154,182,0,'');
/*!40000 ALTER TABLE `dotp_eap_item_estimations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_event_queue`
--

DROP TABLE IF EXISTS `dotp_event_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_event_queue` (
  `queue_id` int NOT NULL AUTO_INCREMENT,
  `queue_start` int NOT NULL DEFAULT '0',
  `queue_type` varchar(40) NOT NULL DEFAULT '',
  `queue_repeat_interval` int NOT NULL DEFAULT '0',
  `queue_repeat_count` int NOT NULL DEFAULT '0',
  `queue_data` longblob NOT NULL,
  `queue_callback` varchar(127) NOT NULL DEFAULT '',
  `queue_owner` int NOT NULL DEFAULT '0',
  `queue_origin_id` int NOT NULL DEFAULT '0',
  `queue_module` varchar(40) NOT NULL DEFAULT '',
  `queue_batched` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`queue_id`),
  KEY `queue_start` (`queue_batched`,`queue_start`),
  KEY `queue_module` (`queue_module`),
  KEY `queue_type` (`queue_type`),
  KEY `queue_origin_id` (`queue_origin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_event_queue`
--

LOCK TABLES `dotp_event_queue` WRITE;
/*!40000 ALTER TABLE `dotp_event_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_event_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_events`
--

DROP TABLE IF EXISTS `dotp_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_title` varchar(255) NOT NULL DEFAULT '',
  `event_start_date` datetime DEFAULT NULL,
  `event_end_date` datetime DEFAULT NULL,
  `event_parent` int unsigned NOT NULL DEFAULT '0',
  `event_description` text,
  `event_times_recuring` int unsigned NOT NULL DEFAULT '0',
  `event_recurs` int unsigned NOT NULL DEFAULT '0',
  `event_remind` int unsigned NOT NULL DEFAULT '0',
  `event_icon` varchar(20) DEFAULT 'obj/event',
  `event_owner` int DEFAULT '0',
  `event_project` int DEFAULT '0',
  `event_private` tinyint DEFAULT '0',
  `event_type` tinyint DEFAULT '0',
  `event_cwd` tinyint DEFAULT '0',
  `event_notify` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_id`),
  KEY `id_esd` (`event_start_date`),
  KEY `id_eed` (`event_end_date`),
  KEY `id_evp` (`event_parent`),
  KEY `idx_ev1` (`event_owner`),
  KEY `idx_ev2` (`event_project`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_events`
--

LOCK TABLES `dotp_events` WRITE;
/*!40000 ALTER TABLE `dotp_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_file_folders`
--

DROP TABLE IF EXISTS `dotp_file_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_file_folders` (
  `file_folder_id` int NOT NULL AUTO_INCREMENT,
  `file_folder_parent` int NOT NULL DEFAULT '0',
  `file_folder_name` varchar(255) NOT NULL DEFAULT '',
  `file_folder_description` text,
  PRIMARY KEY (`file_folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_file_folders`
--

LOCK TABLES `dotp_file_folders` WRITE;
/*!40000 ALTER TABLE `dotp_file_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_file_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_files`
--

DROP TABLE IF EXISTS `dotp_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_files` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `file_real_filename` varchar(255) NOT NULL DEFAULT '',
  `file_folder` int NOT NULL DEFAULT '0',
  `file_project` int NOT NULL DEFAULT '0',
  `file_task` int NOT NULL DEFAULT '0',
  `file_name` varchar(255) NOT NULL DEFAULT '',
  `file_parent` int DEFAULT '0',
  `file_description` text,
  `file_type` varchar(100) DEFAULT NULL,
  `file_owner` int DEFAULT '0',
  `file_date` datetime DEFAULT NULL,
  `file_size` int DEFAULT '0',
  `file_version` float NOT NULL DEFAULT '0',
  `file_icon` varchar(20) DEFAULT 'obj/',
  `file_category` int DEFAULT '0',
  `file_checkout` varchar(255) NOT NULL DEFAULT '',
  `file_co_reason` text,
  `file_version_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`file_id`),
  KEY `idx_file_task` (`file_task`),
  KEY `idx_file_project` (`file_project`),
  KEY `idx_file_parent` (`file_parent`),
  KEY `idx_file_vid` (`file_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_files`
--

LOCK TABLES `dotp_files` WRITE;
/*!40000 ALTER TABLE `dotp_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_files_index`
--

DROP TABLE IF EXISTS `dotp_files_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_files_index` (
  `file_id` int NOT NULL DEFAULT '0',
  `word` varchar(50) NOT NULL DEFAULT '',
  `word_placement` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`file_id`,`word`,`word_placement`),
  KEY `idx_fwrd` (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_files_index`
--

LOCK TABLES `dotp_files_index` WRITE;
/*!40000 ALTER TABLE `dotp_files_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_files_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_forum_messages`
--

DROP TABLE IF EXISTS `dotp_forum_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_forum_messages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `message_forum` int NOT NULL DEFAULT '0',
  `message_parent` int NOT NULL DEFAULT '0',
  `message_author` int NOT NULL DEFAULT '0',
  `message_editor` int NOT NULL DEFAULT '0',
  `message_title` varchar(255) NOT NULL DEFAULT '',
  `message_date` datetime DEFAULT '0000-00-00 00:00:00',
  `message_body` text,
  `message_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`message_id`),
  KEY `idx_mparent` (`message_parent`),
  KEY `idx_mdate` (`message_date`),
  KEY `idx_mforum` (`message_forum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_forum_messages`
--

LOCK TABLES `dotp_forum_messages` WRITE;
/*!40000 ALTER TABLE `dotp_forum_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_forum_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_forum_visits`
--

DROP TABLE IF EXISTS `dotp_forum_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_forum_visits` (
  `visit_user` int NOT NULL DEFAULT '0',
  `visit_forum` int NOT NULL DEFAULT '0',
  `visit_message` int NOT NULL DEFAULT '0',
  `visit_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `idx_fv` (`visit_user`,`visit_forum`,`visit_message`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_forum_visits`
--

LOCK TABLES `dotp_forum_visits` WRITE;
/*!40000 ALTER TABLE `dotp_forum_visits` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_forum_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_forum_watch`
--

DROP TABLE IF EXISTS `dotp_forum_watch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_forum_watch` (
  `watch_user` int unsigned NOT NULL DEFAULT '0',
  `watch_forum` int unsigned DEFAULT NULL,
  `watch_topic` int unsigned DEFAULT NULL,
  KEY `idx_fw1` (`watch_user`,`watch_forum`),
  KEY `idx_fw2` (`watch_user`,`watch_topic`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Links users to the forums/messages they are watching';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_forum_watch`
--

LOCK TABLES `dotp_forum_watch` WRITE;
/*!40000 ALTER TABLE `dotp_forum_watch` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_forum_watch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_forums`
--

DROP TABLE IF EXISTS `dotp_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_forums` (
  `forum_id` int NOT NULL AUTO_INCREMENT,
  `forum_project` int NOT NULL DEFAULT '0',
  `forum_status` tinyint NOT NULL DEFAULT '-1',
  `forum_owner` int NOT NULL DEFAULT '0',
  `forum_name` varchar(50) NOT NULL DEFAULT '',
  `forum_create_date` datetime DEFAULT '0000-00-00 00:00:00',
  `forum_last_date` datetime DEFAULT '0000-00-00 00:00:00',
  `forum_last_id` int unsigned NOT NULL DEFAULT '0',
  `forum_message_count` int NOT NULL DEFAULT '0',
  `forum_description` varchar(255) DEFAULT NULL,
  `forum_moderated` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`forum_id`),
  KEY `idx_fproject` (`forum_project`),
  KEY `idx_fowner` (`forum_owner`),
  KEY `forum_status` (`forum_status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_forums`
--

LOCK TABLES `dotp_forums` WRITE;
/*!40000 ALTER TABLE `dotp_forums` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_forums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_acl`
--

DROP TABLE IF EXISTS `dotp_gacl_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_acl` (
  `id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT 'system',
  `allow` int NOT NULL DEFAULT '0',
  `enabled` int NOT NULL DEFAULT '0',
  `return_value` longtext,
  `note` longtext,
  `updated_date` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `gacl_enabled_acl` (`enabled`),
  KEY `gacl_section_value_acl` (`section_value`),
  KEY `gacl_updated_date_acl` (`updated_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_acl`
--

LOCK TABLES `dotp_gacl_acl` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_acl` DISABLE KEYS */;
INSERT INTO `dotp_gacl_acl` VALUES (10,'user',1,1,NULL,NULL,1412183504),(11,'user',1,1,NULL,NULL,1412183504),(12,'user',1,1,NULL,NULL,1412183504),(13,'user',1,1,NULL,NULL,1412183504),(14,'user',1,1,NULL,NULL,1412183504),(15,'user',1,1,NULL,NULL,1412183504),(16,'user',1,1,NULL,NULL,1412183505),(17,'user',1,1,NULL,NULL,1459465804);
/*!40000 ALTER TABLE `dotp_gacl_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_acl_sections`
--

DROP TABLE IF EXISTS `dotp_gacl_acl_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_acl_sections` (
  `id` int NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_acl_sections` (`value`),
  KEY `gacl_hidden_acl_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_acl_sections`
--

LOCK TABLES `dotp_gacl_acl_sections` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_acl_sections` DISABLE KEYS */;
INSERT INTO `dotp_gacl_acl_sections` VALUES (1,'system',1,'System',0),(2,'user',2,'User',0);
/*!40000 ALTER TABLE `dotp_gacl_acl_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_acl_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_acl_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_acl_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_acl_seq`
--

LOCK TABLES `dotp_gacl_acl_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_acl_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_acl_seq` VALUES (17);
/*!40000 ALTER TABLE `dotp_gacl_acl_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aco`
--

DROP TABLE IF EXISTS `dotp_gacl_aco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aco` (
  `id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_aco` (`section_value`,`value`),
  KEY `gacl_hidden_aco` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aco`
--

LOCK TABLES `dotp_gacl_aco` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aco` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aco` VALUES (10,'system','login',1,'Login',0),(11,'application','access',1,'Access',0),(12,'application','view',2,'View',0),(13,'application','add',3,'Add',0),(14,'application','edit',4,'Edit',0),(15,'application','delete',5,'Delete',0);
/*!40000 ALTER TABLE `dotp_gacl_aco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aco_map`
--

DROP TABLE IF EXISTS `dotp_gacl_aco_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aco_map` (
  `acl_id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aco_map`
--

LOCK TABLES `dotp_gacl_aco_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aco_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aco_map` VALUES (10,'system','login'),(11,'application','access'),(11,'application','add'),(11,'application','delete'),(11,'application','edit'),(11,'application','view'),(12,'application','access'),(13,'application','access'),(13,'application','view'),(14,'application','access'),(15,'application','access'),(15,'application','add'),(15,'application','delete'),(15,'application','edit'),(15,'application','view'),(16,'application','access'),(16,'application','view'),(17,'application','access'),(17,'application','edit'),(17,'application','view');
/*!40000 ALTER TABLE `dotp_gacl_aco_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aco_sections`
--

DROP TABLE IF EXISTS `dotp_gacl_aco_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aco_sections` (
  `id` int NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_aco_sections` (`value`),
  KEY `gacl_hidden_aco_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aco_sections`
--

LOCK TABLES `dotp_gacl_aco_sections` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aco_sections` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aco_sections` VALUES (10,'system',1,'System',0),(11,'application',2,'Application',0);
/*!40000 ALTER TABLE `dotp_gacl_aco_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aco_sections_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_aco_sections_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aco_sections_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aco_sections_seq`
--

LOCK TABLES `dotp_gacl_aco_sections_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aco_sections_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aco_sections_seq` VALUES (11);
/*!40000 ALTER TABLE `dotp_gacl_aco_sections_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aco_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_aco_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aco_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aco_seq`
--

LOCK TABLES `dotp_gacl_aco_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aco_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aco_seq` VALUES (15);
/*!40000 ALTER TABLE `dotp_gacl_aco_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro`
--

DROP TABLE IF EXISTS `dotp_gacl_aro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro` (
  `id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_aro` (`section_value`,`value`),
  KEY `gacl_hidden_aro` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro`
--

LOCK TABLES `dotp_gacl_aro` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro` VALUES (10,'user','1',1,'admin',0),(11,'user','2',1,'Membro da equipe A',0),(12,'user','3',1,'Membro da equipe B',0),(13,'user','4',1,'B B_Sobrenome',0),(14,'user','5',1,'A A_Sobrenome',0),(15,'user','6',1,'C C_Sobrenome',0),(16,'user','7',1,'Membro da Equipe  C',0),(17,'user','8',1,'Gary Caracol',0),(18,'user','9',1,'Sr. Siriguejo',0),(19,'user','10',1,'Ciclano beltrano',0),(20,'user','11',1,'admin_en',0),(21,'user','12',1,'group_1',0),(22,'user','13',1,'Sponge Bob',0),(23,'user','14',1,'Patrick Star',0),(24,'user','15',1,'Goku SS',0),(25,'user','16',1,'Vedita SS',0),(28,'user','17',1,'Aluno 1 BSI18',0),(29,'user','18',1,'Aluno 2 BSI18',0),(31,'user','20',1,'AndrÃ© Fabiano de Moraes',0),(32,'user','21',1,'Bruno Ribas',0);
/*!40000 ALTER TABLE `dotp_gacl_aro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_groups`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_groups` (
  `id` int NOT NULL DEFAULT '0',
  `parent_id` int NOT NULL DEFAULT '0',
  `lft` int NOT NULL DEFAULT '0',
  `rgt` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`value`),
  KEY `gacl_parent_id_aro_groups` (`parent_id`),
  KEY `gacl_value_aro_groups` (`value`),
  KEY `gacl_lft_rgt_aro_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_groups`
--

LOCK TABLES `dotp_gacl_aro_groups` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_groups` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_groups` VALUES (10,0,1,10,'Roles','role'),(11,10,2,3,'Administrator','admin'),(12,10,4,5,'Anonymous','anon'),(13,10,6,7,'Guest','guest'),(14,10,8,9,'Project worker','normal');
/*!40000 ALTER TABLE `dotp_gacl_aro_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_groups_id_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_groups_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_groups_id_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_groups_id_seq`
--

LOCK TABLES `dotp_gacl_aro_groups_id_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_groups_id_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_groups_id_seq` VALUES (14);
/*!40000 ALTER TABLE `dotp_gacl_aro_groups_id_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_groups_map`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_groups_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_groups_map` (
  `acl_id` int NOT NULL DEFAULT '0',
  `group_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_groups_map`
--

LOCK TABLES `dotp_gacl_aro_groups_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_groups_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_groups_map` VALUES (10,10),(11,11),(12,11),(13,13),(14,12),(15,14),(16,13),(16,14);
/*!40000 ALTER TABLE `dotp_gacl_aro_groups_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_map`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_map` (
  `acl_id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_map`
--

LOCK TABLES `dotp_gacl_aro_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_map` VALUES (17,'user','12');
/*!40000 ALTER TABLE `dotp_gacl_aro_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_sections`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_sections` (
  `id` int NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_aro_sections` (`value`),
  KEY `gacl_hidden_aro_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_sections`
--

LOCK TABLES `dotp_gacl_aro_sections` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_sections` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_sections` VALUES (10,'user',1,'Users',0);
/*!40000 ALTER TABLE `dotp_gacl_aro_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_sections_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_sections_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_sections_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_sections_seq`
--

LOCK TABLES `dotp_gacl_aro_sections_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_sections_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_sections_seq` VALUES (10);
/*!40000 ALTER TABLE `dotp_gacl_aro_sections_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_aro_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_aro_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_aro_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_aro_seq`
--

LOCK TABLES `dotp_gacl_aro_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_aro_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_aro_seq` VALUES (32);
/*!40000 ALTER TABLE `dotp_gacl_aro_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo`
--

DROP TABLE IF EXISTS `dotp_gacl_axo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo` (
  `id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_section_value_value_axo` (`section_value`,`value`),
  KEY `gacl_hidden_axo` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo`
--

LOCK TABLES `dotp_gacl_axo` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo` VALUES (10,'sys','acl',1,'ACL Administration',0),(11,'app','admin',1,'User Administration',0),(12,'app','calendar',2,'Calendar',0),(13,'app','events',2,'Events',0),(14,'app','companies',3,'Companies',0),(15,'app','contacts',4,'Contacts',0),(16,'app','departments',5,'Departments',0),(17,'app','files',6,'Files',0),(18,'app','file_folders',6,'File Folders',0),(19,'app','forums',7,'Forums',0),(20,'app','help',8,'Help',0),(21,'app','projects',9,'Projects',0),(22,'app','system',10,'System Administration',0),(23,'app','tasks',11,'Tasks',0),(24,'app','task_log',11,'Task Logs',0),(25,'app','ticketsmith',12,'Tickets',0),(26,'app','public',13,'Public',0),(27,'app','roles',14,'Roles Administration',0),(28,'app','users',15,'User Table',0),(29,'app','closure',1,'Closure',0),(30,'app','communication',1,'Communication',0),(31,'app','initiating',1,'Initiating',0),(32,'app','stakeholder',1,'Stakeholder',0),(35,'app','costs',1,'Costs',0),(36,'app','monitoringandcontrol',1,'Monitoring and Controlling',0),(37,'app','dotproject_plus',1,'dotProject+',0),(40,'app','human_resources',1,'Human Resources',0),(41,'app','risks',1,'Risks',0),(47,'app','timeplanning',1,'Time Planning',0),(48,'users','12',0,'Group 1',0),(49,'app','projectdesigner',1,'ProjectDesigner',0),(50,'app','scopeplanning',1,'Scope Planning',0),(51,'app','resources',1,'Resources',0),(52,'app','history',1,'History',0),(53,'app','links',1,'Links',0),(54,'app','smartsearch',1,'SmartSearch',0);
/*!40000 ALTER TABLE `dotp_gacl_axo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_groups`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_groups` (
  `id` int NOT NULL DEFAULT '0',
  `parent_id` int NOT NULL DEFAULT '0',
  `lft` int NOT NULL DEFAULT '0',
  `rgt` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`value`),
  KEY `gacl_parent_id_axo_groups` (`parent_id`),
  KEY `gacl_value_axo_groups` (`value`),
  KEY `gacl_lft_rgt_axo_groups` (`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_groups`
--

LOCK TABLES `dotp_gacl_axo_groups` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_groups` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_groups` VALUES (10,0,1,8,'Modules','mod'),(11,10,2,3,'All Modules','all'),(12,10,4,5,'Admin Modules','admin'),(13,10,6,7,'Non-Admin Modules','non_admin');
/*!40000 ALTER TABLE `dotp_gacl_axo_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_groups_id_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_groups_id_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_groups_id_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_groups_id_seq`
--

LOCK TABLES `dotp_gacl_axo_groups_id_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_groups_id_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_groups_id_seq` VALUES (13);
/*!40000 ALTER TABLE `dotp_gacl_axo_groups_id_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_groups_map`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_groups_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_groups_map` (
  `acl_id` int NOT NULL DEFAULT '0',
  `group_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`acl_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_groups_map`
--

LOCK TABLES `dotp_gacl_axo_groups_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_groups_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_groups_map` VALUES (11,11),(13,13),(14,13),(15,13);
/*!40000 ALTER TABLE `dotp_gacl_axo_groups_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_map`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_map` (
  `acl_id` int NOT NULL DEFAULT '0',
  `section_value` varchar(80) NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`acl_id`,`section_value`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_map`
--

LOCK TABLES `dotp_gacl_axo_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_map` VALUES (12,'sys','acl'),(16,'app','users'),(17,'users','12');
/*!40000 ALTER TABLE `dotp_gacl_axo_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_sections`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_sections` (
  `id` int NOT NULL DEFAULT '0',
  `value` varchar(80) NOT NULL DEFAULT '',
  `order_value` int NOT NULL DEFAULT '0',
  `name` varchar(230) NOT NULL DEFAULT '',
  `hidden` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gacl_value_axo_sections` (`value`),
  KEY `gacl_hidden_axo_sections` (`hidden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_sections`
--

LOCK TABLES `dotp_gacl_axo_sections` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_sections` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_sections` VALUES (10,'sys',1,'System',0),(11,'app',2,'Application',0),(12,'post_mortem_analysis',0,'Post_mortem_analysis Record',0),(13,'communication',0,'Communication Record',0),(14,'costs',0,'Costs Record',0),(15,'users',0,'Users Record',0),(16,'resources',0,'Resources Record',0),(17,'links',0,'Links Record',0);
/*!40000 ALTER TABLE `dotp_gacl_axo_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_sections_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_sections_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_sections_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_sections_seq`
--

LOCK TABLES `dotp_gacl_axo_sections_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_sections_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_sections_seq` VALUES (17);
/*!40000 ALTER TABLE `dotp_gacl_axo_sections_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_axo_seq`
--

DROP TABLE IF EXISTS `dotp_gacl_axo_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_axo_seq` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_axo_seq`
--

LOCK TABLES `dotp_gacl_axo_seq` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_axo_seq` DISABLE KEYS */;
INSERT INTO `dotp_gacl_axo_seq` VALUES (54);
/*!40000 ALTER TABLE `dotp_gacl_axo_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_groups_aro_map`
--

DROP TABLE IF EXISTS `dotp_gacl_groups_aro_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_groups_aro_map` (
  `group_id` int NOT NULL DEFAULT '0',
  `aro_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`aro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_groups_aro_map`
--

LOCK TABLES `dotp_gacl_groups_aro_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_groups_aro_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_groups_aro_map` VALUES (11,10),(11,20),(14,21);
/*!40000 ALTER TABLE `dotp_gacl_groups_aro_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_groups_axo_map`
--

DROP TABLE IF EXISTS `dotp_gacl_groups_axo_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_groups_axo_map` (
  `group_id` int NOT NULL DEFAULT '0',
  `axo_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_id`,`axo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_groups_axo_map`
--

LOCK TABLES `dotp_gacl_groups_axo_map` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_groups_axo_map` DISABLE KEYS */;
INSERT INTO `dotp_gacl_groups_axo_map` VALUES (11,11),(11,12),(11,13),(11,14),(11,15),(11,16),(11,17),(11,18),(11,19),(11,20),(11,21),(11,22),(11,23),(11,24),(11,25),(11,26),(11,27),(11,28),(11,29),(11,30),(11,35),(11,36),(11,37),(11,40),(11,41),(11,47),(11,49),(11,50),(11,51),(11,52),(11,53),(11,54),(12,11),(12,22),(12,27),(12,28),(13,12),(13,13),(13,14),(13,15),(13,16),(13,17),(13,18),(13,19),(13,20),(13,21),(13,23),(13,24),(13,25),(13,26),(13,29),(13,30),(13,35),(13,36),(13,37),(13,40),(13,41),(13,47),(13,49),(13,50),(13,51),(13,52),(13,53),(13,54);
/*!40000 ALTER TABLE `dotp_gacl_groups_axo_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_gacl_phpgacl`
--

DROP TABLE IF EXISTS `dotp_gacl_phpgacl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_gacl_phpgacl` (
  `name` varchar(230) NOT NULL DEFAULT '',
  `value` varchar(230) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_gacl_phpgacl`
--

LOCK TABLES `dotp_gacl_phpgacl` WRITE;
/*!40000 ALTER TABLE `dotp_gacl_phpgacl` DISABLE KEYS */;
INSERT INTO `dotp_gacl_phpgacl` VALUES ('schema_version','2.1'),('version','3.3.2');
/*!40000 ALTER TABLE `dotp_gacl_phpgacl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_history`
--

DROP TABLE IF EXISTS `dotp_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_history` (
  `history_id` int unsigned NOT NULL AUTO_INCREMENT,
  `history_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `history_user` int NOT NULL DEFAULT '0',
  `history_action` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'modify',
  `history_item` int NOT NULL,
  `history_table` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `history_project` int NOT NULL DEFAULT '0',
  `history_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `history_changes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `history_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`history_id`),
  KEY `index_history_module` (`history_table`,`history_item`),
  KEY `index_history_item` (`history_item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_history`
--

LOCK TABLES `dotp_history` WRITE;
/*!40000 ALTER TABLE `dotp_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_human_resource`
--

DROP TABLE IF EXISTS `dotp_human_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_human_resource` (
  `human_resource_id` int NOT NULL AUTO_INCREMENT,
  `human_resource_user_id` int NOT NULL,
  `human_resource_lattes_url` text,
  `human_resource_mon` int DEFAULT NULL,
  `human_resource_tue` int DEFAULT NULL,
  `human_resource_wed` int DEFAULT NULL,
  `human_resource_thu` int DEFAULT NULL,
  `human_resource_fri` int DEFAULT NULL,
  `human_resource_sat` int DEFAULT NULL,
  `human_resource_sun` int DEFAULT NULL,
  PRIMARY KEY (`human_resource_id`),
  KEY `human_resource_user_id` (`human_resource_user_id`),
  CONSTRAINT `dotp_human_resource_ibfk_1` FOREIGN KEY (`human_resource_user_id`) REFERENCES `dotp_users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_human_resource`
--

LOCK TABLES `dotp_human_resource` WRITE;
/*!40000 ALTER TABLE `dotp_human_resource` DISABLE KEYS */;
INSERT INTO `dotp_human_resource` VALUES (1,2,'http://lattes.cnpq.br/lula_molusco',0,4,4,4,4,4,0),(2,3,'http://lattes.cnpq.br/bob_esponja',0,8,8,8,8,8,0),(3,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,7,'http://lattes.cnpq.br/patrick',0,6,6,6,6,6,0),(7,8,'http://lattes.cnpq.br/gary',0,4,4,4,4,4,0),(8,9,'http://lattes.cnpq.br/siriguejo',0,5,8,5,8,5,0),(9,13,'spongebob.com',0,8,8,8,8,8,0),(10,14,'',0,8,8,8,8,8,0),(11,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,17,'linkdin',0,8,8,8,8,8,0);
/*!40000 ALTER TABLE `dotp_human_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_human_resource_allocation`
--

DROP TABLE IF EXISTS `dotp_human_resource_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_human_resource_allocation` (
  `human_resource_allocation_id` int NOT NULL AUTO_INCREMENT,
  `project_tasks_estimated_roles_id` int NOT NULL,
  `human_resource_id` int NOT NULL,
  PRIMARY KEY (`human_resource_allocation_id`),
  KEY `human_resource_id` (`human_resource_id`),
  KEY `project_tasks_estimated_roles_id` (`project_tasks_estimated_roles_id`),
  CONSTRAINT `dotp_human_resource_allocation_ibfk_1` FOREIGN KEY (`human_resource_id`) REFERENCES `dotp_human_resource` (`human_resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dotp_human_resource_allocation_ibfk_2` FOREIGN KEY (`project_tasks_estimated_roles_id`) REFERENCES `dotp_project_tasks_estimated_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_human_resource_allocation`
--

LOCK TABLES `dotp_human_resource_allocation` WRITE;
/*!40000 ALTER TABLE `dotp_human_resource_allocation` DISABLE KEYS */;
INSERT INTO `dotp_human_resource_allocation` VALUES (133,223,1),(134,224,2),(135,225,6),(142,233,2),(156,248,1),(157,249,2),(158,250,6),(159,251,8),(160,252,7),(168,260,1),(169,261,2),(183,277,9),(184,278,10),(191,285,10),(192,286,9),(196,290,1),(200,294,1),(201,295,1),(202,296,1);
/*!40000 ALTER TABLE `dotp_human_resource_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_human_resource_performance`
--

DROP TABLE IF EXISTS `dotp_human_resource_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_human_resource_performance` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int unsigned NOT NULL,
  `human_resource_id` int unsigned NOT NULL,
  `performance_score` tinyint NOT NULL COMMENT '1: Low, 2: Medium, 3: High',
  `potential_score` tinyint NOT NULL COMMENT '1: Low, 2: Medium, 3: High',
  `facilitator_notes` text COLLATE utf8mb4_unicode_ci,
  `evaluation_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_human_resource_performance`
--

LOCK TABLES `dotp_human_resource_performance` WRITE;
/*!40000 ALTER TABLE `dotp_human_resource_performance` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_human_resource_performance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_human_resource_roles`
--

DROP TABLE IF EXISTS `dotp_human_resource_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_human_resource_roles` (
  `human_resource_roles_id` int NOT NULL AUTO_INCREMENT,
  `human_resources_role_id` int NOT NULL,
  `human_resource_id` int NOT NULL,
  PRIMARY KEY (`human_resource_roles_id`),
  KEY `human_resources_role_id` (`human_resources_role_id`),
  KEY `human_resource_id` (`human_resource_id`),
  CONSTRAINT `dotp_human_resource_roles_ibfk_1` FOREIGN KEY (`human_resources_role_id`) REFERENCES `dotp_human_resources_role` (`human_resources_role_id`) ON DELETE CASCADE,
  CONSTRAINT `dotp_human_resource_roles_ibfk_2` FOREIGN KEY (`human_resource_id`) REFERENCES `dotp_human_resource` (`human_resource_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_human_resource_roles`
--

LOCK TABLES `dotp_human_resource_roles` WRITE;
/*!40000 ALTER TABLE `dotp_human_resource_roles` DISABLE KEYS */;
INSERT INTO `dotp_human_resource_roles` VALUES (3,3,3),(4,4,4),(5,3,5),(6,4,5),(26,2,6),(27,2,2),(28,6,2),(29,1,1),(32,2,8),(33,7,8),(34,7,7),(35,8,9),(40,9,10),(41,10,10),(42,11,11);
/*!40000 ALTER TABLE `dotp_human_resource_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_human_resource_skills`
--

DROP TABLE IF EXISTS `dotp_human_resource_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_human_resource_skills` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `human_resource_id` int NOT NULL,
  `skill_id` bigint unsigned NOT NULL,
  `proficiency_level` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `dotp_human_resource_skills_human_resource_id_foreign` (`human_resource_id`),
  KEY `dotp_human_resource_skills_skill_id_foreign` (`skill_id`),
  CONSTRAINT `dotp_human_resource_skills_human_resource_id_foreign` FOREIGN KEY (`human_resource_id`) REFERENCES `dotp_human_resource` (`human_resource_id`) ON DELETE CASCADE,
  CONSTRAINT `dotp_human_resource_skills_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `dotp_skills` (`skill_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_human_resource_skills`
--

LOCK TABLES `dotp_human_resource_skills` WRITE;
/*!40000 ALTER TABLE `dotp_human_resource_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_human_resource_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_human_resources_role`
--

DROP TABLE IF EXISTS `dotp_human_resources_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_human_resources_role` (
  `human_resources_role_id` int NOT NULL AUTO_INCREMENT,
  `human_resources_role_name` text NOT NULL,
  `human_resources_role_authority` text,
  `human_resources_role_responsability` text,
  `human_resources_role_competence` text,
  `human_resources_role_company_id` int NOT NULL,
  PRIMARY KEY (`human_resources_role_id`),
  KEY `human_resources_role_company_id` (`human_resources_role_company_id`),
  CONSTRAINT `dotp_human_resources_role_ibfk_1` FOREIGN KEY (`human_resources_role_company_id`) REFERENCES `dotp_companies` (`company_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_human_resources_role`
--

LOCK TABLES `dotp_human_resources_role` WRITE;
/*!40000 ALTER TABLE `dotp_human_resources_role` DISABLE KEYS */;
INSERT INTO `dotp_human_resources_role` VALUES (1,'Gerente de projetos','Pode alocar os membros da equipe nas atividades que desejar, e tambêm pode solicitar aquisição dos materiais e serviços essenciais para o trabalho.','Elaborar o termo de abertura do projeto.\r\nElaborar o plano do projeto.\r\nExecutar o plano do projeto.\r\nMonitorar e controlar o projeto.\r\nEncerrar formalmente o projeto.','Deve possuir treinamento na área de gerência de projetos e preferencialmente ser certificado PMP.',1),(2,'Programador','Requisitar as ferramentas de software e hardware necessárias para execução de seu trabalho. Solicitar treinamento quando alocado para uma atividade a qual não possui competência.','Executar as atividades do projeto as quais foi alocado. Realizar testes de unidade e integração nos componentes de software os quais está trabalhando.','Formação completa em cursos superior de Ciência da Computação ou Sistemas de Informação. Possuir certificações nas linguagens de programação as quais foi alocado.',1),(3,'Programador TCE','','ddddddd','',2),(4,'Analista TCE','','sss','',2),(5,'Analista de teste','Exigir a execução dos testes antes de qualquer entrega.','Escrever os casos de teste. Executar os testes de sistema, e acompanhar o cliente na execução dos testes de aceite.','Formação em curso superior em Ciência da Computação ou Sistemas da Informação.',1),(6,'Analista de sistemas','Agendar reuniões com o cliente sempre que necessário. Definir tecnologias apropriadas para construção do produto, respeitando as restrições impostas pelo cliente.','Realizar reuniões junto aos clientes para reconhecimento do negócio.\r\nModelar o negócio do cliente e identificar requisitos de software que suportem uma solução apropriada.\r\nModelar a solução e apresenta-la à  equipe e ao cliente. Validar requisitos e modelos de sistema junto ao cliente.','Formação em Ciência da Computação ou Sistemas da Informação.\r\nEntendimento de modelagem de sistemas. Certificação em UML é desejável.',1),(7,'Gerente da qualidade','Denunciar não conformidades do processo ou do produto ao gerente de projetos.','Executar auditorias internas de acordo com as especificações das normas adotadas pela organização. \r\nBuscar discrepâncias entre o processo executado e o processo definido.\r\nRealiza inspeções nos componentes de software desenvolvidos pela organização, e confere seu suporte/desempenho em relação à especificação.','Graduação de nível superior em alguma área da tecnologia da informação. Conhecimento sobre os modelos de maturidade e capacidade de software.',1),(8,'Project Manager','Allocate team members in project activities.\r\nRequest acquisitions of items necessary to the project.\r\nDismiss team members.','Develop the project plan.\r\nGet the project plan approved by project sponsor.\r\nSelect the project team.\r\nControl the project work.','Interpersonal abilities.\r\nGeneral knowledge in the project application area.\r\nProject Management knowledge.',4),(9,'Programmer','Ask for questions when something related to his duties are not properly documentted.','Perform the coding of request use cases.\r\nAnswer the about effort estimations when requested by the project manager.\r\nCarry out the unit testes of his developments.','Proficiency on JAVA programming language.\r\nKnowledghe on Software Engenerring including:\r\n- Project life cycle.\r\n- UML documentation.\r\n- Software testesing',4),(10,'System Analyst','','Document the project requirements.\r\nDesign the software solution.','',4),(11,'X',NULL,NULL,NULL,3),(12,'Gerente de Projetos','Gerencial','Gerenciar equipes e projetos','Administrador\r\nAnalista Financeiro\r\nTecnÃ³logo em Sistemas de InformaÃ§Ã£o',6),(13,'Programador','Executora','Desenvolvimento de Softwares','ProgramaÃ§Ã£o',6);
/*!40000 ALTER TABLE `dotp_human_resources_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_initiating`
--

DROP TABLE IF EXISTS `dotp_initiating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_initiating` (
  `initiating_id` int NOT NULL AUTO_INCREMENT,
  `initiating_title` varchar(255) NOT NULL,
  `initiating_manager` int NOT NULL,
  `initiating_create_by` int NOT NULL,
  `initiating_date_create` datetime NOT NULL,
  `initiating_justification` varchar(2000) DEFAULT NULL,
  `initiating_objective` varchar(2000) DEFAULT NULL,
  `initiating_expected_result` varchar(2000) DEFAULT NULL,
  `initiating_premise` varchar(2000) DEFAULT NULL,
  `initiating_restrictions` varchar(2000) DEFAULT NULL,
  `initiating_budget` float DEFAULT '0',
  `initiating_start_date` date DEFAULT NULL,
  `initiating_end_date` date DEFAULT NULL,
  `initiating_milestone` varchar(2000) DEFAULT NULL,
  `initiating_success` varchar(2000) DEFAULT NULL,
  `initiating_approved` int DEFAULT '0',
  `initiating_authorized` int DEFAULT '0',
  `initiating_completed` int NOT NULL DEFAULT '0',
  `initiating_approved_comments` varchar(2000) DEFAULT NULL,
  `initiating_authorized_comments` varchar(2000) DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  PRIMARY KEY (`initiating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_initiating`
--

LOCK TABLES `dotp_initiating` WRITE;
/*!40000 ALTER TABLE `dotp_initiating` DISABLE KEYS */;
INSERT INTO `dotp_initiating` VALUES (1,'Sistema de pizzaria do Tio Chico',2,1,'2015-07-21 21:34:23','A pizzaria do Tio Chico localizada no centro da Ilha do SilÃƒÂ­Ã‚Â­cio, ÃƒÂ© famosa por suas pizzas. Na parte leste da ilha a demanda de pedidos por pizzas vieram aumentando nos ÃƒÂºltimos trÃƒÂªs anos. A pizzaria Tio Chico deseja ter capacidade para explorar esta oportunidade, para isto, quer oferecer um novo serviÃƒÂ§o de entrega de pizzas que irÃƒÂ¡ focar na ÃƒÂ¡rea leste da ilha, jÃƒÂ¡ que a pizzaria Tio Chico ÃƒÂ© a primeira a atuar nesta regiÃƒÂ£o. Dessa maneira a pizzaria irÃƒÂ¡ atender uma ÃƒÂ¡rea de 70.000 mÃ‚Â² e mais de 25.000 residentes, e estima um aumento de 30% nas vendas para os prÃƒÂ³ximos dois anos.','Desenvolver um sistema web para a venda online de pizzas na pizzaria do Tio Chico. O sistema incluirÃƒÂ¡ tambÃƒÂ©m um mÃƒÂ³dulo para ser acessado pelos smartphones dos entregadores, por qual eles possam verificar detalhes da entrega (endereÃƒÂ§o, valor total, etc.).','-MÃƒÂ³dulo web para a encomenda de pizzas.\r\n-MÃƒÂ³dulo web para controle de pizzas encomendadas.\r\n-MÃƒÂ³dulo web para cadastro de clientes.\r\n-MÃƒÂ³dulo mobile para controle de pizzas encomendadas.\r\n-InstalaÃƒÂ§ÃƒÂ£o do sistema web no servidor escolhido pela empresa.\r\n-Treinamento dos funcionÃƒÆ’Ã‚Â¡rios da pizzaria.','A pizzaria fornecerÃƒÂ¡ todos os equipamentos (hardware, celulares) e acesso ÃƒÂ  internet.','Os resultados devem ser entregues antes do dia 1 de setembro de 2013. O sistema precisa ser integrado no site existente da pizzaria e seguir os padrÃƒÂµes de design da pizzaria nos mÃƒÂ³dulos web e mobile.',34400,'2013-02-01','2013-08-01','- MÃƒÂ³dulo do sistema web: 20/06/2013 \r\n- MÃƒÂ³dulo para celular para controle de pizzas encomendadas: 01/07/2013\r\n- Treinamento dos funcionÃƒÂ¡rios da pizzaria: 18/07/2013\r\n- InstalaÃƒÂ§ÃƒÂ£o do sistema web no servidor escolhido pela empresa: 29/07/2013','Sistema instalado no ambiente produtivo. Custo total nÃƒÂ£o deve ultrapassar o orÃƒÂ§amento. Atendentes e entregadores treinados para operar o sistema.',1,1,1,'','',2),(2,'Melhoria da usabilidade do dotProject',6,1,'2016-02-03 20:43:58','teste','','TCC','','',0,'2015-01-05','2016-02-03','','',1,1,1,'','',1),(3,'Projeto - módulo de feedback',2,1,'2016-02-08 11:42:37','teste','','Documento do TCC.','','',1000,'2016-02-08','2016-02-08','','',0,0,1,'','',4),(4,'teste feedback',7,1,'2016-02-19 20:16:02','','','','','',0,'2016-02-19','2017-03-30','','',0,0,1,'','',5),(5,'teste feedback',0,11,'2016-03-09 06:44:05','teste','','','','',0,'2016-03-09','2016-03-09','','',0,0,0,'','',7),(6,'Pizza System - Uncle Chico',13,12,'2016-03-14 02:42:43','The Uncle Chico pizza is located in Downtown of Silicio\'s Island. In the east side of this islad there is an ascendent demand for pizzas, and the Uncle Chico wants to meet this demand.','Develop a computational system, available for web and mobile access, which customers my request some pizza, and the deliveres may search the requests content, such as the customer address and requested items.','- Web module.\r\n- Mobile module.\r\n- Tranning of Uncle Chico employees.','Uncle Chico will provide all necessary hardware, such as mobile phones and computers.','The system may be delivered in the begin of the first semester.',30000,'2016-03-14','2016-09-01','- Delivery of web module.\r\n- Delivery of mobile module.','Be completed developed until de deadline, and not overrun the budget.',1,1,1,'','',8),(7,'Projeto do Bruno',21,1,'2016-04-01 00:44:30','Tecnologia e educação','Finalização do TCC','N/A','N/A','N/A',5000000,'2016-04-16','2016-04-16','N/A','N/A',0,0,0,'N/A','N/A',9),(8,'Projeto de teste',21,1,'2026-06-04 19:57:02',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,0,0,NULL,NULL,9);
/*!40000 ALTER TABLE `dotp_initiating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_initiating_stakeholder`
--

DROP TABLE IF EXISTS `dotp_initiating_stakeholder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_initiating_stakeholder` (
  `initiating_stakeholder_id` int NOT NULL AUTO_INCREMENT,
  `initiating_id` int NOT NULL,
  `contact_id` int NOT NULL,
  `stakeholder_responsibility` varchar(100) DEFAULT NULL,
  `stakeholder_interest` varchar(100) DEFAULT NULL,
  `stakeholder_power` varchar(100) DEFAULT NULL,
  `stakeholder_strategy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`initiating_stakeholder_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_initiating_stakeholder`
--

LOCK TABLES `dotp_initiating_stakeholder` WRITE;
/*!40000 ALTER TABLE `dotp_initiating_stakeholder` DISABLE KEYS */;
INSERT INTO `dotp_initiating_stakeholder` VALUES (1,1,13,'Patrocinador','1','1','Gerencie perto'),(2,1,3,'Programador','1','2','Mantenha informado'),(3,1,2,'Gerente de projetos','1','1','Gerencie perto'),(4,1,10,'Analista de sistemas','2','1','Mantenha satisfeito'),(5,1,14,'Atendente da pizzaria.','1','2','Mantenha informado'),(6,1,15,'Atendente da pizzaria.','1','1','Gerencie perto'),(7,1,16,'Entregador da pizzaria.','1','2','Mantenha informado'),(8,2,7,NULL,'0','0',NULL),(9,6,21,'Manage the project','1','1','Keep constantly informed about progress.'),(10,6,22,NULL,'0','0',NULL),(11,6,23,NULL,'0','0',NULL),(12,7,26,'-','Médio','Médio','Monitore (Mínimo esforço)'),(13,7,30,'Gerente de Projetos','Alto','Alto',NULL);
/*!40000 ALTER TABLE `dotp_initiating_stakeholder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_links`
--

DROP TABLE IF EXISTS `dotp_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_links` (
  `link_id` int NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_project` int NOT NULL DEFAULT '0',
  `link_task` int NOT NULL DEFAULT '0',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_parent` int DEFAULT '0',
  `link_description` text,
  `link_owner` int DEFAULT '0',
  `link_date` datetime DEFAULT NULL,
  `link_icon` varchar(20) DEFAULT 'obj/',
  `link_category` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`link_id`),
  KEY `idx_link_task` (`link_task`),
  KEY `idx_link_project` (`link_project`),
  KEY `idx_link_parent` (`link_parent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_links`
--

LOCK TABLES `dotp_links` WRITE;
/*!40000 ALTER TABLE `dotp_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_modules`
--

DROP TABLE IF EXISTS `dotp_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_modules` (
  `mod_id` int NOT NULL AUTO_INCREMENT,
  `mod_name` varchar(64) NOT NULL DEFAULT '',
  `mod_directory` varchar(64) NOT NULL DEFAULT '',
  `mod_version` varchar(10) NOT NULL DEFAULT '',
  `mod_setup_class` varchar(64) NOT NULL DEFAULT '',
  `mod_type` varchar(64) NOT NULL DEFAULT '',
  `mod_active` int unsigned NOT NULL DEFAULT '0',
  `mod_ui_name` varchar(20) NOT NULL DEFAULT '',
  `mod_ui_icon` varchar(64) NOT NULL DEFAULT '',
  `mod_ui_order` tinyint NOT NULL DEFAULT '0',
  `mod_ui_active` int unsigned NOT NULL DEFAULT '0',
  `mod_description` varchar(255) NOT NULL DEFAULT '',
  `permissions_item_table` char(100) DEFAULT NULL,
  `permissions_item_field` char(100) DEFAULT NULL,
  `permissions_item_label` char(100) DEFAULT NULL,
  PRIMARY KEY (`mod_id`,`mod_directory`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_modules`
--

LOCK TABLES `dotp_modules` WRITE;
/*!40000 ALTER TABLE `dotp_modules` DISABLE KEYS */;
INSERT INTO `dotp_modules` VALUES (1,'Companies','companies','1.0.0','','core',1,'Companies','handshake.png',1,1,'','companies','company_id','company_name'),(2,'Projects','projects','1.0.0','','core',1,'Projects','applet3-48.png',2,1,'','projects','project_id','project_name'),(3,'Tasks','tasks','1.0.0','','core',1,'Tasks','applet-48.png',3,1,'','tasks','task_id','task_name'),(4,'Calendar','calendar','1.0.0','','core',1,'Calendar','myevo-appointments.png',4,1,'','events','event_id','event_title'),(5,'Files','files','1.0.0','','core',1,'Files','folder5.png',5,1,'','files','file_id','file_name'),(6,'Contacts','contacts','1.0.0','','core',1,'Contacts','monkeychat-48.png',6,1,'','contacts','contact_id','contact_title'),(7,'Forums','forums','1.0.0','','core',1,'Forums','support.png',7,1,'','forums','forum_id','forum_name'),(8,'Tickets','ticketsmith','1.0.0','','core',1,'Tickets','ticketsmith.gif',8,1,'','','',''),(9,'User Administration','admin','1.0.0','','core',1,'User Admin','helix-setup-users.png',9,1,'','users','user_id','user_username'),(10,'System Administration','system','1.0.0','','core',1,'System Admin','48_my_computer.png',10,1,'','','',''),(11,'Departments','departments','1.0.0','','core',1,'Departments','users.gif',11,1,'','departments','dept_id','dept_name'),(12,'Help','help','1.0.0','','core',1,'Help','dp.gif',12,1,'','','',''),(13,'Public','public','1.0.0','','core',1,'Public','users.gif',13,0,'','','',''),(14,'Closure','closure','1.0.1','SClosure','user',1,'Closure','helpdesk.png',13,1,'','post_mortem_analysis','pma_id','project_name'),(15,'Communication','communication','1.0','CSetupCommunication','user',1,'Communication','applet3-48.png',14,1,'Communications Planning','communication','communication_id','communication_name'),(16,'Initiating','initiating','1.0','CSetupInitiating','user',1,'Initiating','applet3-48.png',15,1,'Initiating process group implementation',NULL,NULL,NULL),(17,'Stakeholder','stakeholder','1.0','CSetupStakeholder','user',1,'Stakeholder','applet3-48.png',16,1,'Initiating process group implementation',NULL,NULL,NULL),(20,'Costs','costs','1.0.1','SSetupCosts','user',1,'Costs','costs.png',19,1,'Costs Plan','costs','cost_id','cost_name'),(21,'Monitoring and Controlling','monitoringandcontrol','1.0','CSetup_MonitoringAndControl','user',1,'Monitoring and Contr','graph-up.png',20,1,'Monitoring and Controlling',NULL,NULL,NULL),(22,'dotProject+','dotproject_plus','1.0','CSetup_dotProjectPlus','user',1,'dotProject+','applet3-48.png',21,1,'dotProject+',NULL,NULL,NULL),(25,'Human Resources','human_resources','1.0','SHumanResources','user',1,'Human Resources','applet3-48.png',23,1,'',NULL,NULL,NULL),(26,'Risks','risks','1.0','CSetupRisks','user',1,'Risks','risks.png',24,1,'Risks Plan',NULL,'risk_id','risk_name'),(32,'Time Planning','timeplanning','2.0','CSetup_TimePlanning','user',1,'Time Planning','applet3-48.png',25,1,'Time planning',NULL,NULL,NULL),(33,'ProjectDesigner','projectdesigner','1.0','projectDesigner','user',1,'ProjectDesigner','projectdesigner.jpg',26,1,'A module to design projects',NULL,NULL,NULL),(34,'Scope Planning','scopeplanning','1.0','CSetup_ScopePlanning','user',1,'Scope','scope.png',27,1,'Scope Planning module',NULL,NULL,NULL),(35,'Resources','resources','1.0.1','SResource','user',1,'Resources','helpdesk.png',28,1,'','resources','resource_id','resource_name'),(36,'History','history','0.32','CSetupHistory','user',1,'History','',29,1,'A module for tracking changes',NULL,NULL,NULL),(37,'Links','links','1.0','CSetupLinks','user',1,'Links','folder5.png',30,1,'Links related to tasks','links','link_id','link_name'),(38,'SmartSearch','smartsearch','2.0','SSearchNS','user',1,'SmartSearch','kfind.png',31,1,'A module to search keywords and find the needle in the haystack',NULL,NULL,NULL);
/*!40000 ALTER TABLE `dotp_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_baseline`
--

DROP TABLE IF EXISTS `dotp_monitoring_baseline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_baseline` (
  `baseline_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int unsigned NOT NULL DEFAULT '0',
  `baseline_name` varchar(255) DEFAULT NULL,
  `baseline_version` varchar(255) DEFAULT NULL,
  `baseline_observation` text,
  `user_id` int NOT NULL,
  `baseline_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`baseline_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_baseline`
--

LOCK TABLES `dotp_monitoring_baseline` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_baseline` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_baseline` VALUES (1,1,'baseline','1.0','',1,'2016-03-24 10:26:26'),(2,8,'0.8','0.8','',1,'2016-05-08 06:10:04');
/*!40000 ALTER TABLE `dotp_monitoring_baseline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_baseline_task`
--

DROP TABLE IF EXISTS `dotp_monitoring_baseline_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_baseline_task` (
  `baseline_task_id` int NOT NULL AUTO_INCREMENT,
  `baseline_id` int unsigned NOT NULL DEFAULT '0',
  `task_id` int unsigned NOT NULL DEFAULT '0',
  `task_start_date` datetime DEFAULT NULL,
  `task_duration` float unsigned DEFAULT '0',
  `task_duration_type` int NOT NULL DEFAULT '1',
  `task_hours_worked` float unsigned DEFAULT '0',
  `task_end_date` datetime DEFAULT NULL,
  `task_percent_complete` tinyint DEFAULT NULL,
  PRIMARY KEY (`baseline_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_baseline_task`
--

LOCK TABLES `dotp_monitoring_baseline_task` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_baseline_task` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_baseline_task` VALUES (1,1,21,'2014-10-14 00:00:00',1,24,0,'2014-10-14 00:00:00',50),(2,1,22,'2014-10-14 00:00:00',1,24,0,'2014-10-14 00:00:00',0),(3,1,23,'2014-10-14 00:00:00',1,24,0,'2014-10-14 00:00:00',0),(4,1,24,'2014-10-14 00:00:00',1,24,0,'2014-10-14 00:00:00',0),(5,1,25,'2014-10-14 00:00:00',4,24,0,'2014-10-17 00:00:00',0),(6,1,27,'2014-10-15 00:00:00',5,24,0,'2014-10-19 00:00:00',0),(7,1,29,'2014-10-16 00:00:00',1,24,0,'2014-10-16 00:00:00',100),(8,1,30,'2014-10-16 00:00:00',1,24,0,'2014-10-16 00:00:00',0),(9,1,31,'2014-10-20 00:00:00',1,24,0,'2014-10-20 00:00:00',0),(10,1,36,'2015-06-25 00:00:00',5,24,0,'2015-06-29 00:00:00',0),(11,1,37,'2015-06-30 00:00:00',0,1,0,'2015-06-30 00:00:00',0),(12,1,38,'2015-07-01 00:00:00',1,24,0,'2015-07-01 00:00:00',100),(13,1,40,'2015-07-20 00:00:00',1,24,0,'2015-07-20 00:00:00',0),(14,1,41,'2015-07-20 00:00:00',1,24,0,'2015-07-20 00:00:00',0),(15,1,51,'2015-08-01 00:00:00',1,24,0,'2015-08-01 00:00:00',0),(16,2,119,'2016-03-27 00:00:00',11,24,0,'2016-04-07 00:00:00',100),(17,2,120,'2016-04-09 00:00:00',7,24,0,'2016-04-15 00:00:00',100),(18,2,121,'2016-03-14 00:00:00',13,24,0,'2016-03-26 00:00:00',50),(19,2,122,'2016-04-17 00:00:00',11,24,0,'2016-04-27 00:00:00',50),(20,2,126,'2016-03-15 00:00:00',1,24,0,'2016-03-15 00:00:00',0),(21,2,127,'2016-03-30 00:00:00',0,1,0,'2016-03-30 00:00:00',0);
/*!40000 ALTER TABLE `dotp_monitoring_baseline_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_baseline_task_log`
--

DROP TABLE IF EXISTS `dotp_monitoring_baseline_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_baseline_task_log` (
  `baseline_task_id_log` int NOT NULL AUTO_INCREMENT,
  `baseline_task_id` int unsigned NOT NULL DEFAULT '0',
  `task_log_id` int unsigned NOT NULL DEFAULT '0',
  `task_log_creator` int NOT NULL DEFAULT '0',
  `task_log_hours` float NOT NULL DEFAULT '0',
  `task_log_date` datetime DEFAULT NULL,
  PRIMARY KEY (`baseline_task_id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_baseline_task_log`
--

LOCK TABLES `dotp_monitoring_baseline_task_log` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_baseline_task_log` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_baseline_task_log` VALUES (1,16,1,1,5,'2016-03-27 00:15:46'),(2,16,5,1,3,'2016-04-09 00:00:00');
/*!40000 ALTER TABLE `dotp_monitoring_baseline_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_baseline_user_cost`
--

DROP TABLE IF EXISTS `dotp_monitoring_baseline_user_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_baseline_user_cost` (
  `baseline_cost_id` int NOT NULL AUTO_INCREMENT,
  `baseline_id` int unsigned NOT NULL DEFAULT '0',
  `cost_id` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL,
  `cost_value` decimal(10,2) DEFAULT '0.00',
  `cost_per_use` decimal(11,0) DEFAULT NULL,
  `cost_dt_begin` datetime NOT NULL,
  `cost_dt_end` datetime DEFAULT NULL,
  PRIMARY KEY (`baseline_cost_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_baseline_user_cost`
--

LOCK TABLES `dotp_monitoring_baseline_user_cost` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_baseline_user_cost` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_baseline_user_cost` VALUES (1,1,1,4,56.00,NULL,'2013-10-10 00:00:00','2014-10-19 00:00:00'),(2,1,2,3,35.00,NULL,'2013-01-01 00:00:00','2017-07-31 00:00:00'),(3,1,3,2,60.00,NULL,'2013-02-01 00:00:00','2017-07-01 00:00:00'),(4,1,4,7,33.00,NULL,'2010-07-06 00:00:00','2017-07-30 00:00:00'),(5,1,5,8,40.00,NULL,'2013-01-02 00:00:00','2017-07-01 00:00:00'),(6,1,6,9,19.00,NULL,'2013-01-01 00:00:00','2017-07-01 00:00:00'),(7,1,7,13,45.00,NULL,'2016-03-01 00:00:00','2016-12-31 00:00:00'),(8,1,8,14,89.00,NULL,'2016-03-01 00:00:00','2016-12-31 00:00:00'),(9,2,1,4,56.00,NULL,'2013-10-10 00:00:00','2014-10-19 00:00:00'),(10,2,2,3,35.00,NULL,'2013-01-01 00:00:00','2017-07-31 00:00:00'),(11,2,3,2,60.00,NULL,'2013-02-01 00:00:00','2017-07-01 00:00:00'),(12,2,4,7,33.00,NULL,'2010-07-06 00:00:00','2017-07-30 00:00:00'),(13,2,5,8,40.00,NULL,'2013-01-02 00:00:00','2017-07-01 00:00:00'),(14,2,6,9,19.00,NULL,'2013-01-01 00:00:00','2017-07-01 00:00:00'),(15,2,7,13,45.00,NULL,'2016-03-01 00:00:00','2016-12-31 00:00:00'),(16,2,8,14,89.00,NULL,'2016-03-01 00:00:00','2016-12-31 00:00:00');
/*!40000 ALTER TABLE `dotp_monitoring_baseline_user_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_change_request`
--

DROP TABLE IF EXISTS `dotp_monitoring_change_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_change_request` (
  `change_id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT '0',
  `change_impact` int NOT NULL DEFAULT '0',
  `change_status` int DEFAULT NULL,
  `change_description` text NOT NULL,
  `change_cause` text NOT NULL,
  `change_request` text NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `change_date_limit` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `meeting_id` int unsigned DEFAULT NULL,
  `project_id` int NOT NULL,
  PRIMARY KEY (`change_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_change_request`
--

LOCK TABLES `dotp_monitoring_change_request` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_change_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_change_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting` (
  `meeting_id` int unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int unsigned NOT NULL DEFAULT '0',
  `dt_meeting_begin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ds_title` text NOT NULL,
  `ds_subject` text NOT NULL,
  `dt_meeting_end` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `meeting_type_id` int NOT NULL,
  PRIMARY KEY (`meeting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting`
--

LOCK TABLES `dotp_monitoring_meeting` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting_item`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting_item` (
  `meeting_item_id` int NOT NULL AUTO_INCREMENT,
  `meeting_item_description` text,
  `knownledge_area` text,
  `language` text,
  `item_order` int DEFAULT NULL,
  PRIMARY KEY (`meeting_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting_item`
--

LOCK TABLES `dotp_monitoring_meeting_item` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_meeting_item` VALUES (1,'Is the use and communication of data following the plan?','comunication','EN',1),(2,'Is the schedule being carried out according to plan?','time','EN',1),(3,'Is the stakeholder involvement following the plan?','stakeholder','EN',1),(4,'Were there changes in the risks?','risk','EN',1),(5,'There is new risks?','risk','EN',2),(6,'Some contingency action has been carried out?','risk','EN',3),(7,'The contingency reserves are been used as planned?','risk','EN',4),(8,'The planned risks\' responses are effectiveness to solve the risk root cause?','risk','EN',5),(9,'Are the costs being carried out according to plan?','cost','EN',2),(10,'Os dados do projeto estÃ£o seguindo o plano de comunicaÃ§Ã£o?','comunication','pt_br',1),(11,'O cronograma estÃ¡ sendo executado de acordo com o plano?','time','pt_br',1),(12,'O envolvimento dos stakeholders estÃ¡ seguindo o plano?','stakeholder','pt_br',1),(13,'Houve alguma alteraÃ§Ã£o nos riscos?','risk','pt_br',1),(14,'Foram identificados novos riscos?','risk','pt_br',2),(15,'Alguma aÃ§Ã£o de contingÃªncia foi executada?','risk','pt_br',3),(16,'As reservas de contingÃªncia estÃ£o sendo aplicadas de acordo com o planejado?','risk','pt_br',4),(17,'As aÃ§Ãµes de resposta aos riscos planejadas foram eficazes na correÃ§Ã£o da causa raÃ­z do risco?','risk','pt_br',5),(18,'Os custos do projeto estÃ£o ocorrendo de acordo com o plano?','cost','pt_br',2);
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting_item_select`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting_item_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting_item_select` (
  `meeting_item_select_id` int unsigned NOT NULL AUTO_INCREMENT,
  `meeting_item_id` int unsigned NOT NULL DEFAULT '0',
  `meeting_id` int unsigned NOT NULL DEFAULT '0',
  `status` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`meeting_item_select_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting_item_select`
--

LOCK TABLES `dotp_monitoring_meeting_item_select` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item_select` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting_item_senior`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting_item_senior`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting_item_senior` (
  `meeting_item_senior_id` int unsigned NOT NULL AUTO_INCREMENT,
  `meeting_percentual` decimal(10,2) DEFAULT '0.00',
  `meeting_size` int unsigned NOT NULL DEFAULT '0',
  `meeting_idc` decimal(10,2) DEFAULT '0.00',
  `meeting_idp` decimal(10,2) DEFAULT '0.00',
  `meeting_vp` decimal(10,2) DEFAULT '0.00',
  `meeting_va` decimal(10,2) DEFAULT '0.00',
  `meeting_cr` decimal(10,2) DEFAULT '0.00',
  `meeting_baseline` int unsigned NOT NULL DEFAULT '0',
  `meeting_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`meeting_item_senior_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting_item_senior`
--

LOCK TABLES `dotp_monitoring_meeting_item_senior` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item_senior` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item_senior` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting_item_tasks_delivered`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting_item_tasks_delivered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting_item_tasks_delivered` (
  `meeting_item_taks_delivered_id` int unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int unsigned NOT NULL DEFAULT '0',
  `meeting_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`meeting_item_taks_delivered_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting_item_tasks_delivered`
--

LOCK TABLES `dotp_monitoring_meeting_item_tasks_delivered` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item_tasks_delivered` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_item_tasks_delivered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting_type`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting_type` (
  `meeting_type_id` int NOT NULL AUTO_INCREMENT,
  `meeting_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`meeting_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting_type`
--

LOCK TABLES `dotp_monitoring_meeting_type` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_type` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_meeting_type` VALUES (1,'Standard'),(2,'Delivery'),(3,'Monitoring'),(4,'Status Report'),(5,'Monitoring / Status Report');
/*!40000 ALTER TABLE `dotp_monitoring_meeting_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_meeting_user`
--

DROP TABLE IF EXISTS `dotp_monitoring_meeting_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_meeting_user` (
  `meeting_user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `meeting_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`meeting_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_meeting_user`
--

LOCK TABLES `dotp_monitoring_meeting_user` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_meeting_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_quality`
--

DROP TABLE IF EXISTS `dotp_monitoring_quality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_quality` (
  `quality_id` int NOT NULL AUTO_INCREMENT,
  `quality_type_id` int NOT NULL,
  `quality_description` text,
  `user_id` int DEFAULT NULL,
  `quality_status_id` int NOT NULL,
  `quality_date_end` datetime DEFAULT NULL,
  `task_id` int NOT NULL,
  PRIMARY KEY (`quality_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_quality`
--

LOCK TABLES `dotp_monitoring_quality` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_quality` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_quality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_quality_status`
--

DROP TABLE IF EXISTS `dotp_monitoring_quality_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_quality_status` (
  `quality_status_id` int NOT NULL AUTO_INCREMENT,
  `quality_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`quality_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_quality_status`
--

LOCK TABLES `dotp_monitoring_quality_status` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_quality_status` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_quality_status` VALUES (1,'Pending'),(2,'Concluded'),(3,'Canceled');
/*!40000 ALTER TABLE `dotp_monitoring_quality_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_quality_type`
--

DROP TABLE IF EXISTS `dotp_monitoring_quality_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_quality_type` (
  `quality_type_id` int NOT NULL AUTO_INCREMENT,
  `quality_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`quality_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_quality_type`
--

LOCK TABLES `dotp_monitoring_quality_type` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_quality_type` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_quality_type` VALUES (1,'Logical Error'),(2,'Business Error'),(3,'Analysis Error');
/*!40000 ALTER TABLE `dotp_monitoring_quality_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_responsibility_matriz`
--

DROP TABLE IF EXISTS `dotp_monitoring_responsibility_matriz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_responsibility_matriz` (
  `responsibility_id` int NOT NULL AUTO_INCREMENT,
  `responsibility_description` varchar(255) DEFAULT NULL,
  `responsibility_user_id_consultation` int DEFAULT NULL,
  `responsibility_user_id_execut` int DEFAULT NULL,
  `responsibility_user_id_support` int DEFAULT NULL,
  `responsibility_user_id_approve` int DEFAULT NULL,
  `project_id` int NOT NULL,
  PRIMARY KEY (`responsibility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_responsibility_matriz`
--

LOCK TABLES `dotp_monitoring_responsibility_matriz` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_responsibility_matriz` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_monitoring_responsibility_matriz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_monitoring_user_cost`
--

DROP TABLE IF EXISTS `dotp_monitoring_user_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_monitoring_user_cost` (
  `cost_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `cost_value` decimal(10,2) DEFAULT '0.00',
  `cost_per_use` decimal(11,0) DEFAULT NULL,
  `cost_dt_begin` datetime NOT NULL,
  `cost_dt_end` datetime DEFAULT NULL,
  PRIMARY KEY (`cost_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_monitoring_user_cost`
--

LOCK TABLES `dotp_monitoring_user_cost` WRITE;
/*!40000 ALTER TABLE `dotp_monitoring_user_cost` DISABLE KEYS */;
INSERT INTO `dotp_monitoring_user_cost` VALUES (1,4,56.00,NULL,'2013-10-10 00:00:00','2014-10-19 00:00:00'),(2,3,35.00,NULL,'2013-01-01 00:00:00','2017-07-31 00:00:00'),(3,2,60.00,NULL,'2013-02-01 00:00:00','2017-07-01 00:00:00'),(4,7,33.00,NULL,'2010-07-06 00:00:00','2017-07-30 00:00:00'),(5,8,40.00,NULL,'2013-01-02 00:00:00','2017-07-01 00:00:00'),(6,9,19.00,NULL,'2013-01-01 00:00:00','2017-07-01 00:00:00'),(7,13,45.00,NULL,'2016-03-01 00:00:00','2016-12-31 00:00:00'),(8,14,89.00,NULL,'2016-03-01 00:00:00','2016-12-31 00:00:00'),(9,21,70.50,NULL,'2025-10-01 00:00:00','2025-10-31 00:00:00');
/*!40000 ALTER TABLE `dotp_monitoring_user_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_need_for_training`
--

DROP TABLE IF EXISTS `dotp_need_for_training`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_need_for_training` (
  `project_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`project_id`),
  CONSTRAINT `FK_PROJECT_NEED_FOR_TRAINING` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_need_for_training`
--

LOCK TABLES `dotp_need_for_training` WRITE;
/*!40000 ALTER TABLE `dotp_need_for_training` DISABLE KEYS */;
INSERT INTO `dotp_need_for_training` VALUES (2,'Para o projeto da pizzaria do Tio Chico será necessário o treinamento dos membros da equipe no que se refere ao desenvolvimento para dispositivos móveis. Os membros da equipe não possuem experiência prêvia neste tipo de desenvolvimento. Em decorrência do módulo para dispositivo móvel ser de essencial importância para o sucesso do projeto, parte do orçamento deve ser destinada para realização do treinamento. Será realizado um treinamento de 40 horas, com duração de uma semana, pela empresa MobileDeveloperCoach. Todos os programadores envolvidos no projeto devem participar deste treinamento.'),(8,'The project team must be trained in the development for mobile platform. It is because despite their expertise in the development of web applications, they still lack of experience with mobile development. The training has to be focused on the Android OS, because the customer has chosen to adopt these devices.');
/*!40000 ALTER TABLE `dotp_need_for_training` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_permissions`
--

DROP TABLE IF EXISTS `dotp_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_permissions` (
  `permission_id` int NOT NULL AUTO_INCREMENT,
  `permission_user` int NOT NULL DEFAULT '0',
  `permission_grant_on` varchar(12) NOT NULL DEFAULT '',
  `permission_item` int NOT NULL DEFAULT '0',
  `permission_value` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `idx_pgrant_on` (`permission_grant_on`,`permission_item`,`permission_user`),
  KEY `idx_puser` (`permission_user`),
  KEY `idx_pvalue` (`permission_value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_permissions`
--

LOCK TABLES `dotp_permissions` WRITE;
/*!40000 ALTER TABLE `dotp_permissions` DISABLE KEYS */;
INSERT INTO `dotp_permissions` VALUES (1,1,'all',-1,-1);
/*!40000 ALTER TABLE `dotp_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_post_mortem_analysis`
--

DROP TABLE IF EXISTS `dotp_post_mortem_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_post_mortem_analysis` (
  `pma_id` int NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) NOT NULL DEFAULT '',
  `project_start_date` datetime DEFAULT NULL,
  `project_end_date` datetime DEFAULT NULL,
  `project_planned_start_date` datetime DEFAULT NULL,
  `project_planned_end_date` datetime DEFAULT NULL,
  `project_meeting_date` datetime DEFAULT NULL,
  `planned_budget` text,
  `budget` text,
  `participants` text,
  `project_strength` text,
  `project_weaknesses` text,
  `improvement_suggestions` text,
  `conclusions` text,
  PRIMARY KEY (`pma_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_post_mortem_analysis`
--

LOCK TABLES `dotp_post_mortem_analysis` WRITE;
/*!40000 ALTER TABLE `dotp_post_mortem_analysis` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_post_mortem_analysis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_contacts`
--

DROP TABLE IF EXISTS `dotp_project_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_contacts` (
  `project_id` int NOT NULL,
  `contact_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_contacts`
--

LOCK TABLES `dotp_project_contacts` WRITE;
/*!40000 ALTER TABLE `dotp_project_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_project_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_departments`
--

DROP TABLE IF EXISTS `dotp_project_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_departments` (
  `project_id` int NOT NULL,
  `department_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_departments`
--

LOCK TABLES `dotp_project_departments` WRITE;
/*!40000 ALTER TABLE `dotp_project_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_project_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_designer_options`
--

DROP TABLE IF EXISTS `dotp_project_designer_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_designer_options` (
  `pd_option_id` int NOT NULL AUTO_INCREMENT,
  `pd_option_user` int NOT NULL DEFAULT '0',
  `pd_option_view_project` int NOT NULL DEFAULT '1',
  `pd_option_view_gantt` int NOT NULL DEFAULT '1',
  `pd_option_view_tasks` int NOT NULL DEFAULT '1',
  `pd_option_view_actions` int NOT NULL DEFAULT '1',
  `pd_option_view_addtasks` int NOT NULL DEFAULT '1',
  `pd_option_view_files` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`pd_option_id`),
  UNIQUE KEY `pd_option_user` (`pd_option_user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_designer_options`
--

LOCK TABLES `dotp_project_designer_options` WRITE;
/*!40000 ALTER TABLE `dotp_project_designer_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_project_designer_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_eap_items`
--

DROP TABLE IF EXISTS `dotp_project_eap_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_eap_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `item_name` text,
  `number` text,
  `is_leaf` text,
  `identation` text,
  PRIMARY KEY (`id`),
  KEY `fk_eap_item_project` (`project_id`),
  CONSTRAINT `fk_eap_item_project` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_eap_items`
--

LOCK TABLES `dotp_project_eap_items` WRITE;
/*!40000 ALTER TABLE `dotp_project_eap_items` DISABLE KEYS */;
INSERT INTO `dotp_project_eap_items` VALUES (79,2,1,'Sistema para pizzaria','1','0',''),(80,2,2,'Gerência do projeto','1.1','0','&nbsp;&nbsp;&nbsp;'),(82,2,15,'Modelo do sistema','1.2','0','&nbsp;&nbsp;&nbsp;'),(83,2,19,'Sistema','1.3','0','&nbsp;&nbsp;&nbsp;'),(84,2,24,'Módulo web','1.3.2','0','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(85,2,27,'Módulo para dispositivo móvel','1.3.3','0','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(86,2,30,'Implantação','1.4','0','&nbsp;&nbsp;&nbsp;'),(87,2,31,'Treinamento dos usuários','1.4.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(88,2,32,'Instalação do sistema em servidor web produtivo','1.4.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(89,2,33,'Instalação de apps nos dispositivos móveis','1.4.3','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(90,2,34,'Site da pizzaria atualizado','1.4.4','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(93,2,28,'Funcionalidade de consulta dos pedidos em aberto','1.3.3.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(94,2,26,'Interface gráfica para os operadores ','1.3.2.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(96,2,25,'Interface gráfica para os clientes','1.3.2.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(97,2,20,'Módulo core','1.3.1','0','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(98,2,23,'Serviço para autenticação de usuários','1.3.1.3','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(99,2,22,'Serviços para manter o cadastro de pedidos','1.3.1.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(100,2,21,'Serviços para manter o cadastro de clientes','1.3.1.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(101,2,18,'Protótipos','1.2.3','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(102,2,17,'Diagramas','1.2.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(103,2,16,'Requisitos','1.2.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(104,2,11,'Encerramento','1.1.4','0','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(105,2,7,'Monitoramento e controle','1.1.3','0','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(106,2,4,'Execução','1.1.2','0','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(107,2,3,'Plano de gerenciamento do projeto','1.1.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(108,2,6,'Contratos das aquisições com fornecedores','1.1.2.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(109,2,5,'Auditoria da garantia da qualidade do processo','1.1.2.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(110,2,10,'Inspeção do controle da qualidade do produto','1.1.3.3','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(111,2,9,'Relatórios do progresso','1.1.3.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(112,2,8,'Reuniões de acompanhamento','1.1.3.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(113,2,14,'Ata da reunião de post mortem','1.1.4.3','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(114,2,13,'Registro das lições aprendidas','1.1.4.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(115,2,12,'Encerramento do contrato','1.1.4.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(158,8,1,'Pizza System','1','0',''),(159,8,2,'System design','1.1','1','   '),(160,8,3,'Project Management','1.2','0','   '),(161,8,4,'Project plan','1.2.1','1','      '),(182,2,29,'Novo item da EAP','1.3.3.2','1','         ');
/*!40000 ALTER TABLE `dotp_project_eap_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_ear_items`
--

DROP TABLE IF EXISTS `dotp_project_ear_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_ear_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `item_name` text,
  `number` text,
  `is_leaf` text,
  `identation` text,
  PRIMARY KEY (`id`),
  KEY `fk_ear_item_project` (`project_id`),
  CONSTRAINT `fk_ear_item_project` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_ear_items`
--

LOCK TABLES `dotp_project_ear_items` WRITE;
/*!40000 ALTER TABLE `dotp_project_ear_items` DISABLE KEYS */;
INSERT INTO `dotp_project_ear_items` VALUES (1,2,0,'Riscos','1','0',''),(2,2,1,'Interno','1.1','0','&nbsp;&nbsp;&nbsp;'),(3,2,2,'Organizacional','1.1.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(4,2,3,'Tecnológico','1.1.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(5,2,4,'Externo','1.2','0','&nbsp;&nbsp;&nbsp;'),(6,2,5,'Político','1.2.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(7,2,6,'Catastrofe','1.2.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(8,2,7,'EAR! artalizado','2','1',''),(10,8,0,'Risks','1','0',''),(11,8,1,'Internal','1.1','0','&nbsp;&nbsp;&nbsp;'),(12,8,2,'Organizational','1.1.1','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'),(13,8,3,'Technological','1.1.2','1','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
/*!40000 ALTER TABLE `dotp_project_ear_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_minutes`
--

DROP TABLE IF EXISTS `dotp_project_minutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_minutes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `minute_date` datetime DEFAULT NULL,
  `description` text,
  `isEffort` int DEFAULT '0',
  `isDuration` int DEFAULT '0',
  `isResource` int DEFAULT '0',
  `isSize` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_minute_project` (`project_id`),
  CONSTRAINT `fk_minute_project` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_minutes`
--

LOCK TABLES `dotp_project_minutes` WRITE;
/*!40000 ALTER TABLE `dotp_project_minutes` DISABLE KEYS */;
INSERT INTO `dotp_project_minutes` VALUES (1,8,'2016-03-14 00:00:00','<p>It was estimated the effort for the development of the mobile module, including functionalities to view the open requests, and to verify its details.</p><p>It was addopted the planning poker technique.</p>',1,1,NULL,NULL);
/*!40000 ALTER TABLE `dotp_project_minutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_tasks_estimated_roles`
--

DROP TABLE IF EXISTS `dotp_project_tasks_estimated_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_tasks_estimated_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estimation_task_roles` (`task_id`),
  KEY `fk_estimation_roles` (`role_id`),
  CONSTRAINT `fk_estimation_roles` FOREIGN KEY (`role_id`) REFERENCES `dotp_company_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_estimation_task_roles` FOREIGN KEY (`task_id`) REFERENCES `dotp_tasks` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_tasks_estimated_roles`
--

LOCK TABLES `dotp_project_tasks_estimated_roles` WRITE;
/*!40000 ALTER TABLE `dotp_project_tasks_estimated_roles` DISABLE KEYS */;
INSERT INTO `dotp_project_tasks_estimated_roles` VALUES (20,18,1),(223,42,1),(224,32,2),(225,34,2),(233,50,1),(248,79,1),(249,79,2),(250,79,2),(251,79,6),(252,79,7),(260,66,1),(261,66,1),(277,120,8),(278,122,9),(285,119,9),(286,121,9),(290,67,6),(294,128,5),(295,128,7),(296,128,5);
/*!40000 ALTER TABLE `dotp_project_tasks_estimated_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_project_tasks_estimations`
--

DROP TABLE IF EXISTS `dotp_project_tasks_estimations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_project_tasks_estimations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `effort` float DEFAULT NULL,
  `effort_unit` text,
  `duration` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estimation_task_attributes` (`task_id`),
  CONSTRAINT `fk_estimation_task_attributes` FOREIGN KEY (`task_id`) REFERENCES `dotp_tasks` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_project_tasks_estimations`
--

LOCK TABLES `dotp_project_tasks_estimations` WRITE;
/*!40000 ALTER TABLE `dotp_project_tasks_estimations` DISABLE KEYS */;
INSERT INTO `dotp_project_tasks_estimations` VALUES (6,18,0,'0',1),(7,20,0,'0',1),(17,35,0,'0',1),(26,34,0,'0',1),(27,44,0,'0',1),(33,50,0,'0',33),(45,62,0,'0',1),(46,63,0,'0',1),(47,64,0,'0',1),(48,65,0,'0',1),(49,66,0,'0',11),(50,67,5,'0',1),(51,68,6,'0',2),(52,69,0,'0',3),(53,70,0,'0',3),(54,71,0,'0',1),(55,72,0,'0',1),(56,73,0,'0',1),(57,74,0,'0',1),(58,75,0,'0',1),(59,76,0,'0',1),(60,77,0,'0',1),(61,78,0,'0',1),(62,79,0,'0',1),(63,80,0,'0',1),(64,81,0,'0',1),(65,82,0,'0',5),(66,83,0,'0',4),(67,84,0,'0',9),(68,85,0,'0',8),(69,86,0,'0',2),(70,87,0,'0',6),(71,88,0,'0',3),(72,89,0,'0',2),(73,90,0,'0',2),(74,91,0,'0',4),(75,92,0,'0',2),(76,93,0,'0',5),(77,94,0,'0',2),(78,95,0,'0',3),(79,96,0,'0',2),(80,97,0,'0',7),(81,98,0,'0',2),(82,99,0,'0',2),(83,100,0,'0',3),(84,101,0,'0',4),(85,102,0,'0',1),(86,103,0,'0',1),(87,104,0,'0',1),(88,105,0,'0',1),(89,106,0,'0',1),(101,119,20,'0',11),(102,120,15,'0',7),(103,121,15,'0',13),(104,122,12,'2',11),(108,126,6,'0',1),(109,128,128,'0',1);
/*!40000 ALTER TABLE `dotp_project_tasks_estimations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_projects`
--

DROP TABLE IF EXISTS `dotp_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_projects` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `project_company` int NOT NULL DEFAULT '0',
  `project_company_internal` int NOT NULL DEFAULT '0',
  `project_department` int NOT NULL DEFAULT '0',
  `project_name` varchar(255) DEFAULT NULL,
  `project_short_name` varchar(10) DEFAULT NULL,
  `project_owner` int DEFAULT '0',
  `project_url` varchar(255) DEFAULT NULL,
  `project_demo_url` varchar(255) DEFAULT NULL,
  `project_start_date` datetime DEFAULT NULL,
  `project_end_date` datetime DEFAULT NULL,
  `project_status` int DEFAULT '0',
  `project_percent_complete` tinyint DEFAULT '0',
  `project_color_identifier` varchar(6) DEFAULT 'eeeeee',
  `project_description` text,
  `project_target_budget` decimal(10,2) DEFAULT '0.00',
  `project_actual_budget` decimal(10,2) DEFAULT '0.00',
  `project_creator` int DEFAULT '0',
  `project_private` tinyint unsigned DEFAULT '0',
  `project_departments` char(100) DEFAULT NULL,
  `project_contacts` char(100) DEFAULT NULL,
  `project_priority` tinyint DEFAULT '0',
  `project_type` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`),
  KEY `idx_project_owner` (`project_owner`),
  KEY `idx_sdate` (`project_start_date`),
  KEY `idx_edate` (`project_end_date`),
  KEY `project_short_name` (`project_short_name`),
  KEY `idx_proj1` (`project_company`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_projects`
--

LOCK TABLES `dotp_projects` WRITE;
/*!40000 ALTER TABLE `dotp_projects` DISABLE KEYS */;
INSERT INTO `dotp_projects` VALUES (2,1,0,0,'Sistema de pizzaria do Tio Chico','Unidade In',2,'','','2013-02-01 00:00:00','2013-08-01 23:59:59',2,3,'FFFFFF','O objetivo deste projeto é desenvolver um sistema para a venda online de pizzas por meio do web site da pizzaria Tio Chico. O sistema também consiste em um módulo acessí­vel por meio de dispositivos móveis, utilizados pelos entregadores, o qual suporte a verificação dos detalhes das entregas pendentes (endereço de entrega, valor total, itens pedidos).\r\n\r\nO escopo deste projeto inclui um módulo web, que abrange a evolução do site da pizzaria para agregar a funcionalidade de solicitação de pizzas pelos clientes. Para isto o sistema deve manter o cadastro dos clientes, e possibilitar a autenticação dos mesmos. O processo de solicitação de pizzas deve suportar que sejam informados os sabores e tamanhos das pizzas e forma de pagamento. Este módulo deve apresentar o valor final do pedido ao cliente. Outra parte do módulo web será acessível apenas aos atendentes, para consultar os pedidos solicitados. Uma segunda parte do sistema é um módulo para dispositivos móveis, que será utilizado pelos entregadores para consultar os detalhes dos pedidos em aberto. No escopo do projeto está incluso a realização de treinamento aos atendentes da pizzaria, para capacita-los nos conhecimentos em informática, e instruí-los quanto a realização de operações no sistema.\r\n\r\nTambém está incluso a instalação do aplicativo em servidor web produtivo, e nos dispositivos móveis.\r\nOs critérios de aceite são:\r\na) o sistema instalado em ambiente produtivo, tanto na web como nos dispositivos móveis;\r\nb) treinamento realizado de acordo coma carga horária prevista;\r\nc) data de entrega e valor final do projeto dentro do orçamento e prazo acordados.\r\nAs entregas previstas durante o projeto são:\r\na) Módulo do sistema web: agregando ao site funcionalidades para solicitação de pizzas, cadastro e autenticação de clientes, e consulta de pedidos (acessí­vel apenas aos atendentes);\r\nb) Módulo para dispositivos móveis: aplicativo que suporte a consulta dos detalhes dos pedidos em aberto;\r\nc) Serviço de instalação do sistema no servidor web produtivo, e do aplicativo nos dispositivos móveis;\r\nd) Serviço de treinamento aos funcionários da pizzaria.\r\n\r\nEstão fora do escopo deste projeto:\r\na) O pagamento dos pedidos não será realizado pelo sistema. Este será realizado em campo, pelo  entregador, no ato da entrega da pizza aos clientes. O sistema apenas registra durante o pedido online a forma de pagamento;\r\nb) A portabilidade entre dispositivos móveis será restrita aos dispositivos que utilizem o sistema operacional Android. O módulo para dispositivos móveis não será suportado em dispositivos com outros sistemas operacionais, como, por exemplo, iOS e Windows. As restrições que o projeto deverá atender são: a) a data de entrega do sistema deve ocorrer antes do dia 1 de setembro de 2013; b) O orçamento não deve ultrapassar R$ 110.000,00;\r\nc) A interface gráfica do módulo web e do módulo para dispositivos móveis devem seguir os padrões de design da pizzaria.\r\n\r\nConsideram-se premissas para que o projeto possa ser desenvolvido dentro das restrições estipuladas que o contratante irá fornecer os equipamentos de hardware necessários (computadores para os atendentes, servidor, e dispositivos móveis), assim como o acesso à  internet no ambiente de produção.',110000.00,0.00,11,0,'0','',0,0),(8,4,0,0,'Pizza System - Uncle Chico','Pizza Syst',13,'','','2016-03-14 00:00:00','2016-09-01 23:59:59',2,0,'FFFFFF','This project aims to develop a computional system where customers may request their pizza, and employess may verify these requests when preparing and delivering each request.\r\n\r\nThis system is composed of two main modules:\r\n\r\nWeb module: A web page which customers may inform their requests, selecting the pizza information, such as flavor and size, select the drink, and also inform the address for delivery.\r\n\r\nMobile module: An app acessed from smart phones, which employess may consult the request information when are in field delivering pizzas.',30000.00,0.00,12,0,'0','',0,0),(9,8,0,0,'Projeto de teste',NULL,21,NULL,NULL,'2026-01-01 00:00:00','2027-01-01 00:00:00',3,0,'eeeeee','Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.\r\n\r\nLorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.',50000000.00,0.00,1,0,NULL,NULL,0,0);
/*!40000 ALTER TABLE `dotp_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_quality_assurance_item`
--

DROP TABLE IF EXISTS `dotp_quality_assurance_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_quality_assurance_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quality_planning_id` int DEFAULT NULL,
  `what` text,
  `who` text,
  `when` text,
  `how` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_QUALITY_ASSURANCE_ITEM` (`quality_planning_id`),
  CONSTRAINT `FK_PROJECT_QUALITY_ASSURANCE_ITEM` FOREIGN KEY (`quality_planning_id`) REFERENCES `dotp_quality_planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_quality_assurance_item`
--

LOCK TABLES `dotp_quality_assurance_item` WRITE;
/*!40000 ALTER TABLE `dotp_quality_assurance_item` DISABLE KEYS */;
INSERT INTO `dotp_quality_assurance_item` VALUES (2,1,'Gerência de Requisitos','Auditor externo','Mensalmente','Utilizando o MA-MPS (Modelo de avaliação)'),(6,1,'Gerência do Projeto','Auditor externo','Mensalmente','Utilizando o MA-MPS (Modelo de avaliação)'),(7,1,'Código SQL','Por revisão do código','Analista de Sistemas','Semanalmente'),(12,4,'Requirements Management','SCAMPI','External Auditor','Monthly'),(13,4,'','','','');
/*!40000 ALTER TABLE `dotp_quality_assurance_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_quality_control_analiysis_question`
--

DROP TABLE IF EXISTS `dotp_quality_control_analiysis_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_quality_control_analiysis_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `goal_id` int DEFAULT NULL,
  `question` text,
  `target` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_QUALITY_GOAL_QUESTION` (`goal_id`),
  CONSTRAINT `FK_PROJECT_QUALITY_GOAL_QUESTION` FOREIGN KEY (`goal_id`) REFERENCES `dotp_quality_control_goal` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_quality_control_analiysis_question`
--

LOCK TABLES `dotp_quality_control_analiysis_question` WRITE;
/*!40000 ALTER TABLE `dotp_quality_control_analiysis_question` DISABLE KEYS */;
INSERT INTO `dotp_quality_control_analiysis_question` VALUES (41,1,'Qual  a densidade de defeitos?','menor que 10kloc'),(42,3,'Qual a taxa de satisfaça£o com a usabilidade do sistema?','80 pontos SUS'),(43,3,'Qual a eficâcia do sistema?','90%'),(54,10,'What is the issues density?','lower than 10kloc');
/*!40000 ALTER TABLE `dotp_quality_control_analiysis_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_quality_control_goal`
--

DROP TABLE IF EXISTS `dotp_quality_control_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_quality_control_goal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quality_planning_id` int DEFAULT NULL,
  `gqm_goal_object` text,
  `gqm_goal_propose` text,
  `gqm_goal_respect_to` text,
  `gqm_goal_point_of_view` text,
  `gqm_goal_context` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_QUALITY_CONTROL_GOAL` (`quality_planning_id`),
  CONSTRAINT `FK_PROJECT_QUALITY_CONTROL_GOAL` FOREIGN KEY (`quality_planning_id`) REFERENCES `dotp_quality_planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_quality_control_goal`
--

LOCK TABLES `dotp_quality_control_goal` WRITE;
/*!40000 ALTER TABLE `dotp_quality_control_goal` DISABLE KEYS */;
INSERT INTO `dotp_quality_control_goal` VALUES (1,1,'sistema web','caracterizar','confiabilidade','desenvolvedor','pizzaria do tio chico'),(3,1,'sistema web','caracterizar','usabilidade','cliente da pizzaria','pizzaria do tio chico'),(10,4,'web system','characterize','confiability','Developer','Uncle Chico  pizzeria');
/*!40000 ALTER TABLE `dotp_quality_control_goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_quality_control_metric`
--

DROP TABLE IF EXISTS `dotp_quality_control_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_quality_control_metric` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int DEFAULT NULL,
  `metric` text,
  `how_to_collect` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_QUALITY_METRIC` (`question_id`),
  CONSTRAINT `FK_PROJECT_QUALITY_METRIC` FOREIGN KEY (`question_id`) REFERENCES `dotp_quality_control_analiysis_question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_quality_control_metric`
--

LOCK TABLES `dotp_quality_control_metric` WRITE;
/*!40000 ALTER TABLE `dotp_quality_control_metric` DISABLE KEYS */;
INSERT INTO `dotp_quality_control_metric` VALUES (6,41,'Número de linhas de código com erros','Case tool'),(8,41,'Número de linhas de código total','Case tool'),(9,41,'Número de defeitos dectados','Testes de unidade'),(10,42,'Satisfação','Aplicando questionário SUS - avaliando pontuação do questionário'),(11,43,'Quantos usuários participaram dos testes','Contabilizando quantidade de respostas recebidas'),(12,43,'Quantos usuários conseguiram concluir as tarefas','Por teste de usabilidade - quantos participantes consequem concluir todas as tarefas'),(14,54,'Number o LOC with issues','case tool'),(15,54,'Total number of LOC','case tool');
/*!40000 ALTER TABLE `dotp_quality_control_metric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_quality_control_requirement`
--

DROP TABLE IF EXISTS `dotp_quality_control_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_quality_control_requirement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quality_planning_id` int DEFAULT NULL,
  `requirement` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_QUALITY_CONTROL_REQUIREMENT` (`quality_planning_id`),
  CONSTRAINT `FK_PROJECT_QUALITY_CONTROL_REQUIREMENT` FOREIGN KEY (`quality_planning_id`) REFERENCES `dotp_quality_planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_quality_control_requirement`
--

LOCK TABLES `dotp_quality_control_requirement` WRITE;
/*!40000 ALTER TABLE `dotp_quality_control_requirement` DISABLE KEYS */;
INSERT INTO `dotp_quality_control_requirement` VALUES (2,1,'Confiabilidade: densidade de defeitos inferior a 10kloc.'),(4,1,'Usabilidade: todas as tarefas podem ser concluidas por 90% dos usuários para os quais foram feitas.'),(5,1,'Usabilidade: a taxa de satisfação com questionario SUS (System Usability Scale) deve ser igual ou superior a 80%.'),(6,4,'Confiability: Issues density lower than 10kloc.');
/*!40000 ALTER TABLE `dotp_quality_control_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_quality_planning`
--

DROP TABLE IF EXISTS `dotp_quality_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_quality_planning` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `quality_controlling` text,
  `quality_assurance` text,
  `quality_policies` text,
  PRIMARY KEY (`id`),
  KEY `FK_PROJECT_ACQUISITION` (`project_id`),
  CONSTRAINT `FK_PROJECT_ACQUISITION` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_quality_planning`
--

LOCK TABLES `dotp_quality_planning` WRITE;
/*!40000 ALTER TABLE `dotp_quality_planning` DISABLE KEYS */;
INSERT INTO `dotp_quality_planning` VALUES (1,2,NULL,NULL,'O projeto deve ser realizado atendendo ao modelo MPS.BR no nível G, que inclui as áreas de processos de Gerência de Requisitos e Gerência de Projetos.\r\nA implementação deve seguir os padrões Open SQL. '),(4,8,NULL,NULL,'The project must attend the CMMI-DEV level 2, particulary the project planning and requirements management process areas.\r\nThe project must be implemented adopting the OPEN-SQL standard.');
/*!40000 ALTER TABLE `dotp_quality_planning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_raci`
--

DROP TABLE IF EXISTS `dotp_raci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_raci` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `human_resource_id` int NOT NULL,
  `project_id` int NOT NULL,
  `activity_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `raci_role` enum('R','A','C','I') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dotp_raci_human_resource_id_foreign` (`human_resource_id`),
  KEY `dotp_raci_project_id_foreign` (`project_id`),
  CONSTRAINT `dotp_raci_human_resource_id_foreign` FOREIGN KEY (`human_resource_id`) REFERENCES `dotp_human_resource` (`human_resource_id`) ON DELETE CASCADE,
  CONSTRAINT `dotp_raci_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_raci`
--

LOCK TABLES `dotp_raci` WRITE;
/*!40000 ALTER TABLE `dotp_raci` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_raci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_resource_tasks`
--

DROP TABLE IF EXISTS `dotp_resource_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_resource_tasks` (
  `resource_id` int NOT NULL DEFAULT '0',
  `task_id` int NOT NULL DEFAULT '0',
  `percent_allocated` int NOT NULL DEFAULT '100',
  KEY `resource_id` (`resource_id`),
  KEY `task_id` (`task_id`,`resource_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_resource_tasks`
--

LOCK TABLES `dotp_resource_tasks` WRITE;
/*!40000 ALTER TABLE `dotp_resource_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_resource_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_resource_types`
--

DROP TABLE IF EXISTS `dotp_resource_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_resource_types` (
  `resource_type_id` int NOT NULL AUTO_INCREMENT,
  `resource_type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resource_type_note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`resource_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_resource_types`
--

LOCK TABLES `dotp_resource_types` WRITE;
/*!40000 ALTER TABLE `dotp_resource_types` DISABLE KEYS */;
INSERT INTO `dotp_resource_types` VALUES (1,'Equipment',NULL),(2,'Tool',NULL),(3,'Venue',NULL);
/*!40000 ALTER TABLE `dotp_resource_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_resources`
--

DROP TABLE IF EXISTS `dotp_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_resources` (
  `resource_id` int NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resource_key` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resource_type` int NOT NULL DEFAULT '0',
  `resource_note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `resource_max_allocation` int NOT NULL DEFAULT '100',
  PRIMARY KEY (`resource_id`),
  KEY `resource_name` (`resource_name`),
  KEY `resource_type` (`resource_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_resources`
--

LOCK TABLES `dotp_resources` WRITE;
/*!40000 ALTER TABLE `dotp_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_risks`
--

DROP TABLE IF EXISTS `dotp_risks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_risks` (
  `risk_id` int NOT NULL AUTO_INCREMENT,
  `risk_name` varchar(255) NOT NULL,
  `risk_cause` varchar(255) NOT NULL,
  `risk_consequence` varchar(255) NOT NULL,
  `risk_responsible` int NOT NULL,
  `risk_description` varchar(2000) DEFAULT NULL,
  `risk_probability` varchar(15) NOT NULL,
  `risk_impact` varchar(15) NOT NULL,
  `risk_answer_to_risk` varchar(2000) DEFAULT NULL,
  `risk_project` int DEFAULT NULL,
  `risk_task` int DEFAULT NULL,
  `risk_notes` varchar(2000) DEFAULT NULL,
  `risk_potential_other_projects` varchar(2) NOT NULL,
  `risk_lessons_learned` varchar(2000) DEFAULT NULL,
  `risk_priority` varchar(15) NOT NULL,
  `risk_active` int NOT NULL,
  `risk_strategy` int NOT NULL,
  `risk_prevention_actions` varchar(2000) DEFAULT NULL,
  `risk_contingency_plan` varchar(2000) DEFAULT NULL,
  `risk_period_start_date` date DEFAULT NULL,
  `risk_period_end_date` date DEFAULT NULL,
  `risk_status` varchar(45) DEFAULT NULL,
  `risk_ear_classification` varchar(45) DEFAULT NULL,
  `risk_triggers` varchar(2000) DEFAULT NULL,
  `risk_is_contingency` int DEFAULT NULL,
  PRIMARY KEY (`risk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_risks`
--

LOCK TABLES `dotp_risks` WRITE;
/*!40000 ALTER TABLE `dotp_risks` DISABLE KEYS */;
INSERT INTO `dotp_risks` VALUES (2,'Afastamento do analista de testes','teste','consequencia',5,'-------------------','3','3',NULL,2,20,'teste','1',NULL,'2',0,2,'Oferecer ao analista de testes uma bonificação financeira ao têrmino do projeto, para que ele postergue a mudança para depois do projeto.','Contratar um novo analista de testes.','0000-00-00','0000-00-00','0','3','teste',1),(4,'Problemas com HD','','',5,'--------','3','3',NULL,2,0,'','0',NULL,'2',0,2,'Realização de backup diariamente ao têrmino do trabalho.','Recuperar o backup mais recente após a detecção da indisponibilidade dos dados.','0000-00-00','0000-00-00','0','3','',0),(5,'O cliente pode declarar falência durante o projeto.','','',0,'teste','2','4',NULL,2,0,'','0',NULL,'2',0,0,NULL,NULL,'0000-00-00','0000-00-00','0','3','',1),(6,'Problemas de disponibilidade do servidor quando o dispositivo móvel estiver em campo.','','',5,'-----------------','2','4',NULL,2,0,'','0',NULL,'2',0,3,'Será delegado ao cliente a contratação de um provedor para hospedagem do aplicativo.\r\nA disponibilidade do aplicativo será de responsabilidade deste provedor.','','0000-00-00','0000-00-00','0','3','',0),(7,'Greve de ônibus na Ilha do Silí­cio','','',5,'--------------','4','3',NULL,2,0,'','0',NULL,'2',0,2,'Apoiar o sindicato dos trabalhadores do transporte coletivo.','Acordar com os membros da equipe para trabalharem remotamente nos dias de greve.','0000-00-00','0000-00-00','0','3','',1),(8,'Extraviar o dispositivo móvel de testes.','','',5,'-----------------','1','3',NULL,2,0,'','0',NULL,'1',0,2,'Manter o dispositivo móvel dentro da empresa.\r\nTransportá-lo apenas quando estritamente necessário.','Adquirir um novo dispositivo móvel.','0000-00-00','0000-00-00','0','3','',1),(9,'O usuário não estará disponíve para levantar os requisitos.','','',5,'Devido a agenda difícil do usuários, podem ocorrer dificuldades em agendar reuniões de levantamento de requisitos.','0','0',NULL,1,0,'','0',NULL,'0',0,0,'','','0000-00-00','0000-00-00','0','9','',0),(10,'Teste','','',0,'teste','0','0',NULL,4,0,NULL,'0',NULL,'0',0,0,NULL,NULL,NULL,NULL,'0','0',NULL,0),(12,'teste - eliminar','','',5,'-=-------------','0','0',NULL,5,0,NULL,'0',NULL,'0',0,1,NULL,NULL,NULL,NULL,'0','0',NULL,0),(15,'teste','','',5,'teste\'','0','0',NULL,1,0,'','0',NULL,'0',0,1,'prevenção...','d','0000-00-00','0000-00-00','0','9','',0),(16,'teste','','',5,'teste','0','0',NULL,1,0,NULL,'0',NULL,'0',0,0,NULL,NULL,NULL,NULL,'0','9',NULL,0),(17,'Programmer leave the project','The programer may receive a better opportunity.','The project may delay until a new programmer is hired.',13,'The programmer may leave the project, thus it may delay.','1','3',NULL,8,0,'','0',NULL,'1',0,2,'Offer a good rewarding to the programmer.','Ask the programmer to work from home office, then he may continue working in the projct activities.','2016-03-01','2016-09-01','0','12','Programmer informs he needs to leave the project team.',1);
/*!40000 ALTER TABLE `dotp_risks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_risks_management_plan`
--

DROP TABLE IF EXISTS `dotp_risks_management_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_risks_management_plan` (
  `risk_plan_id` int NOT NULL DEFAULT '0',
  `project_id` int DEFAULT NULL,
  `probability_super_low` varchar(250) DEFAULT NULL,
  `probability_low` varchar(250) DEFAULT NULL,
  `probability_medium` varchar(250) DEFAULT NULL,
  `probability_high` varchar(250) DEFAULT NULL,
  `probability_super_high` varchar(250) DEFAULT NULL,
  `impact_super_low` varchar(250) DEFAULT NULL,
  `impact_low` varchar(250) DEFAULT NULL,
  `impact_medium` varchar(250) DEFAULT NULL,
  `impact_high` varchar(250) DEFAULT NULL,
  `impact_super_high` varchar(250) DEFAULT NULL,
  `matrix_superlow_superlow` varchar(30) DEFAULT NULL,
  `matrix_superlow_low` varchar(30) DEFAULT NULL,
  `matrix_superlow_medium` varchar(30) DEFAULT NULL,
  `matrix_superlow_high` varchar(30) DEFAULT NULL,
  `matrix_superlow_superhigh` varchar(30) DEFAULT NULL,
  `matrix_low_superlow` varchar(30) DEFAULT NULL,
  `matrix_low_low` varchar(30) DEFAULT NULL,
  `matrix_low_medium` varchar(30) DEFAULT NULL,
  `matrix_low_high` varchar(30) DEFAULT NULL,
  `matrix_low_superhigh` varchar(30) DEFAULT NULL,
  `matrix_medium_superlow` varchar(30) DEFAULT NULL,
  `matrix_medium_low` varchar(30) DEFAULT NULL,
  `matrix_medium_medium` varchar(30) DEFAULT NULL,
  `matrix_medium_high` varchar(30) DEFAULT NULL,
  `matrix_medium_superhigh` varchar(30) DEFAULT NULL,
  `matrix_high_superlow` varchar(30) DEFAULT NULL,
  `matrix_high_low` varchar(30) DEFAULT NULL,
  `matrix_high_medium` varchar(30) DEFAULT NULL,
  `matrix_high_high` varchar(30) DEFAULT NULL,
  `matrix_high_superhigh` varchar(30) DEFAULT NULL,
  `matrix_superhigh_superlow` varchar(30) DEFAULT NULL,
  `matrix_superhigh_low` varchar(30) DEFAULT NULL,
  `matrix_superhigh_medium` varchar(30) DEFAULT NULL,
  `matrix_superhigh_high` varchar(30) DEFAULT NULL,
  `matrix_superhigh_superhigh` varchar(30) DEFAULT NULL,
  `risk_contengency_reserve_protocol` varchar(500) DEFAULT NULL,
  `risk_revision_frequency` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`risk_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_risks_management_plan`
--

LOCK TABLES `dotp_risks_management_plan` WRITE;
/*!40000 ALTER TABLE `dotp_risks_management_plan` DISABLE KEYS */;
INSERT INTO `dotp_risks_management_plan` VALUES (1,1,'Um evento similar ocorreu uma única vez em outra organização','Um evento similar ocorreu em uma organização similar.','Um evento similar já ocorreu nesta organização.','Um evento similar já ocorreu diversas vezes nesta organização.','Um evento similar já ocorreu muitas vezes na mesa atividade ou operação.','O impacto pode ser ignorado.','Impacto mínimo que pode ser contornado por procedimentos padrão.','Impacto maior, que pode ser contornado com algum esforço, utilizando procedimentos padrão.','Evento crítico, que pode gerar algum custo ou atrazo ao projeto, ou produtos não apropriados.','Evento extremo, que pode gerar custos ou atrasos, ou até deteriorar a imagem da organização.','0','0','0','1','1','0','0','1','1','1','0','0','1','1','2','1','1','1','2','2','1','1','2','2','2','A liberação dos recursos da reserva de contingência devem ser solicitados a administração com a comprovação da ocorrência do mesmo.','15'),(2,2,'Um evento similar ocorreu uma Ãºnica vez em outra organizaÃ§Ã£o','Um evento similar ocorreu em uma organizaÃ§Ã£o similar.','Um evento similar jÃ¡ ocorreu nesta organizaÃ§Ã£o.','Um evento similar jÃ¡ ocorreu diversas vezes nesta organizaÃ§Ã£o.','Um evento similar jÃ¡ ocorreu muitas vezes na mesa atividade ou operaÃ§Ã£o.','O impacto pode ser ignorado.','Impacto mÃ­nimo que pode ser contornado por procedimentos padrÃ£o.','Impacto maior, que pode ser contornado com algum esforÃ§o, utilizando procedimentos padrÃ£o.','Evento crÃ­tico, que pode gerar algum custo ou atrazo ao projeto, ou produtos nÃ£o apropriados.','Evento extremo, que pode gerar custos ou atrasos, ou atÃ© deteriorar a imagem da organizaÃ§Ã£o.','0','0','0','1','1','0','0','1','1','1','0','0','1','1','2','1','1','1','2','2','1','1','2','2','2','A liberaÃ§Ã£o dos recursos da reserva de contingÃªncia devem ser solicitados a administraÃ§Ã£o com a comprovaÃ§Ã£o da ocorrÃªncia do mesmo. editado!!!','15'),(8,8,'A similar risk happens once in other organization.','A similar risk happens once in a similar organization.','A similar risk happens once in this organization.','A similar risk happens a few times in this organization.','A similar risk happens many times in this organization.','The impact may be ignorade.','The impact is minimum and may be handled by the default procedure.','Major event and with some effort may be handled by the default procedure.','Critical event, may generate some cost or delay in the project.','Extreme event, may generate cost or delay, or jeopardize organizational image.','0','0','0','1','1','0','0','1','1','1','0','0','1','1','2','1','1','1','2','2','1','1','2','2','2','The release of the contingency reserve may be requested to the administration, presenting the evidence the risk ocurred.','15');
/*!40000 ALTER TABLE `dotp_risks_management_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_roles`
--

DROP TABLE IF EXISTS `dotp_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_roles` (
  `role_id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(24) NOT NULL DEFAULT '',
  `role_description` varchar(255) NOT NULL DEFAULT '',
  `role_type` int unsigned NOT NULL DEFAULT '0',
  `role_module` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_roles`
--

LOCK TABLES `dotp_roles` WRITE;
/*!40000 ALTER TABLE `dotp_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_scope_requirement_categories`
--

DROP TABLE IF EXISTS `dotp_scope_requirement_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_scope_requirement_categories` (
  `req_categ_prefix_id` varchar(3) NOT NULL,
  `req_categ_description` text,
  `req_categ_name` varchar(20) NOT NULL,
  `req_categ_priority` tinyint DEFAULT NULL,
  PRIMARY KEY (`req_categ_prefix_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_scope_requirement_categories`
--

LOCK TABLES `dotp_scope_requirement_categories` WRITE;
/*!40000 ALTER TABLE `dotp_scope_requirement_categories` DISABLE KEYS */;
INSERT INTO `dotp_scope_requirement_categories` VALUES ('RF',NULL,'Funcional',NULL),('RNF',NULL,'Não-funcional',NULL);
/*!40000 ALTER TABLE `dotp_scope_requirement_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_scope_requirement_priorities`
--

DROP TABLE IF EXISTS `dotp_scope_requirement_priorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_scope_requirement_priorities` (
  `req_priority_id` varchar(20) NOT NULL,
  PRIMARY KEY (`req_priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_scope_requirement_priorities`
--

LOCK TABLES `dotp_scope_requirement_priorities` WRITE;
/*!40000 ALTER TABLE `dotp_scope_requirement_priorities` DISABLE KEYS */;
INSERT INTO `dotp_scope_requirement_priorities` VALUES ('Alta'),('Baixa'),('Normal');
/*!40000 ALTER TABLE `dotp_scope_requirement_priorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_scope_requirement_status`
--

DROP TABLE IF EXISTS `dotp_scope_requirement_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_scope_requirement_status` (
  `req_status_id` varchar(20) NOT NULL,
  PRIMARY KEY (`req_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_scope_requirement_status`
--

LOCK TABLES `dotp_scope_requirement_status` WRITE;
/*!40000 ALTER TABLE `dotp_scope_requirement_status` DISABLE KEYS */;
INSERT INTO `dotp_scope_requirement_status` VALUES ('Adiado'),('Adicionado'),('Aprovado'),('Ativo'),('Cancelado');
/*!40000 ALTER TABLE `dotp_scope_requirement_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_scope_requirements`
--

DROP TABLE IF EXISTS `dotp_scope_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_scope_requirements` (
  `req_id` int NOT NULL AUTO_INCREMENT,
  `req_idname` varchar(6) NOT NULL,
  `req_description` text NOT NULL,
  `req_source` varchar(60) NOT NULL,
  `req_owner` varchar(60) NOT NULL,
  `req_categ_prefix_id` varchar(3) NOT NULL,
  `req_priority_id` varchar(20) NOT NULL,
  `req_status_id` varchar(20) NOT NULL,
  `req_version` varchar(20) DEFAULT NULL,
  `req_inclusiondate` date NOT NULL,
  `req_conclusiondate` date DEFAULT NULL,
  `eapitem_id` int DEFAULT NULL,
  `req_testcase` text,
  `project_id` int NOT NULL,
  PRIMARY KEY (`req_id`),
  KEY `req_categ_prefix_id` (`req_categ_prefix_id`),
  KEY `req_priority_id` (`req_priority_id`),
  KEY `req_status_id` (`req_status_id`),
  KEY `eapitem_id` (`eapitem_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `dotp_scope_requirements_ibfk_1` FOREIGN KEY (`req_categ_prefix_id`) REFERENCES `dotp_scope_requirement_categories` (`req_categ_prefix_id`),
  CONSTRAINT `dotp_scope_requirements_ibfk_2` FOREIGN KEY (`req_priority_id`) REFERENCES `dotp_scope_requirement_priorities` (`req_priority_id`),
  CONSTRAINT `dotp_scope_requirements_ibfk_3` FOREIGN KEY (`req_status_id`) REFERENCES `dotp_scope_requirement_status` (`req_status_id`),
  CONSTRAINT `dotp_scope_requirements_ibfk_4` FOREIGN KEY (`eapitem_id`) REFERENCES `dotp_project_eap_items` (`id`),
  CONSTRAINT `dotp_scope_requirements_ibfk_5` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_scope_requirements`
--

LOCK TABLES `dotp_scope_requirements` WRITE;
/*!40000 ALTER TABLE `dotp_scope_requirements` DISABLE KEYS */;
INSERT INTO `dotp_scope_requirements` VALUES (1,'REQ1','Tela de login','X1','Cleiton','RF','Alta','Ativo','1.01','2021-12-09','2022-01-28',NULL,NULL,2);
/*!40000 ALTER TABLE `dotp_scope_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_scope_requirements_managplan`
--

DROP TABLE IF EXISTS `dotp_scope_requirements_managplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_scope_requirements_managplan` (
  `req_managplan_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `req_managplan_collect_descr` text,
  `req_managplan_reqcategories` text,
  `req_managplan_reqprioritization` text,
  `req_managplan_trac_descr` text,
  `req_managplan_config_descr` text,
  `req_managplan_verif_descr` text,
  PRIMARY KEY (`req_managplan_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `dotp_scope_requirements_managplan_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_scope_requirements_managplan`
--

LOCK TABLES `dotp_scope_requirements_managplan` WRITE;
/*!40000 ALTER TABLE `dotp_scope_requirements_managplan` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_scope_requirements_managplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_scope_statement`
--

DROP TABLE IF EXISTS `dotp_scope_statement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_scope_statement` (
  `scope_id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `scope_description` text,
  `scope_acceptancecriteria` text,
  `scope_deliverables` text,
  `scope_exclusions` text,
  `scope_constraints` text,
  `scope_assumptions` text,
  PRIMARY KEY (`scope_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `dotp_scope_statement_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `dotp_projects` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_scope_statement`
--

LOCK TABLES `dotp_scope_statement` WRITE;
/*!40000 ALTER TABLE `dotp_scope_statement` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_scope_statement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_sessions`
--

DROP TABLE IF EXISTS `dotp_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_sessions` (
  `session_id` varchar(60) NOT NULL DEFAULT '',
  `session_user` int NOT NULL DEFAULT '0',
  `session_data` longblob,
  `session_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `session_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`session_id`),
  KEY `session_updated` (`session_updated`),
  KEY `session_created` (`session_created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_sessions`
--

LOCK TABLES `dotp_sessions` WRITE;
/*!40000 ALTER TABLE `dotp_sessions` DISABLE KEYS */;
INSERT INTO `dotp_sessions` VALUES ('0h1mpm78rqjdrmteseto280as3',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:48:11','2016-06-03 04:48:11'),('11cvtiagmq6s85k7cncndhotg5',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:24:24','2016-06-03 05:24:24'),('1a60716f6cf616a51c2e8a290c77a3a4',164,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:11:{s:12:\"SAVEDPLACE-1\";s:11:\"m=resources\";s:10:\"SAVEDPLACE\";s:9:\"m=history\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:7:\"user_id\";s:1:\"1\";s:22:\"TaskListShowIncomplete\";i:0;s:12:\"tasks_opened\";a:0:{}s:9:\"ProjVwTab\";s:1:\"0\";s:16:\"RisksIdxOrderDir\";s:4:\"desc\";s:15:\"ResourcesIdxTab\";i:0;}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"164\";s:10:\"project_id\";i:0;}user_feedback|a:1:{i:3;i:3;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:14:{s:8:\"projects\";a:11:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:7:\"History\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/history/projects_tab.history\";s:6:\"module\";s:7:\"history\";}i:5;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/links/projects_tab.links\";s:6:\"module\";s:5:\"links\";}i:6;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:9;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:10;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:20:\"monitoringandcontrol\";a:0:{}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:15:\"dotproject_plus\";a:0:{}s:5:\"tasks\";a:4:{i:0;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:54:\"/var/www/dotproject_plus/modules/files/tasks_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:6:{i:0;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:59:\"/var/www/dotproject_plus/modules/files/tasks_tab.view.files\";s:6:\"module\";s:5:\"files\";}i:1;a:3:{s:4:\"name\";s:11:\"Allocations\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/human_resources/tasks_tab.view.allocations\";s:6:\"module\";s:15:\"human_resources\";}i:2;a:3:{s:4:\"name\";s:17:\"3LBLACAOCORRETIVA\";s:4:\"file\";s:86:\"/var/www/dotproject_plus/modules/monitoringandcontrol/tasks_tab.view.3LBLACAOCORRETIVA\";s:6:\"module\";s:20:\"monitoringandcontrol\";}i:3;a:3:{s:4:\"name\";s:13:\"7LBLQUALIDADE\";s:4:\"file\";s:82:\"/var/www/dotproject_plus/modules/monitoringandcontrol/tasks_tab.view.7LBLQUALIDADE\";s:6:\"module\";s:20:\"monitoringandcontrol\";}i:4;a:3:{s:4:\"name\";s:15:\"Other resources\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/resources/tasks_tab.view.other_resources\";s:6:\"module\";s:9:\"resources\";}i:5;a:3:{s:4:\"name\";s:18:\"2LBLHumanResources\";s:4:\"file\";s:79:\"/var/www/dotproject_plus/modules/timeplanning/tasks_tab.view.2LBLHumanResources\";s:6:\"module\";s:12:\"timeplanning\";}}s:7:\"addedit\";a:2:{i:0;a:3:{s:4:\"name\";s:11:\"Allocations\";s:4:\"file\";s:78:\"/var/www/dotproject_plus/modules/human_resources/tasks_tab.addedit.allocations\";s:6:\"module\";s:15:\"human_resources\";}i:1;a:3:{s:4:\"name\";s:15:\"Other resources\";s:4:\"file\";s:76:\"/var/www/dotproject_plus/modules/resources/tasks_tab.addedit.other_resources\";s:6:\"module\";s:9:\"resources\";}}i:1;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:54:\"/var/www/dotproject_plus/modules/links/tasks_tab.links\";s:6:\"module\";s:5:\"links\";}}s:13:\"scopeplanning\";a:0:{}s:15:\"projectdesigner\";a:0:{}s:15:\"human_resources\";a:0:{}s:5:\"costs\";a:0:{}s:13:\"communication\";a:0:{}s:5:\"risks\";a:0:{}s:12:\"timeplanning\";a:0:{}s:9:\"resources\";a:0:{}s:7:\"history\";a:0:{}}user_choosen_feature|N;gqs_tab|s:1:\"0\";resource_type_list|a:4:{i:0;a:2:{s:16:\"resource_type_id\";i:0;s:18:\"resource_type_name\";s:13:\"All Resources\";}i:1;a:4:{i:0;s:1:\"1\";s:16:\"resource_type_id\";s:1:\"1\";i:1;s:9:\"Equipment\";s:18:\"resource_type_name\";s:9:\"Equipment\";}i:2;a:4:{i:0;s:1:\"2\";s:16:\"resource_type_id\";s:1:\"2\";i:1;s:4:\"Tool\";s:18:\"resource_type_name\";s:4:\"Tool\";}i:3;a:4:{i:0;s:1:\"3\";s:16:\"resource_type_id\";s:1:\"3\";i:1;s:5:\"Venue\";s:18:\"resource_type_name\";s:5:\"Venue\";}}','2024-09-18 14:44:28','2024-09-18 11:41:52'),('22f4227fe6823d0d8bfc86414be8df40',152,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:6:{s:12:\"SAVEDPLACE-1\";s:10:\"m=projects\";s:10:\"SAVEDPLACE\";s:18:\"m=projects&tab=500\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:10:\"ProjIdxTab\";i:500;}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"152\";s:10:\"project_id\";i:0;}user_feedback|a:0:{}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:2:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}}','2021-10-07 17:49:29','2021-10-07 14:49:13'),('23rm6c9cb7pkv5u4345snkuhi6',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:21:13','2016-06-03 04:21:13'),('2qcqvsdbl6rb6c85rc9ec4j5e3',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:52:06','2016-06-03 05:52:06'),('318f535252351d4a0805c636da2ce43f',167,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:8:{s:12:\"SAVEDPLACE-1\";s:37:\"m=companies&a=view&company_id=1&tab=3\";s:10:\"SAVEDPLACE\";s:8:\"m=system\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"0\";s:15:\"CompaniesIdxTab\";s:1:\"0\";s:9:\"CompVwTab\";s:1:\"3\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"167\";s:10:\"project_id\";i:0;}user_feedback|a:6:{i:3;i:3;i:22;i:22;i:15;i:15;i:18;i:18;i:20;i:20;i:21;i:21;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:4:{s:8:\"projects\";a:11:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:7:\"History\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/history/projects_tab.history\";s:6:\"module\";s:7:\"history\";}i:5;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/links/projects_tab.links\";s:6:\"module\";s:5:\"links\";}i:6;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:9;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:10;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:15:\"human_resources\";a:0:{}s:6:\"system\";a:0:{}}user_choosen_feature|N;gqs_tab|s:1:\"0\";','2025-05-07 23:19:09','2025-05-07 18:47:39'),('31lgkbbtjg5qsuc0alv0bj7gq6',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:46:19','2016-06-03 04:46:19'),('42389b8b4c34fb2339c6ed9179d61161',165,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:6:{s:12:\"SAVEDPLACE-1\";s:19:\"m=system&a=viewmods\";s:10:\"SAVEDPLACE\";s:17:\"m=projectdesigner\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:22:\"TaskListShowIncomplete\";i:0;s:12:\"tasks_opened\";a:0:{}}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"165\";s:10:\"project_id\";i:0;}user_feedback|a:0:{}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:4:{s:8:\"projects\";a:11:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:7:\"History\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/history/projects_tab.history\";s:6:\"module\";s:7:\"history\";}i:5;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/links/projects_tab.links\";s:6:\"module\";s:5:\"links\";}i:6;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:9;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:10;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:6:\"system\";a:0:{}s:15:\"projectdesigner\";a:0:{}s:6:\"public\";a:0:{}}','2024-10-23 11:44:20','2024-10-23 09:38:22'),('48k4l6v63q1ucdvcamflrl8of7',138,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:14:{s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:12:\"SAVEDPLACE-1\";s:8:\"m=system\";s:10:\"SAVEDPLACE\";s:19:\"m=system&a=viewmods\";s:10:\"ProjIdxTab\";i:2;s:9:\"ProjVwTab\";s:1:\"0\";s:15:\"RisksIdxProject\";i:1;s:11:\"RisksIdxTab\";i:1;s:16:\"RisksIdxOrderDir\";s:4:\"desc\";s:16:\"addProjWithTasks\";b:0;s:17:\"UsrProjIdxCompany\";s:0:\"\";s:9:\"CompVwTab\";s:1:\"1\";s:10:\"FileIdxTab\";i:0;s:14:\"FileIdxProject\";i:0;}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"138\";s:10:\"project_id\";i:0;}user_feedback|a:9:{i:18;i:18;i:20;i:20;i:16;i:16;i:28;i:28;i:27;i:27;i:11;i:11;i:22;i:22;i:29;i:29;i:30;i:30;}user_feedback_read|a:12:{i:3;s:1:\"3\";i:13;s:2:\"13\";i:5;s:1:\"5\";i:2;s:1:\"2\";i:6;s:1:\"6\";i:4;s:1:\"4\";i:21;s:2:\"21\";i:9;s:1:\"9\";i:12;s:2:\"12\";i:15;s:2:\"15\";i:26;s:2:\"26\";i:14;s:2:\"14\";}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:7:{s:8:\"projects\";a:4:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:68:\"C:\\xampp\\htdocs\\dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:78:\"C:\\xampp\\htdocs\\dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:92:\"C:\\xampp\\htdocs\\dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:64:\"C:\\xampp\\htdocs\\dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}}s:5:\"risks\";a:0:{}s:5:\"admin\";a:1:{s:8:\"viewuser\";a:3:{i:0;a:3:{s:4:\"name\";s:9:\"5LBLCUSTO\";s:4:\"file\";s:89:\"C:\\xampp\\htdocs\\dotproject_plus/modules/monitoringandcontrol/admin_tab.viewuser.5LBLCUSTO\";s:6:\"module\";s:20:\"monitoringandcontrol\";}i:1;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:76:\"C:\\xampp\\htdocs\\dotproject_plus/modules/projects/admin_tab.viewuser.projects\";s:6:\"module\";s:8:\"projects\";}i:2;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:82:\"C:\\xampp\\htdocs\\dotproject_plus/modules/projects/admin_tab.viewuser.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}}s:6:\"system\";a:0:{}s:9:\"companies\";a:3:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:78:\"C:\\xampp\\htdocs\\dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:65:\"C:\\xampp\\htdocs\\dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:82:\"C:\\xampp\\htdocs\\dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}}s:10:\"initiating\";a:0:{}s:5:\"files\";a:0:{}}user_choosen_feature|N;gqs_tab|s:1:\"0\";','2016-05-30 19:57:29','2016-05-30 00:06:45'),('49hfaeenveno225f68d782u365',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:30:59','2016-06-03 05:30:59'),('4eip7a1rdaslcfu481di67k9v0',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:59:41','2016-06-03 04:59:41'),('4jci40htfc41kqqj88kt9ds5o4',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:17:06','2016-06-03 04:17:06'),('4vq07gbhsb7mjrbsc9nmgcgq27',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:17:41','2016-06-03 05:17:41'),('52e244d35d921fec8f69f0d34d5b1b56',174,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:11:{s:12:\"SAVEDPLACE-1\";s:13:\"m=risks&tab=1\";s:10:\"SAVEDPLACE\";s:13:\"m=risks&tab=0\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"1\";s:22:\"TaskListShowIncomplete\";i:0;s:12:\"tasks_opened\";a:0:{}s:16:\"RisksIdxOrderDir\";s:3:\"asc\";s:15:\"RisksIdxOrderBy\";s:16:\"risk_description\";s:11:\"RisksIdxTab\";i:0;}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"174\";s:10:\"project_id\";i:0;}user_feedback|a:6:{i:3;i:3;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:4:{s:8:\"projects\";a:11:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:7:\"History\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/history/projects_tab.history\";s:6:\"module\";s:7:\"history\";}i:5;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/links/projects_tab.links\";s:6:\"module\";s:5:\"links\";}i:6;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:9;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:10;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:15:\"projectdesigner\";a:0:{}s:5:\"risks\";a:0:{}}user_choosen_feature|s:65:\"/modules/dotproject_plus/projects_tab.planning_and_monitoring.php\";gqs_tab|i:1;gantt_arr|a:42:{i:0;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"83\";s:11:\"task_parent\";s:2:\"83\";s:9:\"task_name\";s:33:\"Entrevistar usuários do sistema.\";s:15:\"task_start_date\";s:19:\"2013-02-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-02-15 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:1;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"82\";s:11:\"task_parent\";s:2:\"82\";s:9:\"task_name\";s:23:\"Identificar requisitos.\";s:15:\"task_start_date\";s:19:\"2013-02-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-01 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:2;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"66\";s:11:\"task_parent\";s:2:\"66\";s:9:\"task_name\";s:26:\"Elaborar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-05 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-15 00:00:00\";s:13:\"task_duration\";s:2:\"11\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:3;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"67\";s:11:\"task_parent\";s:2:\"67\";s:9:\"task_name\";s:25:\"Aprovar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:4;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"69\";s:11:\"task_parent\";s:2:\"69\";s:9:\"task_name\";s:42:\"Realizar as contratações para o projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-22 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:5;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"70\";s:11:\"task_parent\";s:2:\"70\";s:9:\"task_name\";s:22:\"Arquivar os contratos.\";s:15:\"task_start_date\";s:19:\"2013-03-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-27 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:6;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"85\";s:11:\"task_parent\";s:2:\"85\";s:9:\"task_name\";s:74:\"Elaborar os protótipos das telas de cadastro de clientes e pedidos (web).\";s:15:\"task_start_date\";s:19:\"2013-04-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_duration\";s:1:\"8\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:7;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"86\";s:11:\"task_parent\";s:2:\"86\";s:9:\"task_name\";s:60:\"Elaborar protótipo da tela de consulta de pedidos (mobile).\";s:15:\"task_start_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:8;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"71\";s:11:\"task_parent\";s:2:\"71\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:9;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"74\";s:11:\"task_parent\";s:2:\"74\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:10;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"84\";s:11:\"task_parent\";s:2:\"84\";s:9:\"task_name\";s:62:\"Modelar os diagramas de caso de uso, classe, sequência, e ER.\";s:15:\"task_start_date\";s:19:\"2013-04-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-25 00:00:00\";s:13:\"task_duration\";s:1:\"9\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:11;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"87\";s:11:\"task_parent\";s:2:\"87\";s:9:\"task_name\";s:49:\"Programar funcionalidade de cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-06 00:00:00\";s:13:\"task_duration\";s:1:\"6\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:12;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"88\";s:11:\"task_parent\";s:2:\"88\";s:9:\"task_name\";s:55:\"Realizar teste de unidade sobre o cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-07 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-09 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:13;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"91\";s:11:\"task_parent\";s:2:\"91\";s:9:\"task_name\";s:73:\"Programar funcionalidade para autenticação de clientes e funcionários.\";s:15:\"task_start_date\";s:19:\"2013-05-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:14;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"92\";s:11:\"task_parent\";s:2:\"92\";s:9:\"task_name\";s:60:\"Realizar testes de unidade sobre a função de autentição.\";s:15:\"task_start_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-14 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:15;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"89\";s:11:\"task_parent\";s:2:\"89\";s:9:\"task_name\";s:48:\"Programar funcionalidade de cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-16 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:16;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"90\";s:11:\"task_parent\";s:2:\"90\";s:9:\"task_name\";s:55:\"Realizar testes de unidade sobre o cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:17;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"72\";s:11:\"task_parent\";s:2:\"72\";s:9:\"task_name\";s:55:\"Realizar reunião de acompanhamento (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:18;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"75\";s:11:\"task_parent\";s:2:\"75\";s:9:\"task_name\";s:64:\"Elaborar relatório do desempenho do projeto (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:19;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"93\";s:11:\"task_parent\";s:2:\"93\";s:9:\"task_name\";s:50:\"Programar telas de cadastro de clientes e pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-07 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:20;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"94\";s:11:\"task_parent\";s:2:\"94\";s:9:\"task_name\";s:77:\"Realizar teste de sistema sobre o cadastro de clientes e cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-11 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:21;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"95\";s:11:\"task_parent\";s:2:\"95\";s:9:\"task_name\";s:52:\"Programar tela web de listagem de pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-14 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:22;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"96\";s:11:\"task_parent\";s:2:\"96\";s:9:\"task_name\";s:53:\"Realizar teste de sistema sobre os pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:23;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"97\";s:11:\"task_parent\";s:2:\"97\";s:9:\"task_name\";s:61:\"Integrar função de consulta de pedidos na tela para mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-27 00:00:00\";s:13:\"task_duration\";s:1:\"7\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:24;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"99\";s:11:\"task_parent\";s:2:\"99\";s:9:\"task_name\";s:96:\"Realizar teste de integração entre a tela para mobile e as funções para consulta de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-28 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-29 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:25;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"98\";s:11:\"task_parent\";s:2:\"98\";s:9:\"task_name\";s:64:\"Realizar teste de sistema sobre a consulta de pedidos em mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-30 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-01 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:26;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"77\";s:11:\"task_parent\";s:2:\"77\";s:9:\"task_name\";s:33:\"Inspecionar qualidade do produto.\";s:15:\"task_start_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:27;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"100\";s:11:\"task_parent\";s:3:\"100\";s:9:\"task_name\";s:49:\"Preparar o material para ministrar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-12 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:28;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"101\";s:11:\"task_parent\";s:3:\"101\";s:9:\"task_name\";s:23:\"Realizar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-18 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:29;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"73\";s:11:\"task_parent\";s:2:\"73\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:30;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"76\";s:11:\"task_parent\";s:2:\"76\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:31;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"104\";s:11:\"task_parent\";s:3:\"104\";s:9:\"task_name\";s:41:\"Coletar os dispositivos dos entregadores.\";s:15:\"task_start_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:32;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"105\";s:11:\"task_parent\";s:3:\"105\";s:9:\"task_name\";s:31:\"Instalar apps nos dispositivos.\";s:15:\"task_start_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:33;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"103\";s:11:\"task_parent\";s:3:\"103\";s:9:\"task_name\";s:68:\"Instalar o sistema no servidor produtivo e nos dispositivos móveis.\";s:15:\"task_start_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:34;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"106\";s:11:\"task_parent\";s:3:\"106\";s:9:\"task_name\";s:41:\"Integrar módulo web ao site da pizzaria.\";s:15:\"task_start_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:35;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"102\";s:11:\"task_parent\";s:3:\"102\";s:9:\"task_name\";s:47:\"Realizar o teste de aceite junto aos usuários.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:36;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"68\";s:11:\"task_parent\";s:2:\"68\";s:9:\"task_name\";s:32:\"Auditar a qualidade do processo.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:37;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"78\";s:11:\"task_parent\";s:2:\"78\";s:9:\"task_name\";s:31:\"Obter aceite formal do cliente.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:38;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"79\";s:11:\"task_parent\";s:2:\"79\";s:9:\"task_name\";s:32:\"Discutir as lições aprendidas.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:39;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"80\";s:11:\"task_parent\";s:2:\"80\";s:9:\"task_name\";s:57:\"Registrar as lições aprendidas na base de conhecimento.\";s:15:\"task_start_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:40;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"81\";s:11:\"task_parent\";s:2:\"81\";s:9:\"task_name\";s:35:\"Realizar a reunião de post mortem.\";s:15:\"task_start_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:41;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"128\";s:11:\"task_parent\";s:3:\"128\";s:9:\"task_name\";s:24:\"TESTE DE CADASTRO (2022)\";s:15:\"task_start_date\";s:19:\"2021-12-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2021-12-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}}','2025-10-10 19:50:37','2025-10-10 16:43:35'),('58eca3697cc63d40cd29a0f1bc2962c4',163,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:10:{s:12:\"SAVEDPLACE-1\";s:36:\"m=projects&a=view&project_id=2&tab=0\";s:10:\"SAVEDPLACE\";s:36:\"m=projects&a=view&project_id=2&tab=1\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:10:\"ProjIdxTab\";i:2;s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"1\";s:15:\"RisksIdxProject\";i:2;s:11:\"RisksIdxTab\";i:1;s:16:\"RisksIdxOrderDir\";s:4:\"desc\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"163\";s:10:\"project_id\";i:0;}user_feedback|a:20:{i:3;i:3;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;i:15;i:15;i:18;i:18;i:20;i:20;i:21;i:21;i:28;i:28;i:27;i:27;i:19;i:19;i:23;i:23;i:25;i:25;i:29;i:29;i:30;i:30;i:31;i:31;i:32;i:32;i:33;i:33;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:4:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:6:\"system\";a:0:{}s:15:\"dotproject_plus\";a:0:{}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}}user_choosen_feature|N;gqs_tab|s:1:\"1\";user_choosen_feature_initiating|s:31:\"/modules/initiating/addedit.php\";gantt_arr|a:42:{i:0;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"83\";s:11:\"task_parent\";s:2:\"83\";s:9:\"task_name\";s:33:\"Entrevistar usuários do sistema.\";s:15:\"task_start_date\";s:19:\"2013-02-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-02-15 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:1;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"82\";s:11:\"task_parent\";s:2:\"82\";s:9:\"task_name\";s:23:\"Identificar requisitos.\";s:15:\"task_start_date\";s:19:\"2013-02-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-01 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:2;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"66\";s:11:\"task_parent\";s:2:\"66\";s:9:\"task_name\";s:26:\"Elaborar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-05 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-15 00:00:00\";s:13:\"task_duration\";s:2:\"11\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:3;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"67\";s:11:\"task_parent\";s:2:\"67\";s:9:\"task_name\";s:25:\"Aprovar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:4;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"69\";s:11:\"task_parent\";s:2:\"69\";s:9:\"task_name\";s:42:\"Realizar as contratações para o projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-22 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:5;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"70\";s:11:\"task_parent\";s:2:\"70\";s:9:\"task_name\";s:22:\"Arquivar os contratos.\";s:15:\"task_start_date\";s:19:\"2013-03-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-27 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:6;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"85\";s:11:\"task_parent\";s:2:\"85\";s:9:\"task_name\";s:74:\"Elaborar os protótipos das telas de cadastro de clientes e pedidos (web).\";s:15:\"task_start_date\";s:19:\"2013-04-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_duration\";s:1:\"8\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:7;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"86\";s:11:\"task_parent\";s:2:\"86\";s:9:\"task_name\";s:60:\"Elaborar protótipo da tela de consulta de pedidos (mobile).\";s:15:\"task_start_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:8;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"71\";s:11:\"task_parent\";s:2:\"71\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:9;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"74\";s:11:\"task_parent\";s:2:\"74\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:10;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"84\";s:11:\"task_parent\";s:2:\"84\";s:9:\"task_name\";s:62:\"Modelar os diagramas de caso de uso, classe, sequência, e ER.\";s:15:\"task_start_date\";s:19:\"2013-04-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-25 00:00:00\";s:13:\"task_duration\";s:1:\"9\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:11;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"87\";s:11:\"task_parent\";s:2:\"87\";s:9:\"task_name\";s:49:\"Programar funcionalidade de cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-06 00:00:00\";s:13:\"task_duration\";s:1:\"6\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:12;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"88\";s:11:\"task_parent\";s:2:\"88\";s:9:\"task_name\";s:55:\"Realizar teste de unidade sobre o cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-07 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-09 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:13;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"91\";s:11:\"task_parent\";s:2:\"91\";s:9:\"task_name\";s:73:\"Programar funcionalidade para autenticação de clientes e funcionários.\";s:15:\"task_start_date\";s:19:\"2013-05-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:14;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"92\";s:11:\"task_parent\";s:2:\"92\";s:9:\"task_name\";s:60:\"Realizar testes de unidade sobre a função de autentição.\";s:15:\"task_start_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-14 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:15;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"89\";s:11:\"task_parent\";s:2:\"89\";s:9:\"task_name\";s:48:\"Programar funcionalidade de cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-16 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:16;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"90\";s:11:\"task_parent\";s:2:\"90\";s:9:\"task_name\";s:55:\"Realizar testes de unidade sobre o cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:17;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"72\";s:11:\"task_parent\";s:2:\"72\";s:9:\"task_name\";s:55:\"Realizar reunião de acompanhamento (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:18;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"75\";s:11:\"task_parent\";s:2:\"75\";s:9:\"task_name\";s:64:\"Elaborar relatório do desempenho do projeto (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:19;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"93\";s:11:\"task_parent\";s:2:\"93\";s:9:\"task_name\";s:50:\"Programar telas de cadastro de clientes e pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-07 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:20;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"94\";s:11:\"task_parent\";s:2:\"94\";s:9:\"task_name\";s:77:\"Realizar teste de sistema sobre o cadastro de clientes e cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-11 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:21;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"95\";s:11:\"task_parent\";s:2:\"95\";s:9:\"task_name\";s:52:\"Programar tela web de listagem de pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-14 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:22;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"96\";s:11:\"task_parent\";s:2:\"96\";s:9:\"task_name\";s:53:\"Realizar teste de sistema sobre os pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:23;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"97\";s:11:\"task_parent\";s:2:\"97\";s:9:\"task_name\";s:61:\"Integrar função de consulta de pedidos na tela para mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-27 00:00:00\";s:13:\"task_duration\";s:1:\"7\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:24;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"99\";s:11:\"task_parent\";s:2:\"99\";s:9:\"task_name\";s:96:\"Realizar teste de integração entre a tela para mobile e as funções para consulta de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-28 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-29 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:25;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"98\";s:11:\"task_parent\";s:2:\"98\";s:9:\"task_name\";s:64:\"Realizar teste de sistema sobre a consulta de pedidos em mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-30 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-01 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:26;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"77\";s:11:\"task_parent\";s:2:\"77\";s:9:\"task_name\";s:33:\"Inspecionar qualidade do produto.\";s:15:\"task_start_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:27;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"100\";s:11:\"task_parent\";s:3:\"100\";s:9:\"task_name\";s:49:\"Preparar o material para ministrar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-12 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:28;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"101\";s:11:\"task_parent\";s:3:\"101\";s:9:\"task_name\";s:23:\"Realizar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-18 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:29;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"73\";s:11:\"task_parent\";s:2:\"73\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:30;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"76\";s:11:\"task_parent\";s:2:\"76\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:31;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"104\";s:11:\"task_parent\";s:3:\"104\";s:9:\"task_name\";s:41:\"Coletar os dispositivos dos entregadores.\";s:15:\"task_start_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:32;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"105\";s:11:\"task_parent\";s:3:\"105\";s:9:\"task_name\";s:31:\"Instalar apps nos dispositivos.\";s:15:\"task_start_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:33;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"103\";s:11:\"task_parent\";s:3:\"103\";s:9:\"task_name\";s:68:\"Instalar o sistema no servidor produtivo e nos dispositivos móveis.\";s:15:\"task_start_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:34;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"106\";s:11:\"task_parent\";s:3:\"106\";s:9:\"task_name\";s:41:\"Integrar módulo web ao site da pizzaria.\";s:15:\"task_start_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:35;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"79\";s:11:\"task_parent\";s:2:\"79\";s:9:\"task_name\";s:32:\"Discutir as lições aprendidas.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:36;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"102\";s:11:\"task_parent\";s:3:\"102\";s:9:\"task_name\";s:47:\"Realizar o teste de aceite junto aos usuários.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:37;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"68\";s:11:\"task_parent\";s:2:\"68\";s:9:\"task_name\";s:32:\"Auditar a qualidade do processo.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:38;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"78\";s:11:\"task_parent\";s:2:\"78\";s:9:\"task_name\";s:31:\"Obter aceite formal do cliente.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:39;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"80\";s:11:\"task_parent\";s:2:\"80\";s:9:\"task_name\";s:57:\"Registrar as lições aprendidas na base de conhecimento.\";s:15:\"task_start_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:40;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"81\";s:11:\"task_parent\";s:2:\"81\";s:9:\"task_name\";s:35:\"Realizar a reunião de post mortem.\";s:15:\"task_start_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:41;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"128\";s:11:\"task_parent\";s:3:\"128\";s:9:\"task_name\";s:24:\"TESTE DE CADASTRO (2022)\";s:15:\"task_start_date\";s:19:\"2021-12-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2021-12-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}}','2024-07-02 16:53:36','2024-07-02 13:10:01'),('6j4v3lfmb0uq6oouqivcthmo47',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:32:52','2016-06-03 05:32:52'),('74e0h3026ickddkekaa682hfg3',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 10:01:57','2016-06-03 12:01:57'),('7700cb036ae18d3609360b10bd08a75e',143,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:9:{s:12:\"SAVEDPLACE-1\";s:10:\"m=projects\";s:10:\"SAVEDPLACE\";s:11:\"m=companies\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:13:\"CalIdxCompany\";s:0:\"\";s:12:\"CalIdxFilter\";s:2:\"my\";s:13:\"CalDayViewTab\";s:1:\"0\";s:9:\"CompVwTab\";s:1:\"3\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"143\";s:10:\"project_id\";i:0;}user_feedback|a:1:{i:22;i:22;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:3:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:8:\"calendar\";a:1:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:63:\"/var/www/dotproject_plus/modules/projects/calendar_tab.projects\";s:6:\"module\";s:8:\"projects\";}}}','2020-11-10 00:01:19','2020-11-09 21:59:57'),('7813d409e6683ecaa3f2e440befa1af8',166,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:6:{s:12:\"SAVEDPLACE-1\";s:88:\"a=view&m=projects&project_id=2&tab=1&targetScreenOnProject=/modules/costs/view_costs.php\";s:10:\"SAVEDPLACE\";s:30:\"m=projects&a=view&project_id=2\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"1\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"166\";s:10:\"project_id\";i:0;}user_feedback|a:4:{i:15;i:15;i:18;i:18;i:20;i:20;i:21;i:21;}user_feedback_read|a:1:{i:3;s:1:\"3\";}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:3:{s:8:\"projects\";a:11:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:7:\"History\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/history/projects_tab.history\";s:6:\"module\";s:7:\"history\";}i:5;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/links/projects_tab.links\";s:6:\"module\";s:5:\"links\";}i:6;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:9;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:10;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:6:\"system\";a:0:{}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}}user_choosen_feature|s:65:\"/modules/dotproject_plus/projects_tab.planning_and_monitoring.php\";gqs_tab|i:1;','2025-02-24 23:14:16','2025-02-24 20:05:54'),('7kti2uvavc24o6inj76jg7s390',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:15:53','2016-06-03 05:15:53'),('87e8ec61dd389fb85e413b37c3cedb0a',160,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:9:{s:12:\"SAVEDPLACE-1\";s:30:\"m=projects&a=view&project_id=2\";s:10:\"SAVEDPLACE\";s:88:\"a=view&m=projects&project_id=2&tab=1&targetScreenOnProject=/modules/costs/view_costs.php\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"1\";s:9:\"CompVwTab\";s:1:\"0\";s:10:\"ProjIdxTab\";i:500;s:10:\"UserIdxTab\";s:1:\"1\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"160\";s:10:\"project_id\";i:0;}user_feedback|a:11:{i:3;i:3;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;i:15;i:15;i:18;i:18;i:20;i:20;i:21;i:21;i:17;i:17;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:5:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:5:\"admin\";a:1:{s:8:\"viewuser\";a:3:{i:0;a:3:{s:4:\"name\";s:9:\"5LBLCUSTO\";s:4:\"file\";s:82:\"/var/www/dotproject_plus/modules/monitoringandcontrol/admin_tab.viewuser.5LBLCUSTO\";s:6:\"module\";s:20:\"monitoringandcontrol\";}i:1;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/projects/admin_tab.viewuser.projects\";s:6:\"module\";s:8:\"projects\";}i:2;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/admin_tab.viewuser.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}}s:6:\"system\";a:0:{}s:15:\"human_resources\";a:0:{}}user_choosen_feature|s:29:\"/modules/costs/view_costs.php\";gqs_tab|s:1:\"1\";gantt_arr|a:41:{i:0;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"83\";s:11:\"task_parent\";s:2:\"83\";s:9:\"task_name\";s:33:\"Entrevistar usuários do sistema.\";s:15:\"task_start_date\";s:19:\"2013-02-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-02-15 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:1;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"82\";s:11:\"task_parent\";s:2:\"82\";s:9:\"task_name\";s:23:\"Identificar requisitos.\";s:15:\"task_start_date\";s:19:\"2013-02-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-01 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:2;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"66\";s:11:\"task_parent\";s:2:\"66\";s:9:\"task_name\";s:26:\"Elaborar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-05 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-15 00:00:00\";s:13:\"task_duration\";s:2:\"11\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:3;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"67\";s:11:\"task_parent\";s:2:\"67\";s:9:\"task_name\";s:25:\"Aprovar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:4;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"69\";s:11:\"task_parent\";s:2:\"69\";s:9:\"task_name\";s:42:\"Realizar as contratações para o projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-22 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:5;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"70\";s:11:\"task_parent\";s:2:\"70\";s:9:\"task_name\";s:22:\"Arquivar os contratos.\";s:15:\"task_start_date\";s:19:\"2013-03-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-27 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:6;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"85\";s:11:\"task_parent\";s:2:\"85\";s:9:\"task_name\";s:74:\"Elaborar os protótipos das telas de cadastro de clientes e pedidos (web).\";s:15:\"task_start_date\";s:19:\"2013-04-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_duration\";s:1:\"8\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:7;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"86\";s:11:\"task_parent\";s:2:\"86\";s:9:\"task_name\";s:60:\"Elaborar protótipo da tela de consulta de pedidos (mobile).\";s:15:\"task_start_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:8;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"71\";s:11:\"task_parent\";s:2:\"71\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:9;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"74\";s:11:\"task_parent\";s:2:\"74\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:10;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"84\";s:11:\"task_parent\";s:2:\"84\";s:9:\"task_name\";s:62:\"Modelar os diagramas de caso de uso, classe, sequência, e ER.\";s:15:\"task_start_date\";s:19:\"2013-04-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-25 00:00:00\";s:13:\"task_duration\";s:1:\"9\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:11;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"87\";s:11:\"task_parent\";s:2:\"87\";s:9:\"task_name\";s:49:\"Programar funcionalidade de cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-06 00:00:00\";s:13:\"task_duration\";s:1:\"6\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:12;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"88\";s:11:\"task_parent\";s:2:\"88\";s:9:\"task_name\";s:55:\"Realizar teste de unidade sobre o cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-07 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-09 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:13;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"91\";s:11:\"task_parent\";s:2:\"91\";s:9:\"task_name\";s:73:\"Programar funcionalidade para autenticação de clientes e funcionários.\";s:15:\"task_start_date\";s:19:\"2013-05-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:14;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"92\";s:11:\"task_parent\";s:2:\"92\";s:9:\"task_name\";s:60:\"Realizar testes de unidade sobre a função de autentição.\";s:15:\"task_start_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-14 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:15;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"89\";s:11:\"task_parent\";s:2:\"89\";s:9:\"task_name\";s:48:\"Programar funcionalidade de cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-16 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:16;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"90\";s:11:\"task_parent\";s:2:\"90\";s:9:\"task_name\";s:55:\"Realizar testes de unidade sobre o cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:17;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"72\";s:11:\"task_parent\";s:2:\"72\";s:9:\"task_name\";s:55:\"Realizar reunião de acompanhamento (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:18;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"75\";s:11:\"task_parent\";s:2:\"75\";s:9:\"task_name\";s:64:\"Elaborar relatório do desempenho do projeto (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:19;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"93\";s:11:\"task_parent\";s:2:\"93\";s:9:\"task_name\";s:50:\"Programar telas de cadastro de clientes e pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-07 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:20;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"94\";s:11:\"task_parent\";s:2:\"94\";s:9:\"task_name\";s:77:\"Realizar teste de sistema sobre o cadastro de clientes e cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-11 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:21;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"95\";s:11:\"task_parent\";s:2:\"95\";s:9:\"task_name\";s:52:\"Programar tela web de listagem de pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-14 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:22;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"96\";s:11:\"task_parent\";s:2:\"96\";s:9:\"task_name\";s:53:\"Realizar teste de sistema sobre os pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:23;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"97\";s:11:\"task_parent\";s:2:\"97\";s:9:\"task_name\";s:61:\"Integrar função de consulta de pedidos na tela para mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-27 00:00:00\";s:13:\"task_duration\";s:1:\"7\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:24;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"99\";s:11:\"task_parent\";s:2:\"99\";s:9:\"task_name\";s:96:\"Realizar teste de integração entre a tela para mobile e as funções para consulta de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-28 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-29 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:25;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"98\";s:11:\"task_parent\";s:2:\"98\";s:9:\"task_name\";s:64:\"Realizar teste de sistema sobre a consulta de pedidos em mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-30 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-01 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:26;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"77\";s:11:\"task_parent\";s:2:\"77\";s:9:\"task_name\";s:33:\"Inspecionar qualidade do produto.\";s:15:\"task_start_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:27;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"100\";s:11:\"task_parent\";s:3:\"100\";s:9:\"task_name\";s:49:\"Preparar o material para ministrar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-12 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:28;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"101\";s:11:\"task_parent\";s:3:\"101\";s:9:\"task_name\";s:23:\"Realizar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-18 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:29;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"73\";s:11:\"task_parent\";s:2:\"73\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:30;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"76\";s:11:\"task_parent\";s:2:\"76\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:31;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"104\";s:11:\"task_parent\";s:3:\"104\";s:9:\"task_name\";s:41:\"Coletar os dispositivos dos entregadores.\";s:15:\"task_start_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:32;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"105\";s:11:\"task_parent\";s:3:\"105\";s:9:\"task_name\";s:31:\"Instalar apps nos dispositivos.\";s:15:\"task_start_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:33;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"103\";s:11:\"task_parent\";s:3:\"103\";s:9:\"task_name\";s:68:\"Instalar o sistema no servidor produtivo e nos dispositivos móveis.\";s:15:\"task_start_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:34;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"106\";s:11:\"task_parent\";s:3:\"106\";s:9:\"task_name\";s:41:\"Integrar módulo web ao site da pizzaria.\";s:15:\"task_start_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:35;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"102\";s:11:\"task_parent\";s:3:\"102\";s:9:\"task_name\";s:47:\"Realizar o teste de aceite junto aos usuários.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:36;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"68\";s:11:\"task_parent\";s:2:\"68\";s:9:\"task_name\";s:32:\"Auditar a qualidade do processo.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:37;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"78\";s:11:\"task_parent\";s:2:\"78\";s:9:\"task_name\";s:31:\"Obter aceite formal do cliente.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:38;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"79\";s:11:\"task_parent\";s:2:\"79\";s:9:\"task_name\";s:32:\"Discutir as lições aprendidas.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:39;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"80\";s:11:\"task_parent\";s:2:\"80\";s:9:\"task_name\";s:57:\"Registrar as lições aprendidas na base de conhecimento.\";s:15:\"task_start_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:40;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"81\";s:11:\"task_parent\";s:2:\"81\";s:9:\"task_name\";s:35:\"Realizar a reunião de post mortem.\";s:15:\"task_start_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}}','2021-12-10 01:41:38','2021-12-09 23:19:44'),('8bahrb2r917c6b44pn3op9m551',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:14:40','2016-06-03 04:14:40'),('8koiefh3kt7lo7i7n1k35sg437',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:40:26','2016-06-03 05:40:26'),('8lsqpfacifcqe4ksdd0l7g6rk4',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:49:27','2016-06-03 04:49:27'),('8p4kk52dduvpr3vi8j4knta9j7',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:44:35','2016-06-03 05:44:35'),('8rsg37n3v8t9rr59qv3kahv221',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:32:16','2016-06-03 05:32:16'),('8tdfm6gkg6o1il0spppiggtej4',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:51:09','2016-06-03 05:51:09'),('9ss0ou1ib6a3p9run355hfi1o7',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:37:45','2016-06-03 05:37:45'),('ad4d622dfcb5c90d9fb39420e1fb0a83',159,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:12:{s:12:\"SAVEDPLACE-1\";s:36:\"m=projects&a=view&project_id=2&tab=0\";s:10:\"SAVEDPLACE\";s:36:\"a=view&m=projects&project_id=2&tab=0\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:17:\"ScopePlanIndexTab\";i:1;s:10:\"ProjIdxTab\";i:500;s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"0\";s:9:\"CompVwTab\";s:1:\"0\";s:15:\"RisksIdxProject\";i:8;s:11:\"RisksIdxTab\";i:1;s:16:\"RisksIdxOrderDir\";s:4:\"desc\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"159\";s:10:\"project_id\";i:0;}user_feedback|a:19:{i:3;i:3;i:4;i:4;i:5;i:5;i:6;i:6;i:12;i:12;i:31;i:31;i:32;i:32;i:33;i:33;i:15;i:15;i:18;i:18;i:20;i:20;i:21;i:21;i:28;i:28;i:19;i:19;i:23;i:23;i:25;i:25;i:24;i:24;i:29;i:29;i:30;i:30;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:8:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:6:\"system\";a:0:{}s:13:\"scopeplanning\";a:0:{}s:6:\"public\";a:0:{}s:12:\"timeplanning\";a:0:{}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:5:\"risks\";a:0:{}s:13:\"communication\";a:0:{}}user_choosen_feature|N;gqs_tab|s:1:\"0\";gantt_arr|a:41:{i:0;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"83\";s:11:\"task_parent\";s:2:\"83\";s:9:\"task_name\";s:32:\"Entrevistar usu\�rios do sistema.\";s:15:\"task_start_date\";s:19:\"2013-02-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-02-15 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:1;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"82\";s:11:\"task_parent\";s:2:\"82\";s:9:\"task_name\";s:23:\"Identificar requisitos.\";s:15:\"task_start_date\";s:19:\"2013-02-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-01 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:2;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"66\";s:11:\"task_parent\";s:2:\"66\";s:9:\"task_name\";s:26:\"Elaborar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-05 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-15 00:00:00\";s:13:\"task_duration\";s:2:\"11\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:3;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"67\";s:11:\"task_parent\";s:2:\"67\";s:9:\"task_name\";s:25:\"Aprovar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:4;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"69\";s:11:\"task_parent\";s:2:\"69\";s:9:\"task_name\";s:40:\"Realizar as contrata\��es para o projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-22 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:5;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"70\";s:11:\"task_parent\";s:2:\"70\";s:9:\"task_name\";s:22:\"Arquivar os contratos.\";s:15:\"task_start_date\";s:19:\"2013-03-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-27 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:6;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"85\";s:11:\"task_parent\";s:2:\"85\";s:9:\"task_name\";s:73:\"Elaborar os prot�tipos das telas de cadastro de clientes e pedidos (web).\";s:15:\"task_start_date\";s:19:\"2013-04-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_duration\";s:1:\"8\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:7;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"86\";s:11:\"task_parent\";s:2:\"86\";s:9:\"task_name\";s:59:\"Elaborar prot�tipo da tela de consulta de pedidos (mobile).\";s:15:\"task_start_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:8;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"71\";s:11:\"task_parent\";s:2:\"71\";s:9:\"task_name\";s:55:\"Realizar reuni\�o de acompanhamento (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:9;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"74\";s:11:\"task_parent\";s:2:\"74\";s:9:\"task_name\";s:64:\"Elaborar relat�rio do desempenho do projeto (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:10;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"84\";s:11:\"task_parent\";s:2:\"84\";s:9:\"task_name\";s:61:\"Modelar os diagramas de caso de uso, classe, sequ\�ncia, e ER.\";s:15:\"task_start_date\";s:19:\"2013-04-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-25 00:00:00\";s:13:\"task_duration\";s:1:\"9\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:11;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"87\";s:11:\"task_parent\";s:2:\"87\";s:9:\"task_name\";s:49:\"Programar funcionalidade de cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-06 00:00:00\";s:13:\"task_duration\";s:1:\"6\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:12;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"88\";s:11:\"task_parent\";s:2:\"88\";s:9:\"task_name\";s:55:\"Realizar teste de unidade sobre o cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-07 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-09 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:13;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"91\";s:11:\"task_parent\";s:2:\"91\";s:9:\"task_name\";s:70:\"Programar funcionalidade para autentica\�\�o de clientes e funcion\�rios.\";s:15:\"task_start_date\";s:19:\"2013-05-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:14;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"92\";s:11:\"task_parent\";s:2:\"92\";s:9:\"task_name\";s:56:\"Realizar testes de unidade sobre a fun\�\�o de autenti\�\�o.\";s:15:\"task_start_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-14 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:15;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"89\";s:11:\"task_parent\";s:2:\"89\";s:9:\"task_name\";s:48:\"Programar funcionalidade de cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-16 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:16;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"90\";s:11:\"task_parent\";s:2:\"90\";s:9:\"task_name\";s:55:\"Realizar testes de unidade sobre o cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:17;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"72\";s:11:\"task_parent\";s:2:\"72\";s:9:\"task_name\";s:54:\"Realizar reuni\�o de acompanhamento (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:18;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"75\";s:11:\"task_parent\";s:2:\"75\";s:9:\"task_name\";s:63:\"Elaborar relat�rio do desempenho do projeto (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:19;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"93\";s:11:\"task_parent\";s:2:\"93\";s:9:\"task_name\";s:50:\"Programar telas de cadastro de clientes e pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-07 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:20;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"94\";s:11:\"task_parent\";s:2:\"94\";s:9:\"task_name\";s:77:\"Realizar teste de sistema sobre o cadastro de clientes e cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-11 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:21;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"95\";s:11:\"task_parent\";s:2:\"95\";s:9:\"task_name\";s:52:\"Programar tela web de listagem de pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-14 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:22;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"96\";s:11:\"task_parent\";s:2:\"96\";s:9:\"task_name\";s:53:\"Realizar teste de sistema sobre os pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:23;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"97\";s:11:\"task_parent\";s:2:\"97\";s:9:\"task_name\";s:59:\"Integrar fun\�\�o de consulta de pedidos na tela para mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-27 00:00:00\";s:13:\"task_duration\";s:1:\"7\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:24;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"99\";s:11:\"task_parent\";s:2:\"99\";s:9:\"task_name\";s:92:\"Realizar teste de integra\�\�o entre a tela para mobile e as fun\��es para consulta de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-28 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-29 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:25;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"98\";s:11:\"task_parent\";s:2:\"98\";s:9:\"task_name\";s:64:\"Realizar teste de sistema sobre a consulta de pedidos em mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-30 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-01 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:26;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"77\";s:11:\"task_parent\";s:2:\"77\";s:9:\"task_name\";s:33:\"Inspecionar qualidade do produto.\";s:15:\"task_start_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:27;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"100\";s:11:\"task_parent\";s:3:\"100\";s:9:\"task_name\";s:49:\"Preparar o material para ministrar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-12 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:28;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"101\";s:11:\"task_parent\";s:3:\"101\";s:9:\"task_name\";s:23:\"Realizar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-18 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:29;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"73\";s:11:\"task_parent\";s:2:\"73\";s:9:\"task_name\";s:55:\"Realizar reuni\�o de acompanhamento (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:30;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"76\";s:11:\"task_parent\";s:2:\"76\";s:9:\"task_name\";s:64:\"Elaborar relat�rio do desempenho do projeto (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:31;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"104\";s:11:\"task_parent\";s:3:\"104\";s:9:\"task_name\";s:41:\"Coletar os dispositivos dos entregadores.\";s:15:\"task_start_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:32;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"105\";s:11:\"task_parent\";s:3:\"105\";s:9:\"task_name\";s:31:\"Instalar apps nos dispositivos.\";s:15:\"task_start_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:33;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"103\";s:11:\"task_parent\";s:3:\"103\";s:9:\"task_name\";s:67:\"Instalar o sistema no servidor produtivo e nos dispositivos m�veis.\";s:15:\"task_start_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:34;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"106\";s:11:\"task_parent\";s:3:\"106\";s:9:\"task_name\";s:40:\"Integrar m�dulo web ao site da pizzaria.\";s:15:\"task_start_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:35;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"102\";s:11:\"task_parent\";s:3:\"102\";s:9:\"task_name\";s:46:\"Realizar o teste de aceite junto aos usu\�rios.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:36;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"68\";s:11:\"task_parent\";s:2:\"68\";s:9:\"task_name\";s:32:\"Auditar a qualidade do processo.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:37;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"78\";s:11:\"task_parent\";s:2:\"78\";s:9:\"task_name\";s:31:\"Obter aceite formal do cliente.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:38;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"79\";s:11:\"task_parent\";s:2:\"79\";s:9:\"task_name\";s:30:\"Discutir as li\��es aprendidas.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:39;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"80\";s:11:\"task_parent\";s:2:\"80\";s:9:\"task_name\";s:55:\"Registrar as li\��es aprendidas na base de conhecimento.\";s:15:\"task_start_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:40;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"81\";s:11:\"task_parent\";s:2:\"81\";s:9:\"task_name\";s:34:\"Realizar a reuni\�o de post mortem.\";s:15:\"task_start_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}}user_choosen_feature_initiating|s:31:\"/modules/initiating/addedit.php\";','2021-12-10 00:13:30','2021-12-09 20:10:34'),('aug1gf73n1rcjt7kq7lq883255',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:23:11','2016-06-03 04:23:11'),('av70ouvfjngtl6tk2226dscmd1',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:47:43','2016-06-03 05:47:43'),('b1cc590df404a064f63f7deb663faaaa',162,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:6:{s:12:\"SAVEDPLACE-1\";s:122:\"a=view&m=projects&project_id=2&tab=1&targetScreenOnProject=/modules/timeplanning/view/acquisition/acquisition_planning.php\";s:10:\"SAVEDPLACE\";s:122:\"a=view&m=projects&project_id=2&tab=1&targetScreenOnProject=/modules/timeplanning/view/quality/project_quality_planning.php\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:9:\"ProjVwTab\";s:1:\"1\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"162\";s:10:\"project_id\";i:0;}user_feedback|a:9:{i:3;i:3;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;i:29;i:29;i:30;i:30;i:19;i:19;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:2:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}}user_choosen_feature|s:63:\"/modules/timeplanning/view/quality/project_quality_planning.php\";gqs_tab|s:1:\"1\";','2023-06-15 02:55:30','2023-06-14 23:52:39'),('b77fs5dq5d8dp9tbvo24u2grf0',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:27:00','2016-06-03 04:27:00'),('bee187be2aa83217d9ce02b742fc95c2',151,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:7:{s:12:\"SAVEDPLACE-1\";s:36:\"m=projects&a=view&project_id=2&tab=2\";s:10:\"SAVEDPLACE\";s:36:\"m=projects&a=view&project_id=2&tab=1\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:15:\"owner_filter_id\";i:-1;s:9:\"CompVwTab\";s:1:\"0\";s:9:\"ProjVwTab\";s:1:\"1\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"151\";s:10:\"project_id\";i:0;}user_feedback|a:7:{i:22;i:22;i:3;i:3;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:2:{s:8:\"projects\";a:9:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:5;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:6;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}}user_choosen_feature|N;gqs_tab|s:1:\"1\";','2021-02-10 23:13:59','2021-02-10 21:10:31'),('cd9fdli5orj7hbm1df0m2gtgj7',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:53:14','2016-06-03 05:53:14'),('emqoimqhrg2cl97oi9ob1ore91',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:20:22','2016-06-03 04:20:22'),('eqq6nlb7ppmrvd7nii8q3cbdb1',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:53:29','2016-06-03 04:53:29'),('f47v1vmk8tgu4skooledvueao5',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:54:02','2016-06-03 05:54:02'),('fbe2d503609de8dd01a695d2936d470c',168,_binary 'LANGUAGES|a:6:{s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:17:{s:12:\"SAVEDPLACE-1\";s:21:\"m=scopeplanning&tab=2\";s:10:\"SAVEDPLACE\";s:21:\"m=scopeplanning&tab=1\";s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:10:\"UserIdxTab\";s:1:\"0\";s:15:\"owner_filter_id\";i:-1;s:22:\"TaskListShowIncomplete\";i:0;s:12:\"tasks_opened\";a:0:{}s:15:\"ResourcesIdxTab\";s:1:\"0\";s:9:\"ProjVwTab\";s:1:\"2\";s:15:\"RisksIdxProject\";i:2;s:11:\"RisksIdxTab\";i:1;s:16:\"RisksIdxOrderDir\";s:4:\"desc\";s:13:\"CalIdxCompany\";s:0:\"\";s:12:\"CalIdxFilter\";s:2:\"my\";s:13:\"CalDayViewTab\";s:1:\"0\";s:17:\"ScopePlanIndexTab\";i:1;}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"168\";s:10:\"project_id\";i:0;}user_feedback|a:20:{i:3;i:3;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;i:19;i:19;i:23;i:23;i:25;i:25;i:29;i:29;i:30;i:30;i:31;i:31;i:32;i:32;i:33;i:33;i:15;i:15;i:18;i:18;i:20;i:20;i:21;i:21;i:28;i:28;i:27;i:27;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:12:{s:8:\"projects\";a:11:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:85:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}i:4;a:3:{s:4:\"name\";s:7:\"History\";s:4:\"file\";s:61:\"/var/www/dotproject_plus/modules/history/projects_tab.history\";s:6:\"module\";s:7:\"history\";}i:5;a:3:{s:4:\"name\";s:5:\"Links\";s:4:\"file\";s:57:\"/var/www/dotproject_plus/modules/links/projects_tab.links\";s:6:\"module\";s:5:\"links\";}i:6;a:3:{s:4:\"name\";s:18:\"2integratedmodules\";s:4:\"file\";s:77:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.2integratedmodules\";s:6:\"module\";s:12:\"timeplanning\";}i:7;a:3:{s:4:\"name\";s:10:\"3execution\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.3execution\";s:6:\"module\";s:12:\"timeplanning\";}i:8;a:3:{s:4:\"name\";s:25:\"4Monitoringandcontrolling\";s:4:\"file\";s:84:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.4Monitoringandcontrolling\";s:6:\"module\";s:12:\"timeplanning\";}i:9;a:3:{s:4:\"name\";s:11:\"1initiation\";s:4:\"file\";s:70:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.1initiation\";s:6:\"module\";s:12:\"timeplanning\";}i:10;a:3:{s:4:\"name\";s:8:\"5closing\";s:4:\"file\";s:67:\"/var/www/dotproject_plus/modules/timeplanning/projects_tab.5closing\";s:6:\"module\";s:12:\"timeplanning\";}}s:6:\"system\";a:0:{}s:5:\"admin\";a:1:{s:8:\"viewuser\";a:3:{i:0;a:3:{s:4:\"name\";s:9:\"5LBLCUSTO\";s:4:\"file\";s:82:\"/var/www/dotproject_plus/modules/monitoringandcontrol/admin_tab.viewuser.5LBLCUSTO\";s:6:\"module\";s:20:\"monitoringandcontrol\";}i:1;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:69:\"/var/www/dotproject_plus/modules/projects/admin_tab.viewuser.projects\";s:6:\"module\";s:8:\"projects\";}i:2;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/admin_tab.viewuser.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}}s:9:\"companies\";a:4:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:71:\"/var/www/dotproject_plus/modules/dotproject_plus/companies_tab.Projects\";s:6:\"module\";s:15:\"dotproject_plus\";}i:1;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:58:\"/var/www/dotproject_plus/modules/files/companies_tab.files\";s:6:\"module\";s:5:\"files\";}s:4:\"view\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:75:\"/var/www/dotproject_plus/modules/projects/companies_tab.view.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}i:2;a:3:{s:4:\"name\";s:13:\"Configuration\";s:4:\"file\";s:73:\"/var/www/dotproject_plus/modules/timeplanning/companies_tab.Configuration\";s:6:\"module\";s:12:\"timeplanning\";}}s:12:\"timeplanning\";a:0:{}s:15:\"projectdesigner\";a:0:{}s:6:\"public\";a:0:{}s:7:\"history\";a:0:{}s:9:\"resources\";a:0:{}s:8:\"calendar\";a:1:{i:0;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:63:\"/var/www/dotproject_plus/modules/projects/calendar_tab.projects\";s:6:\"module\";s:8:\"projects\";}}s:11:\"smartsearch\";a:0:{}s:13:\"scopeplanning\";a:0:{}}user_choosen_feature|N;gqs_tab|s:1:\"1\";resource_type_list|a:4:{i:0;a:2:{s:16:\"resource_type_id\";i:0;s:18:\"resource_type_name\";s:13:\"All Resources\";}i:1;a:4:{i:0;s:1:\"1\";s:16:\"resource_type_id\";s:1:\"1\";i:1;s:9:\"Equipment\";s:18:\"resource_type_name\";s:9:\"Equipment\";}i:2;a:4:{i:0;s:1:\"2\";s:16:\"resource_type_id\";s:1:\"2\";i:1;s:4:\"Tool\";s:18:\"resource_type_name\";s:4:\"Tool\";}i:3;a:4:{i:0;s:1:\"3\";s:16:\"resource_type_id\";s:1:\"3\";i:1;s:5:\"Venue\";s:18:\"resource_type_name\";s:5:\"Venue\";}}gantt_arr|a:42:{i:0;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"83\";s:11:\"task_parent\";s:2:\"83\";s:9:\"task_name\";s:33:\"Entrevistar usuários do sistema.\";s:15:\"task_start_date\";s:19:\"2013-02-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-02-15 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:1;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"82\";s:11:\"task_parent\";s:2:\"82\";s:9:\"task_name\";s:23:\"Identificar requisitos.\";s:15:\"task_start_date\";s:19:\"2013-02-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-01 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:2;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"66\";s:11:\"task_parent\";s:2:\"66\";s:9:\"task_name\";s:26:\"Elaborar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-05 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-15 00:00:00\";s:13:\"task_duration\";s:2:\"11\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:3;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"67\";s:11:\"task_parent\";s:2:\"67\";s:9:\"task_name\";s:25:\"Aprovar plano do projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-18 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:4;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"69\";s:11:\"task_parent\";s:2:\"69\";s:9:\"task_name\";s:42:\"Realizar as contratações para o projeto.\";s:15:\"task_start_date\";s:19:\"2013-03-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-22 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:5;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"70\";s:11:\"task_parent\";s:2:\"70\";s:9:\"task_name\";s:22:\"Arquivar os contratos.\";s:15:\"task_start_date\";s:19:\"2013-03-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-03-27 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:6;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"85\";s:11:\"task_parent\";s:2:\"85\";s:9:\"task_name\";s:74:\"Elaborar os protótipos das telas de cadastro de clientes e pedidos (web).\";s:15:\"task_start_date\";s:19:\"2013-04-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_duration\";s:1:\"8\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:7;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"86\";s:11:\"task_parent\";s:2:\"86\";s:9:\"task_name\";s:60:\"Elaborar protótipo da tela de consulta de pedidos (mobile).\";s:15:\"task_start_date\";s:19:\"2013-04-08 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:8;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"71\";s:11:\"task_parent\";s:2:\"71\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:9;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"74\";s:11:\"task_parent\";s:2:\"74\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (primeiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-10 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:10;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"84\";s:11:\"task_parent\";s:2:\"84\";s:9:\"task_name\";s:62:\"Modelar os diagramas de caso de uso, classe, sequência, e ER.\";s:15:\"task_start_date\";s:19:\"2013-04-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-04-25 00:00:00\";s:13:\"task_duration\";s:1:\"9\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:11;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"87\";s:11:\"task_parent\";s:2:\"87\";s:9:\"task_name\";s:49:\"Programar funcionalidade de cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-01 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-06 00:00:00\";s:13:\"task_duration\";s:1:\"6\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:12;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"88\";s:11:\"task_parent\";s:2:\"88\";s:9:\"task_name\";s:55:\"Realizar teste de unidade sobre o cadastro de clientes.\";s:15:\"task_start_date\";s:19:\"2013-05-07 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-09 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:13;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"91\";s:11:\"task_parent\";s:2:\"91\";s:9:\"task_name\";s:73:\"Programar funcionalidade para autenticação de clientes e funcionários.\";s:15:\"task_start_date\";s:19:\"2013-05-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:14;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"92\";s:11:\"task_parent\";s:2:\"92\";s:9:\"task_name\";s:60:\"Realizar testes de unidade sobre a função de autentição.\";s:15:\"task_start_date\";s:19:\"2013-05-13 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-14 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:15;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"89\";s:11:\"task_parent\";s:2:\"89\";s:9:\"task_name\";s:48:\"Programar funcionalidade de cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-16 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:16;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"90\";s:11:\"task_parent\";s:2:\"90\";s:9:\"task_name\";s:55:\"Realizar testes de unidade sobre o cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-05-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:17;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"72\";s:11:\"task_parent\";s:2:\"72\";s:9:\"task_name\";s:55:\"Realizar reunião de acompanhamento (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:18;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"75\";s:11:\"task_parent\";s:2:\"75\";s:9:\"task_name\";s:64:\"Elaborar relatório do desempenho do projeto (segundo bimestre).\";s:15:\"task_start_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-05-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:19;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"93\";s:11:\"task_parent\";s:2:\"93\";s:9:\"task_name\";s:50:\"Programar telas de cadastro de clientes e pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-07 00:00:00\";s:13:\"task_duration\";s:1:\"5\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:20;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"94\";s:11:\"task_parent\";s:2:\"94\";s:9:\"task_name\";s:77:\"Realizar teste de sistema sobre o cadastro de clientes e cadastro de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-11 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:21;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"95\";s:11:\"task_parent\";s:2:\"95\";s:9:\"task_name\";s:52:\"Programar tela web de listagem de pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-12 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-14 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:22;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"96\";s:11:\"task_parent\";s:2:\"96\";s:9:\"task_name\";s:53:\"Realizar teste de sistema sobre os pedidos em aberto.\";s:15:\"task_start_date\";s:19:\"2013-06-17 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-18 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:23;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"97\";s:11:\"task_parent\";s:2:\"97\";s:9:\"task_name\";s:61:\"Integrar função de consulta de pedidos na tela para mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-27 00:00:00\";s:13:\"task_duration\";s:1:\"7\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:24;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"99\";s:11:\"task_parent\";s:2:\"99\";s:9:\"task_name\";s:96:\"Realizar teste de integração entre a tela para mobile e as funções para consulta de pedidos.\";s:15:\"task_start_date\";s:19:\"2013-06-28 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-06-29 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:25;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"98\";s:11:\"task_parent\";s:2:\"98\";s:9:\"task_name\";s:64:\"Realizar teste de sistema sobre a consulta de pedidos em mobile.\";s:15:\"task_start_date\";s:19:\"2013-06-30 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-01 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:26;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"77\";s:11:\"task_parent\";s:2:\"77\";s:9:\"task_name\";s:33:\"Inspecionar qualidade do produto.\";s:15:\"task_start_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-03 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:27;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"100\";s:11:\"task_parent\";s:3:\"100\";s:9:\"task_name\";s:49:\"Preparar o material para ministrar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-10 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-12 00:00:00\";s:13:\"task_duration\";s:1:\"3\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:28;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"101\";s:11:\"task_parent\";s:3:\"101\";s:9:\"task_name\";s:23:\"Realizar o treinamento.\";s:15:\"task_start_date\";s:19:\"2013-07-15 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-18 00:00:00\";s:13:\"task_duration\";s:1:\"4\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:29;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"73\";s:11:\"task_parent\";s:2:\"73\";s:9:\"task_name\";s:56:\"Realizar reunião de acompanhamento (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-20 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:30;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"76\";s:11:\"task_parent\";s:2:\"76\";s:9:\"task_name\";s:65:\"Elaborar relatório do desempenho do projeto (terceiro bimestre).\";s:15:\"task_start_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-21 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:31;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"104\";s:11:\"task_parent\";s:3:\"104\";s:9:\"task_name\";s:41:\"Coletar os dispositivos dos entregadores.\";s:15:\"task_start_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-22 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:32;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"105\";s:11:\"task_parent\";s:3:\"105\";s:9:\"task_name\";s:31:\"Instalar apps nos dispositivos.\";s:15:\"task_start_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-23 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:33;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"103\";s:11:\"task_parent\";s:3:\"103\";s:9:\"task_name\";s:68:\"Instalar o sistema no servidor produtivo e nos dispositivos móveis.\";s:15:\"task_start_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-24 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:2:\"-1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:34;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"106\";s:11:\"task_parent\";s:3:\"106\";s:9:\"task_name\";s:41:\"Integrar módulo web ao site da pizzaria.\";s:15:\"task_start_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-25 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"1\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:35;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"102\";s:11:\"task_parent\";s:3:\"102\";s:9:\"task_name\";s:47:\"Realizar o teste de aceite junto aos usuários.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:36;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"68\";s:11:\"task_parent\";s:2:\"68\";s:9:\"task_name\";s:32:\"Auditar a qualidade do processo.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"2\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:37;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"78\";s:11:\"task_parent\";s:2:\"78\";s:9:\"task_name\";s:31:\"Obter aceite formal do cliente.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:38;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"79\";s:11:\"task_parent\";s:2:\"79\";s:9:\"task_name\";s:32:\"Discutir as lições aprendidas.\";s:15:\"task_start_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-26 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:39;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"80\";s:11:\"task_parent\";s:2:\"80\";s:9:\"task_name\";s:57:\"Registrar as lições aprendidas na base de conhecimento.\";s:15:\"task_start_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-27 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:40;a:2:{i:0;a:14:{s:7:\"task_id\";s:2:\"81\";s:11:\"task_parent\";s:2:\"81\";s:9:\"task_name\";s:35:\"Realizar a reunião de post mortem.\";s:15:\"task_start_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_end_date\";s:19:\"2013-07-29 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:41;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"128\";s:11:\"task_parent\";s:3:\"128\";s:9:\"task_name\";s:24:\"TESTE DE CADASTRO (2022)\";s:15:\"task_start_date\";s:19:\"2021-12-09 00:00:00\";s:13:\"task_end_date\";s:19:\"2021-12-09 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"2\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:32:\"Sistema de pizzaria do Tio Chico\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}}','2025-05-21 18:53:11','2025-05-21 13:11:46'),('fn3u22nkp5ngqiqu0sfbk3pg06',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:57:13','2016-06-03 04:57:13'),('gnfv9rdqkjm4u5chap2nfb2en1',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:33:58','2016-06-03 04:33:58'),('h05o1dg7evv0hc38nfn82te554',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:17:04','2016-06-03 05:17:04'),('h746n4iqo5peq95q6l725u9da0',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:34:23','2016-06-03 05:34:23'),('hueqoff2l79s44g352ueb0pt45',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:29:54','2016-06-03 04:29:54'),('ihd6labnbdsidcutlde6e57g64',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:02:48','2016-06-03 05:02:48'),('imt6s5ans3nu1kar8l0pb06h66',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:00:57','2016-06-03 05:00:57'),('j7m76lv76qhmsrkk79fdeef2u7',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:55:12','2016-06-03 04:55:12'),('l52dg9399d55ktb0fotprccv83',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:22:21','2016-06-03 05:22:21'),('mkjbvbboesm62jufortkc2qi60',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:20:53','2016-06-03 05:20:53'),('o8giv7tp5g60tbe9l0u4v947a1',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:32:16','2016-06-03 05:32:16'),('ocssq7bc6nkksisadavloghk80',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:49:44','2016-06-03 05:49:44'),('opn2rb74ls9e0aljavlc38pd05',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:07:41','2016-06-03 04:07:41'),('oqs76naetjo7lrqmajan0f0654',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:35:19','2016-06-03 05:35:19'),('plf1qe37gl6r73rti3tphpvri6',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:26:56','2016-06-03 05:26:56'),('qeuvuqt7ind9b4ik33p3t6srm0',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:29:10','2016-06-03 05:29:10'),('qpdrp3phmi9603l6cje3sn7927',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:33:33','2016-06-03 05:33:33'),('qtkpss8jvetjjn2r7j4jbs1754',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:25:28','2016-06-03 04:25:28'),('slgd5al2pb46h7ubqedlec4am3',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:56:31','2016-06-03 05:56:31'),('su6kmqa18nguks7spq19a62tp5',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:31:10','2016-06-03 04:31:10'),('tnkvsr7qqtfs09hal7qasiums4',140,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:6:{s:14:\"ProjIdxCompany\";s:0:\"\";s:15:\"ProjIdxOrderDir\";s:3:\"asc\";s:12:\"SAVEDPLACE-1\";s:10:\"m=projects\";s:10:\"SAVEDPLACE\";s:7:\"m=admin\";s:10:\"ProjIdxTab\";i:7;s:9:\"ProjVwTab\";s:1:\"1\";}s:7:\"user_id\";s:1:\"1\";s:15:\"user_first_name\";s:5:\"Admin\";s:14:\"user_last_name\";s:6:\"Person\";s:12:\"user_company\";s:0:\"\";s:15:\"user_department\";i:0;s:10:\"user_email\";s:17:\"admin@example.com\";s:9:\"user_type\";s:1:\"1\";s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";i:0;s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";i:2;s:13:\"version_minor\";i:1;s:13:\"version_patch\";i:8;s:14:\"version_string\";s:5:\"2.1.8\";s:14:\"last_insert_id\";s:3:\"140\";s:10:\"project_id\";i:0;}user_feedback|a:13:{i:1;i:1;i:19;i:19;i:3;i:3;i:29;i:29;i:30;i:30;i:4;i:4;i:5;i:5;i:6;i:6;i:12;i:12;i:9;i:9;i:11;i:11;i:13;i:13;i:2;i:2;}user_feedback_read|a:0:{}user_especific_feedback|i:1;user_generic_feedback|i:1;all_tabs|a:2:{s:8:\"projects\";a:4:{i:0;a:3:{s:4:\"name\";s:6:\"Events\";s:4:\"file\";s:68:\"C:\\xampp\\htdocs\\dotproject_plus/modules/calendar/projects_tab.events\";s:6:\"module\";s:8:\"calendar\";}i:1;a:3:{s:4:\"name\";s:9:\"Execution\";s:4:\"file\";s:78:\"C:\\xampp\\htdocs\\dotproject_plus/modules/dotproject_plus/projects_tab.execution\";s:6:\"module\";s:15:\"dotproject_plus\";}i:2;a:3:{s:4:\"name\";s:23:\"Planning and monitoring\";s:4:\"file\";s:92:\"C:\\xampp\\htdocs\\dotproject_plus/modules/dotproject_plus/projects_tab.planning_and_monitoring\";s:6:\"module\";s:15:\"dotproject_plus\";}i:3;a:3:{s:4:\"name\";s:5:\"Files\";s:4:\"file\";s:64:\"C:\\xampp\\htdocs\\dotproject_plus/modules/files/projects_tab.files\";s:6:\"module\";s:5:\"files\";}}s:5:\"admin\";a:1:{s:8:\"viewuser\";a:3:{i:0;a:3:{s:4:\"name\";s:9:\"5LBLCUSTO\";s:4:\"file\";s:89:\"C:\\xampp\\htdocs\\dotproject_plus/modules/monitoringandcontrol/admin_tab.viewuser.5LBLCUSTO\";s:6:\"module\";s:20:\"monitoringandcontrol\";}i:1;a:3:{s:4:\"name\";s:8:\"Projects\";s:4:\"file\";s:76:\"C:\\xampp\\htdocs\\dotproject_plus/modules/projects/admin_tab.viewuser.projects\";s:6:\"module\";s:8:\"projects\";}i:2;a:3:{s:4:\"name\";s:14:\"Projects gantt\";s:4:\"file\";s:82:\"C:\\xampp\\htdocs\\dotproject_plus/modules/projects/admin_tab.viewuser.projects_gantt\";s:6:\"module\";s:8:\"projects\";}}}}user_choosen_feature|s:65:\"/modules/dotproject_plus/projects_tab.planning_and_monitoring.php\";gqs_tab|i:1;gantt_arr|a:3:{i:0;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"107\";s:11:\"task_parent\";s:3:\"107\";s:9:\"task_name\";s:52:\"Projetar um painel para apresentação das mensagens\";s:15:\"task_start_date\";s:19:\"2016-02-08 00:00:00\";s:13:\"task_end_date\";s:19:\"2016-02-08 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"4\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:29:\"Projeto - módulo de feedback\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:1;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"113\";s:11:\"task_parent\";s:3:\"113\";s:9:\"task_name\";s:53:\"Desenvolver mecanismo de apresentação das mensagens\";s:15:\"task_start_date\";s:19:\"2016-02-20 00:00:00\";s:13:\"task_end_date\";s:19:\"2016-03-18 00:00:00\";s:13:\"task_duration\";s:2:\"28\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"4\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:29:\"Projeto - módulo de feedback\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}i:2;a:2:{i:0;a:14:{s:7:\"task_id\";s:3:\"111\";s:11:\"task_parent\";s:3:\"111\";s:9:\"task_name\";s:50:\"Programar uma lista dos feedbacks para o usuário.\";s:15:\"task_start_date\";s:19:\"2016-03-31 00:00:00\";s:13:\"task_end_date\";s:19:\"2016-03-31 00:00:00\";s:13:\"task_duration\";s:1:\"1\";s:18:\"task_duration_type\";s:2:\"24\";s:13:\"task_priority\";s:1:\"0\";s:21:\"task_percent_complete\";s:1:\"0\";s:10:\"task_order\";s:1:\"0\";s:12:\"task_project\";s:1:\"4\";s:14:\"task_milestone\";s:1:\"0\";s:12:\"project_name\";s:29:\"Projeto - módulo de feedback\";s:12:\"task_dynamic\";s:1:\"0\";}i:1;i:0;}}','2016-06-11 09:32:32','2016-06-11 11:29:47'),('v6sgjoiiurf0sskekgosfu14v6',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 01:46:37','2016-06-03 03:46:37'),('vpttve03eg1h04jh6vvc8frvh6',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 03:10:08','2016-06-03 05:10:08'),('vs9f92mldedg1n8gjp2e6en533',0,_binary 'LANGUAGES|a:6:{s:5:\"en_AU\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Aus)\";i:2;s:13:\"English (Aus)\";i:3;s:3:\"ena\";}s:5:\"en_CA\";a:4:{i:0;s:2:\"en\";i:1;s:13:\"English (Can)\";i:2;s:13:\"English (Can)\";i:3;s:3:\"enc\";}s:5:\"en_GB\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (GB)\";i:2;s:12:\"English (GB)\";i:3;s:3:\"eng\";}s:5:\"en_NZ\";a:4:{i:0;s:2:\"en\";i:1;s:12:\"English (NZ)\";i:2;s:12:\"English (NZ)\";i:3;s:3:\"enz\";}s:5:\"en_US\";a:5:{i:0;s:2:\"en\";i:1;s:12:\"English (US)\";i:2;s:12:\"English (US)\";i:3;s:3:\"enu\";i:4;s:10:\"ISO8859-15\";}s:5:\"pt_br\";a:4:{i:0;s:5:\"pt_br\";i:1;s:10:\"Português\";i:2;s:10:\"Português\";i:3;s:5:\"pt_br\";}}AppUI|O:6:\"CAppUI\":24:{s:5:\"state\";a:0:{}s:7:\"user_id\";i:-1;s:15:\"user_first_name\";s:0:\"\";s:14:\"user_last_name\";s:0:\"\";s:12:\"user_company\";i:0;s:15:\"user_department\";i:0;s:10:\"user_email\";N;s:9:\"user_type\";i:0;s:10:\"user_prefs\";a:14:{s:10:\"USERFORMAT\";s:4:\"user\";s:6:\"LOCALE\";s:5:\"pt_br\";s:7:\"TABVIEW\";s:1:\"0\";s:12:\"SHDATEFORMAT\";s:8:\"%d/%m/%Y\";s:10:\"TIMEFORMAT\";s:8:\"%I:%M %p\";s:12:\"CURRENCYFORM\";s:5:\"en_AU\";s:7:\"UISTYLE\";s:15:\"dotproject_plus\";s:13:\"TASKASSIGNMAX\";s:3:\"100\";s:11:\"EVENTFILTER\";s:2:\"my\";s:7:\"MAILALL\";s:1:\"0\";s:12:\"TASKLOGEMAIL\";s:1:\"0\";s:11:\"TASKLOGSUBJ\";s:0:\"\";s:11:\"TASKLOGNOTE\";s:1:\"0\";s:10:\"USEDIGESTS\";s:1:\"0\";}s:12:\"day_selected\";N;s:11:\"user_locale\";s:5:\"pt_br\";s:9:\"user_lang\";a:4:{i:0;s:11:\"pt_br.utf-8\";i:1;s:5:\"pt_br\";i:2;s:5:\"pt_br\";i:3;s:5:\"pt_br\";}s:11:\"base_locale\";s:2:\"en\";s:16:\"base_date_locale\";N;s:3:\"msg\";s:0:\"\";s:5:\"msgNo\";s:0:\"\";s:15:\"defaultRedirect\";s:0:\"\";s:3:\"cfg\";a:1:{s:11:\"locale_warn\";b:0;}s:13:\"version_major\";N;s:13:\"version_minor\";N;s:13:\"version_patch\";N;s:14:\"version_string\";N;s:14:\"last_insert_id\";N;s:10:\"project_id\";i:0;}','2016-06-03 02:18:19','2016-06-03 04:18:19');
/*!40000 ALTER TABLE `dotp_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_skills`
--

DROP TABLE IF EXISTS `dotp_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_skills` (
  `skill_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_type` enum('technical','behavioral') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'technical',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_skills`
--

LOCK TABLES `dotp_skills` WRITE;
/*!40000 ALTER TABLE `dotp_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_syskeys`
--

DROP TABLE IF EXISTS `dotp_syskeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_syskeys` (
  `syskey_id` int unsigned NOT NULL AUTO_INCREMENT,
  `syskey_name` varchar(48) NOT NULL DEFAULT '',
  `syskey_label` varchar(255) NOT NULL DEFAULT '',
  `syskey_type` int unsigned NOT NULL DEFAULT '0',
  `syskey_sep1` char(2) DEFAULT '\n',
  `syskey_sep2` char(2) NOT NULL DEFAULT '|',
  PRIMARY KEY (`syskey_id`),
  UNIQUE KEY `syskey_name` (`syskey_name`),
  UNIQUE KEY `idx_syskey_name` (`syskey_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_syskeys`
--

LOCK TABLES `dotp_syskeys` WRITE;
/*!40000 ALTER TABLE `dotp_syskeys` DISABLE KEYS */;
INSERT INTO `dotp_syskeys` VALUES (1,'SelectList','Enter values for list',0,'\n','|'),(2,'CustomField','Serialized array in the following format:\r\n<KEY>|<SERIALIZED ARRAY>\r\n\r\nSerialized Array:\r\n[type] => text | checkbox | select | textarea | label\r\n[name] => <Field\'s name>\r\n[options] => <html capture options>\r\n[selects] => <options for select and checkbox>',0,'\n','|'),(3,'ColorSelection','Hex color values for type=>color association.',0,'\n','|');
/*!40000 ALTER TABLE `dotp_syskeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_sysvals`
--

DROP TABLE IF EXISTS `dotp_sysvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_sysvals` (
  `sysval_id` int unsigned NOT NULL AUTO_INCREMENT,
  `sysval_key_id` int unsigned NOT NULL DEFAULT '0',
  `sysval_title` varchar(48) NOT NULL DEFAULT '',
  `sysval_value` text NOT NULL,
  PRIMARY KEY (`sysval_id`),
  UNIQUE KEY `idx_sysval_title` (`sysval_title`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_sysvals`
--

LOCK TABLES `dotp_sysvals` WRITE;
/*!40000 ALTER TABLE `dotp_sysvals` DISABLE KEYS */;
INSERT INTO `dotp_sysvals` VALUES (1,1,'ProjectStatus','0|Not Defined\r\n1|Proposed\r\n2|In Planning\r\n3|In Progress\r\n4|On Hold\r\n5|Complete\r\n6|Template\r\n7|Archived'),(2,1,'CompanyType','0|Not Applicable\n1|Client\n2|Vendor\n3|Supplier\n4|Consultant\n5|Government\n6|Internal'),(3,1,'TaskDurationType','1|hours\n24|days'),(4,1,'EventType','0|General\n1|Appointment\n2|Meeting\n3|All Day Event\n4|Anniversary\n5|Reminder'),(5,1,'TaskStatus','0|Active\n-1|Inactive'),(6,1,'TaskType','0|Unknown\n1|Administrative\n2|Operative'),(7,1,'ProjectType','0|Unknown\n1|Administrative\n2|Operative'),(8,3,'ProjectColors','Web|FFE0AE\nEngineering|AEFFB2\nHelpDesk|FFFCAE\nSystem Administration|FFAEAE'),(9,1,'FileType','0|Unknown\n1|Document\n2|Application'),(10,1,'TaskPriority','-1|low\n0|normal\n1|high'),(11,1,'ProjectPriority','-1|low\n0|normal\n1|high'),(12,1,'ProjectPriorityColor','-1|#E5F7FF\n0|\n1|#FFDCB3'),(13,1,'TaskLogReference','0|Not Defined\n1|Email\n2|Helpdesk\n3|Phone Call\n4|Fax'),(14,1,'TaskLogReferenceImage','0| 1|./images/obj/email.gif 2|./modules/helpdesk/images/helpdesk.png 3|./images/obj/phone.gif 4|./images/icons/stock_print-16.png'),(15,1,'UserType','0|Default User\r\n1|Administrator\r\n2|CEO\r\n3|Director\r\n4|Branch Manager\r\n5|Manager\r\n6|Supervisor\r\n7|Employee'),(16,1,'ProjectRequiredFields','f.project_name.value.length|<3\r\nf.project_color_identifier.value.length|<3\r\nf.project_company.options[f.project_company.selectedIndex].value|<1'),(17,2,'TicketNotify','0|admin@example.com\n1|admin@example.com\n2|admin@example.com\r\n3|admin@example.com\r\n4|admin@example.com'),(18,1,'TicketPriority','0|Low\n1|Normal\n2|High\n3|Highest\n4|911'),(19,1,'TicketStatus','0|Open\n1|Closed\n2|Deleted'),(20,1,'RiskImpact','0|LBL_SUPER_LOW_M\n1|LBL_LOW_M\n2|LBL_MEDIUM_M\n3|LBL_HIGH_M\n4|LBL_SUPER_HIGH_M'),(21,1,'RiskProbability','0|LBL_SUPER_LOW_F\n1|LBL_LOW_F\n2|LBL_MEDIUM_F\n3|LBL_HIGH_F\n4|LBL_SUPER_HIGH_F'),(22,1,'RiskStatus','0|LBL_RISK_STATUS_IDENTIFIED\n1|LBL_RISK_STATUS_MONITORED\n2|LBL_RISK_STATUS_MATERIALIZED\n3|LBL_RISK_STATUS_FINISHED'),(23,1,'RiskPotential','0|LBL_NO\n1|LBL_YES'),(24,1,'RiskPriority','0|LBL_LOW_F\n1|LBL_MEDIUM_F\n2|LBL_HIGH_F'),(25,1,'RiskActive','0|LBL_YES\n1|LBL_NO'),(26,1,'RiskStrategy','0|LBL_ACCEPT\n1|LBL_ELIMINATE\n2|LBL_MITIGATE\n3|LBL_TRANSFER'),(27,1,'LinkType','0|Unknown\n1|Document\n2|Application');
/*!40000 ALTER TABLE `dotp_sysvals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_task_contacts`
--

DROP TABLE IF EXISTS `dotp_task_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_task_contacts` (
  `task_id` int NOT NULL,
  `contact_id` int NOT NULL,
  KEY `idx_task_contacts` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_task_contacts`
--

LOCK TABLES `dotp_task_contacts` WRITE;
/*!40000 ALTER TABLE `dotp_task_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_task_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_task_departments`
--

DROP TABLE IF EXISTS `dotp_task_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_task_departments` (
  `task_id` int NOT NULL,
  `department_id` int NOT NULL,
  KEY `idx_task_departments` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_task_departments`
--

LOCK TABLES `dotp_task_departments` WRITE;
/*!40000 ALTER TABLE `dotp_task_departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_task_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_task_dependencies`
--

DROP TABLE IF EXISTS `dotp_task_dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_task_dependencies` (
  `dependencies_task_id` int NOT NULL,
  `dependencies_req_task_id` int NOT NULL,
  PRIMARY KEY (`dependencies_task_id`,`dependencies_req_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_task_dependencies`
--

LOCK TABLES `dotp_task_dependencies` WRITE;
/*!40000 ALTER TABLE `dotp_task_dependencies` DISABLE KEYS */;
INSERT INTO `dotp_task_dependencies` VALUES (18,19),(19,43),(20,33),(32,18),(33,32),(34,42),(35,49),(42,44),(44,48),(49,50),(50,48),(54,52),(54,53),(55,54),(56,55),(57,55),(58,56),(59,58),(60,59),(61,60),(66,82),(67,66),(69,67),(70,69),(72,71),(73,72),(75,74),(76,75),(77,98),(78,102),(80,79),(82,83),(84,86),(85,70),(86,85),(87,84),(88,87),(89,88),(90,89),(91,90),(92,91),(93,90),(94,93),(95,94),(96,95),(97,96),(98,99),(99,97),(100,77),(101,100),(102,106),(103,101),(104,101),(105,104),(119,121),(120,119),(122,120);
/*!40000 ALTER TABLE `dotp_task_dependencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_task_log`
--

DROP TABLE IF EXISTS `dotp_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_task_log` (
  `task_log_id` int NOT NULL AUTO_INCREMENT,
  `task_log_task` int NOT NULL DEFAULT '0',
  `task_log_name` varchar(255) DEFAULT NULL,
  `task_log_description` text,
  `task_log_creator` int NOT NULL DEFAULT '0',
  `task_log_hours` float NOT NULL DEFAULT '0',
  `task_log_date` datetime DEFAULT NULL,
  `task_log_costcode` varchar(8) NOT NULL DEFAULT '',
  `task_log_problem` tinyint(1) DEFAULT '0',
  `task_log_reference` tinyint DEFAULT '0',
  `task_log_related_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`task_log_id`),
  KEY `idx_log_task` (`task_log_task`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_task_log`
--

LOCK TABLES `dotp_task_log` WRITE;
/*!40000 ALTER TABLE `dotp_task_log` DISABLE KEYS */;
INSERT INTO `dotp_task_log` VALUES (1,119,'Document project requirements','I have worked in this activity',1,5,'2016-03-27 00:15:46','',0,0,NULL),(5,119,'registering.','registering.',1,3,'2016-04-09 00:00:00','',0,0,NULL),(6,129,'teste','teste',1,0.5,'2016-04-08 00:00:00','',0,0,NULL),(7,130,'teste','teste',1,0.5,'2016-04-11 00:00:00','',0,0,NULL),(8,130,'teste','teste',1,0.5,'2016-04-15 00:00:00','',0,0,NULL),(9,130,'concluída.','concluída.',1,0.5,'2016-04-15 00:00:00','',0,0,NULL),(21,129,'teste','teste',1,0.5,'2016-04-12 00:00:00','',0,0,NULL),(22,129,'teste','teste',1,0.5,'2016-04-12 00:00:00','',0,0,NULL),(23,129,'teste','teste',1,0.5,'2016-04-12 00:00:00','',0,0,NULL),(25,129,'teste3','teste3',1,0.5,'2016-04-12 00:00:00','',0,0,NULL),(26,130,'teste','teste',1,0.5,'2016-05-01 00:00:00','',0,0,NULL),(27,140,'teste','teste',1,0.5,'2016-11-10 00:00:00','',0,0,NULL);
/*!40000 ALTER TABLE `dotp_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_task_minute_members`
--

DROP TABLE IF EXISTS `dotp_task_minute_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_task_minute_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `task_minute_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_task_minute_partipant_task` (`task_minute_id`),
  KEY `fk_task_minute_partipant_user` (`user_id`),
  CONSTRAINT `fk_task_minute_partipant_task` FOREIGN KEY (`task_minute_id`) REFERENCES `dotp_project_minutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_task_minute_partipant_user` FOREIGN KEY (`user_id`) REFERENCES `dotp_contacts` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_task_minute_members`
--

LOCK TABLES `dotp_task_minute_members` WRITE;
/*!40000 ALTER TABLE `dotp_task_minute_members` DISABLE KEYS */;
INSERT INTO `dotp_task_minute_members` VALUES (1,21,1),(2,22,1);
/*!40000 ALTER TABLE `dotp_task_minute_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_tasks`
--

DROP TABLE IF EXISTS `dotp_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_tasks` (
  `task_id` int NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) DEFAULT NULL,
  `task_parent` int DEFAULT '0',
  `task_milestone` tinyint(1) DEFAULT '0',
  `task_project` int NOT NULL DEFAULT '0',
  `task_owner` int NOT NULL DEFAULT '0',
  `task_start_date` datetime DEFAULT NULL,
  `task_duration` float unsigned DEFAULT '0',
  `task_duration_type` int NOT NULL DEFAULT '1',
  `task_hours_worked` float unsigned DEFAULT '0',
  `task_end_date` datetime DEFAULT NULL,
  `task_status` int DEFAULT '0',
  `task_priority` tinyint DEFAULT '0',
  `task_percent_complete` tinyint DEFAULT '0',
  `task_description` text,
  `task_target_budget` decimal(10,2) DEFAULT '0.00',
  `task_related_url` varchar(255) DEFAULT NULL,
  `task_creator` int NOT NULL DEFAULT '0',
  `task_order` int NOT NULL DEFAULT '0',
  `task_client_publish` tinyint(1) NOT NULL DEFAULT '0',
  `task_dynamic` tinyint(1) NOT NULL DEFAULT '0',
  `task_access` int NOT NULL DEFAULT '0',
  `task_notify` int NOT NULL DEFAULT '0',
  `task_departments` char(100) DEFAULT NULL,
  `task_contacts` char(100) DEFAULT NULL,
  `task_custom` longtext,
  `task_type` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`),
  KEY `idx_task_parent` (`task_parent`),
  KEY `idx_task_project` (`task_project`),
  KEY `idx_task_owner` (`task_owner`),
  KEY `idx_task_order` (`task_order`),
  KEY `idx_task1` (`task_start_date`),
  KEY `idx_task2` (`task_end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_tasks`
--

LOCK TABLES `dotp_tasks` WRITE;
/*!40000 ALTER TABLE `dotp_tasks` DISABLE KEYS */;
INSERT INTO `dotp_tasks` VALUES (18,'Nova Atividade',18,0,2,2,'2014-10-13 00:00:00',1,24,0,'2014-10-13 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(19,'Nova Atividade',19,0,2,0,'2014-10-13 00:00:00',0,1,0,'2014-10-13 00:00:00',0,0,0,NULL,0.00,NULL,1,0,0,0,0,0,NULL,NULL,NULL,0),(20,'Atividade do pacote de trabalho',20,0,2,2,'2014-10-13 00:00:00',1,24,0,'2014-10-13 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(32,'Nova Atividade',32,0,2,2,'2014-10-20 00:00:00',1,24,0,'2014-10-20 00:00:00',0,0,50,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(33,'Nova Atividade',33,0,2,0,'2014-10-23 00:00:00',0,1,0,'2014-10-23 00:00:00',0,0,0,NULL,0.00,NULL,1,0,0,0,0,0,NULL,NULL,NULL,0),(34,'Nova Atividade',34,0,2,2,'2014-10-23 00:00:00',1,24,0,'2014-10-23 00:00:00',0,0,100,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(35,'Nova Atividade',35,0,2,2,'2014-10-23 00:00:00',1,24,0,'2014-10-23 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(42,'Nova Atividade',42,0,2,2,'2015-07-20 00:00:00',1,24,0,'2015-07-20 00:00:00',0,0,100,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(43,'Nova Atividade',43,0,2,0,'2015-07-22 00:00:00',0,1,0,'2015-07-22 00:00:00',0,0,0,NULL,0.00,NULL,1,0,0,0,0,0,NULL,NULL,NULL,0),(44,'Nova Atividade',44,0,2,2,'2015-07-22 00:00:00',1,24,0,'2015-07-22 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(49,'Programacao do sistema',49,0,2,2,'2014-10-22 00:00:00',3,24,0,'2014-11-24 00:00:00',0,0,100,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(50,'aquisição dos dispositivos.',50,0,2,2,'2014-09-26 00:00:00',34,24,0,'2014-10-28 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(62,'Treinamento dos usuários',62,0,2,8,'2015-10-29 00:00:00',1,24,0,'2015-10-29 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(63,'Instalação do sistema em servidor web produtivo',63,0,2,8,'2015-10-29 00:00:00',1,24,0,'2015-10-29 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(64,'Instalação de apps nos dispositivos móveis',64,0,2,8,'2015-10-29 00:00:00',1,24,0,'2015-10-29 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(65,'Site da pizzaria atualizado',65,0,2,8,'2015-10-29 00:00:00',1,24,0,'2015-10-29 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(66,'Elaborar plano do projeto.',66,0,2,2,'2013-03-05 00:00:00',11,24,0,'2013-03-15 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(67,'Aprovar plano do projeto.',67,0,2,8,'2013-03-18 00:00:00',1,24,0,'2013-03-18 00:00:00',0,0,100,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(68,'Auditar a qualidade do processo.',68,0,2,8,'2013-07-26 00:00:00',2,24,0,'2013-07-27 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(69,'Realizar as contratações para o projeto.',69,0,2,8,'2013-03-20 00:00:00',3,24,0,'2013-03-22 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(70,'Arquivar os contratos.',70,0,2,8,'2013-03-25 00:00:00',3,24,0,'2013-03-27 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(71,'Realizar reunião de acompanhamento (primeiro bimestre).',71,0,2,8,'2013-04-09 00:00:00',1,24,0,'2013-04-09 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(72,'Realizar reunião de acompanhamento (segundo bimestre).',72,0,2,8,'2013-05-20 00:00:00',1,24,0,'2013-05-20 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(73,'Realizar reunião de acompanhamento (terceiro bimestre).',73,0,2,8,'2013-07-20 00:00:00',1,24,0,'2013-07-20 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(74,'Elaborar relatório do desempenho do projeto (primeiro bimestre).',74,0,2,8,'2013-04-10 00:00:00',1,24,0,'2013-04-10 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(75,'Elaborar relatório do desempenho do projeto (segundo bimestre).',75,0,2,8,'2013-05-21 00:00:00',1,24,0,'2013-05-21 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(76,'Elaborar relatório do desempenho do projeto (terceiro bimestre).',76,0,2,8,'2013-07-21 00:00:00',1,24,0,'2013-07-21 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(77,'Inspecionar qualidade do produto.',77,0,2,8,'2013-07-03 00:00:00',1,24,0,'2013-07-03 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(78,'Obter aceite formal do cliente.',78,0,2,8,'2013-07-26 00:00:00',1,24,0,'2013-07-26 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(79,'Discutir as lições aprendidas.',79,0,2,8,'2013-07-26 00:00:00',1,24,0,'2013-07-26 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(80,'Registrar as lições aprendidas na base de conhecimento.',80,0,2,8,'2013-07-27 00:00:00',1,24,0,'2013-07-27 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(81,'Realizar a reunião de post mortem.',81,0,2,8,'2013-07-29 00:00:00',1,24,0,'2013-07-29 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(82,'Identificar requisitos.',82,0,2,8,'2013-02-25 00:00:00',5,24,0,'2013-03-01 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(83,'Entrevistar usuários do sistema.',83,0,2,8,'2013-02-12 00:00:00',4,24,0,'2013-02-15 00:00:00',0,0,0,NULL,0.00,'',1,-1,0,0,0,0,NULL,NULL,NULL,0),(84,'Modelar os diagramas de caso de uso, classe, sequência, e ER.',84,0,2,8,'2013-04-17 00:00:00',9,24,0,'2013-04-25 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(85,'Elaborar os protótipos das telas de cadastro de clientes e pedidos (web).',85,0,2,8,'2013-04-01 00:00:00',8,24,0,'2013-04-08 00:00:00',0,0,0,NULL,0.00,'',1,1,0,0,0,0,NULL,NULL,NULL,0),(86,'Elaborar protótipo da tela de consulta de pedidos (mobile).',86,0,2,8,'2013-04-08 00:00:00',2,24,0,'2013-04-09 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(87,'Programar funcionalidade de cadastro de clientes.',87,0,2,8,'2013-05-01 00:00:00',6,24,0,'2013-05-06 00:00:00',0,0,0,NULL,0.00,'',1,-1,0,0,0,0,NULL,NULL,NULL,0),(88,'Realizar teste de unidade sobre o cadastro de clientes.',88,0,2,8,'2013-05-07 00:00:00',3,24,0,'2013-05-09 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(89,'Programar funcionalidade de cadastro de pedidos.',89,0,2,8,'2013-05-15 00:00:00',2,24,0,'2013-05-16 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(90,'Realizar testes de unidade sobre o cadastro de pedidos.',90,0,2,8,'2013-05-17 00:00:00',2,24,0,'2013-05-18 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(91,'Programar funcionalidade para autenticação de clientes e funcionários.',91,0,2,8,'2013-05-10 00:00:00',4,24,0,'2013-05-13 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(92,'Realizar testes de unidade sobre a função de autentição.',92,0,2,8,'2013-05-13 00:00:00',2,24,0,'2013-05-14 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(93,'Programar telas de cadastro de clientes e pedidos.',93,0,2,8,'2013-06-03 00:00:00',5,24,0,'2013-06-07 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(94,'Realizar teste de sistema sobre o cadastro de clientes e cadastro de pedidos.',94,0,2,8,'2013-06-10 00:00:00',2,24,0,'2013-06-11 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(95,'Programar tela web de listagem de pedidos em aberto.',95,0,2,8,'2013-06-12 00:00:00',3,24,0,'2013-06-14 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(96,'Realizar teste de sistema sobre os pedidos em aberto.',96,0,2,8,'2013-06-17 00:00:00',2,24,0,'2013-06-18 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(97,'Integrar função de consulta de pedidos na tela para mobile.',97,0,2,8,'2013-06-21 00:00:00',7,24,0,'2013-06-27 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(98,'Realizar teste de sistema sobre a consulta de pedidos em mobile.',98,0,2,8,'2013-06-30 00:00:00',2,24,0,'2013-07-01 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(99,'Realizar teste de integração entre a tela para mobile e as funções para consulta de pedidos.',99,0,2,8,'2013-06-28 00:00:00',2,24,0,'2013-06-29 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(100,'Preparar o material para ministrar o treinamento.',100,0,2,8,'2013-07-10 00:00:00',3,24,0,'2013-07-12 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(101,'Realizar o treinamento.',101,0,2,8,'2013-07-15 00:00:00',4,24,0,'2013-07-18 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(102,'Realizar o teste de aceite junto aos usuários.',102,0,2,8,'2013-07-26 00:00:00',1,24,0,'2013-07-26 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(103,'Instalar o sistema no servidor produtivo e nos dispositivos móveis.',103,0,2,8,'2013-07-24 00:00:00',1,24,0,'2013-07-24 00:00:00',0,0,0,NULL,0.00,'',1,-1,0,0,0,0,NULL,NULL,NULL,0),(104,'Coletar os dispositivos dos entregadores.',104,0,2,8,'2013-07-22 00:00:00',1,24,0,'2013-07-22 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(105,'Instalar apps nos dispositivos.',105,0,2,8,'2013-07-23 00:00:00',1,24,0,'2013-07-23 00:00:00',0,0,0,NULL,0.00,'',1,1,0,0,0,0,NULL,NULL,NULL,0),(106,'Integrar módulo web ao site da pizzaria.',106,0,2,8,'2013-07-25 00:00:00',1,24,0,'2013-07-25 00:00:00',0,0,0,NULL,0.00,'',1,1,0,0,0,0,NULL,NULL,NULL,0),(119,'Document project requirements',119,0,8,13,'2016-03-27 00:00:00',11,24,0,'2016-04-07 00:00:00',0,0,100,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(120,'Collect the requirements approval',120,0,8,13,'2016-04-09 00:00:00',7,24,0,'2016-04-15 00:00:00',0,0,100,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(121,'Define project WBS',121,0,8,13,'2016-03-14 00:00:00',13,24,0,'2016-03-26 00:00:00',0,0,50,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(122,'Define project activities',122,0,8,13,'2016-04-17 00:00:00',11,24,0,'2016-04-27 00:00:00',0,0,50,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(126,'New activity',126,0,8,13,'2016-03-15 00:00:00',1,24,0,'2016-03-15 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(127,'New activity',127,0,8,0,'2016-03-30 00:00:00',0,1,0,'2016-03-30 00:00:00',0,0,0,NULL,0.00,NULL,1,0,0,0,0,0,NULL,NULL,NULL,0),(128,'TESTE DE CADASTRO (2022)',128,0,2,2,'2021-12-09 00:00:00',1,24,0,'2021-12-09 00:00:00',0,0,0,NULL,0.00,'',1,0,0,0,0,0,NULL,NULL,NULL,0),(130,'Identify stakeholders',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(131,'Conduct feasibility study',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(132,'Develop project management plan',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(133,'Define scope and requirements',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(134,'Create Work Breakdown Structure (WBS)',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(135,'Develop schedule and timeline',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(136,'Plan risk management',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(137,'Plan communication management',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,6,0,0,0,0,NULL,NULL,NULL,0),(138,'Acquire project team',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(139,'Develop team',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(140,'Manage project work',0,0,9,1,'2026-01-01 00:00:00',10,24,0,'2026-01-11 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(141,'Manage quality assurance',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(142,'Implement approved changes',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(143,'Monitor project performance (KPIs)',0,0,9,1,'2026-01-01 00:00:00',8,24,0,'2026-01-09 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(144,'Perform integrated change control',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(145,'Validate scope with stakeholders',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(146,'Control schedule and costs',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(147,'Report project status',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(148,'Obtain final acceptance',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(149,'Release project resources',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(150,'Conduct lessons learned session',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(151,'Archive project documents',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(152,'Formal project closure',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(153,'teste 2',0,0,9,1,'2026-06-04 00:00:00',1,24,0,'2026-06-09 00:00:00',0,0,0,NULL,0.00,NULL,0,0,0,0,0,0,NULL,NULL,NULL,0),(154,'Elaboração do Termo de Abertura do Projeto',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(155,'Identificação e Análise de Stakeholders',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(156,'Definição do Escopo Detalhado (EAP)',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(157,'Desenvolvimento do Cronograma Mestre',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(158,'Planejamento de Riscos e Respostas',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(159,'Aprovação do Plano de Projeto',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,6,0,0,0,0,NULL,NULL,NULL,0),(160,'Levantamento de Requisitos Funcionais e Não Funcionais',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(161,'Modelagem de Processos de Negócio (AS-IS / TO-BE)',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(162,'Prototipação de Telas e Experiência do Usuário (UX/UI)',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(163,'Arquitetura Técnica e Definição de Stack Tecnológica',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(164,'Validação e Assinatura dos Requisitos com Stakeholders',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(165,'Configuração de Ambientes (Dev, Homolog, Prod)',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(166,'Desenvolvimento do Backend (APIs, Banco de Dados, Regras de Negócio)',0,0,9,1,'2026-01-01 00:00:00',15,24,0,'2026-01-16 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(167,'Desenvolvimento do Frontend (Interfaces, Integração com API)',0,0,9,1,'2026-01-01 00:00:00',12,24,0,'2026-01-13 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(168,'Implementação de Testes Automatizados (Unitários, Integração)',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(169,'Integração Contínua e Entrega Contínua (CI/CD)',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(170,'Planejamento e Casos de Teste',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(171,'Execução de Testes Funcionais e de Regressão',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(172,'Testes de Performance, Carga e Segurança',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(173,'Teste de Aceitação do Usuário (UAT) com Cliente',0,0,9,1,'2026-01-01 00:00:00',5,24,0,'2026-01-06 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(174,'Correção de Defeitos e Retestes',0,0,9,1,'2026-01-01 00:00:00',4,24,0,'2026-01-05 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(175,'Plano de Implantação e Rollback',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(176,'Migração de Dados Históricos (se aplicável)',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(177,'Treinamento de Usuários Finais e Administradores',0,0,9,1,'2026-01-01 00:00:00',3,24,0,'2026-01-04 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(178,'Go-Live e Monitoramento Pós-Implantação',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(179,'Entrega de Documentação Técnica e Manual do Usuário',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0),(180,'Reunião de Lições Aprendidas',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,1,0,0,0,0,NULL,NULL,NULL,0),(181,'Formalização da Aceitação Final do Cliente',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,2,0,0,0,0,NULL,NULL,NULL,0),(182,'Liberação da Equipe e Recursos',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,3,0,0,0,0,NULL,NULL,NULL,0),(183,'Arquivamento da Documentação do Projeto',0,0,9,1,'2026-01-01 00:00:00',1,24,0,'2026-01-02 00:00:00',0,0,0,NULL,0.00,NULL,0,4,0,0,0,0,NULL,NULL,NULL,0),(184,'Relatório Final de Desempenho do Projeto',0,0,9,1,'2026-01-01 00:00:00',2,24,0,'2026-01-03 00:00:00',0,0,0,NULL,0.00,NULL,0,5,0,0,0,0,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `dotp_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_tasks_mdp`
--

DROP TABLE IF EXISTS `dotp_tasks_mdp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_tasks_mdp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int DEFAULT NULL,
  `pos_x` int DEFAULT NULL,
  `pos_y` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mdp_task` (`task_id`),
  CONSTRAINT `fk_mdp_task` FOREIGN KEY (`task_id`) REFERENCES `dotp_tasks` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_tasks_mdp`
--

LOCK TABLES `dotp_tasks_mdp` WRITE;
/*!40000 ALTER TABLE `dotp_tasks_mdp` DISABLE KEYS */;
INSERT INTO `dotp_tasks_mdp` VALUES (6,18,377,236),(7,19,152,246),(8,20,854,385),(9,32,585,224),(10,33,774,249),(11,34,1032,-28),(12,35,861,84),(13,42,824,-28),(14,43,58,17),(15,44,551,-28),(17,49,461,33),(18,50,80,10);
/*!40000 ALTER TABLE `dotp_tasks_mdp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_tasks_workpackages`
--

DROP TABLE IF EXISTS `dotp_tasks_workpackages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_tasks_workpackages` (
  `task_id` int NOT NULL DEFAULT '0',
  `eap_item_id` int DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  CONSTRAINT `fk_task_eap_item` FOREIGN KEY (`task_id`) REFERENCES `dotp_tasks` (`task_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_tasks_workpackages`
--

LOCK TABLES `dotp_tasks_workpackages` WRITE;
/*!40000 ALTER TABLE `dotp_tasks_workpackages` DISABLE KEYS */;
INSERT INTO `dotp_tasks_workpackages` VALUES (18,29),(19,30),(20,32),(32,31),(33,32),(34,31),(35,32),(42,37),(43,51),(44,62),(49,63),(50,78),(62,86),(63,86),(64,86),(65,86),(66,107),(67,107),(68,109),(69,108),(70,108),(71,112),(72,112),(73,112),(74,111),(75,111),(76,111),(77,110),(78,115),(79,114),(80,114),(81,113),(82,103),(83,103),(84,102),(85,101),(86,101),(87,100),(88,100),(89,99),(90,99),(91,98),(92,98),(93,96),(94,96),(95,94),(96,94),(97,93),(98,93),(99,93),(100,87),(101,87),(102,88),(103,88),(104,89),(105,89),(106,90),(119,159),(120,159),(121,161),(122,161),(126,161),(127,161),(128,89);
/*!40000 ALTER TABLE `dotp_tasks_workpackages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_tickets`
--

DROP TABLE IF EXISTS `dotp_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_tickets` (
  `ticket` int unsigned NOT NULL AUTO_INCREMENT,
  `ticket_company` int NOT NULL DEFAULT '0',
  `ticket_project` int NOT NULL DEFAULT '0',
  `author` varchar(100) NOT NULL DEFAULT '',
  `recipient` varchar(100) NOT NULL DEFAULT '',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `attachment` tinyint unsigned NOT NULL DEFAULT '0',
  `timestamp` int unsigned NOT NULL DEFAULT '0',
  `type` varchar(15) NOT NULL DEFAULT '',
  `assignment` int unsigned NOT NULL DEFAULT '0',
  `parent` int unsigned NOT NULL DEFAULT '0',
  `activity` int unsigned NOT NULL DEFAULT '0',
  `priority` tinyint unsigned NOT NULL DEFAULT '1',
  `cc` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `signature` text,
  PRIMARY KEY (`ticket`),
  KEY `parent` (`parent`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_tickets`
--

LOCK TABLES `dotp_tickets` WRITE;
/*!40000 ALTER TABLE `dotp_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_user_access_log`
--

DROP TABLE IF EXISTS `dotp_user_access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_user_access_log` (
  `user_access_log_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `user_ip` varchar(15) NOT NULL,
  `date_time_in` datetime DEFAULT '0000-00-00 00:00:00',
  `date_time_out` datetime DEFAULT '0000-00-00 00:00:00',
  `date_time_last_action` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_access_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_user_access_log`
--

LOCK TABLES `dotp_user_access_log` WRITE;
/*!40000 ALTER TABLE `dotp_user_access_log` DISABLE KEYS */;
INSERT INTO `dotp_user_access_log` VALUES (1,1,'::1','2014-10-01 14:12:28','2014-10-07 18:39:32','2014-10-01 19:12:30'),(2,1,'::1','2014-10-01 14:12:51','2014-10-07 18:39:32','2014-10-01 19:12:52'),(3,1,'::1','2014-10-01 14:13:42','2014-10-07 18:39:32','2014-10-01 19:13:43'),(4,1,'::1','2014-10-01 14:14:49','2014-10-07 18:39:32','2014-10-01 19:14:50'),(5,1,'::1','2014-10-01 14:15:29','2014-10-07 18:39:32','2014-10-01 19:15:30'),(6,1,'::1','2014-10-01 14:16:47','2014-10-01 19:34:35','2014-10-01 19:34:32'),(7,1,'::1','2014-10-01 14:34:40','2014-10-01 22:25:40','2014-10-01 22:25:35'),(8,1,'::1','2014-10-01 17:25:47','2014-10-03 00:42:02','2014-10-03 00:41:09'),(9,1,'::1','2014-10-02 19:42:08','2014-10-06 19:29:58','2014-10-03 16:48:38'),(10,1,'::1','2014-10-06 14:30:18','2014-10-13 19:24:41','2014-10-09 21:23:09'),(11,1,'::1','2014-10-08 14:20:08','2014-10-16 21:39:46','2014-10-08 19:20:18'),(12,1,'::1','2014-10-13 14:24:48','2014-10-13 19:29:55','2014-10-13 19:29:50'),(13,1,'::1','2014-10-13 14:30:00','2014-10-13 19:32:11','2014-10-13 19:32:08'),(14,1,'::1','2014-10-13 14:32:17','2014-10-13 19:33:28','2014-10-13 19:33:24'),(15,1,'::1','2014-10-13 14:33:33','2014-10-20 16:44:20','2014-10-16 23:31:46'),(16,1,'::1','2014-10-20 12:44:29','2015-06-27 22:04:27','2014-10-23 19:21:41'),(17,1,'::1','2015-06-23 16:52:52','2015-06-23 21:53:43','2015-06-23 21:53:11'),(18,1,'::1','2015-06-23 16:53:48','2015-06-23 21:55:39','2015-06-23 21:54:34'),(19,1,'::1','2015-06-23 16:55:44','2015-06-23 22:04:28','2015-06-23 22:04:06'),(20,1,'::1','2015-06-23 17:04:36','2015-06-23 22:05:26','2015-06-23 22:05:23'),(21,1,'::1','2015-06-23 17:05:33','2015-06-24 19:16:17','2015-06-24 19:16:10'),(22,1,'::1','2015-06-24 14:16:22','2015-06-27 22:04:27','2015-06-25 22:01:35'),(23,1,'127.0.0.1','2015-06-27 08:30:40','2015-06-27 22:05:14','2015-06-27 22:06:27'),(24,1,'127.0.0.1','2015-06-27 17:06:27','2015-06-27 22:10:23','2015-06-27 22:09:10'),(25,1,'127.0.0.1','2015-06-27 17:10:57','2015-07-20 14:41:50','2015-07-02 12:56:50'),(26,1,'127.0.0.1','2015-07-20 09:41:59','2015-07-20 21:42:56','2015-07-20 21:42:51'),(27,1,'127.0.0.1','2015-07-20 16:43:05','2015-07-20 21:54:42','2015-07-20 21:54:27'),(28,1,'127.0.0.1','2015-07-20 16:54:46','2015-07-21 19:43:30','2015-07-21 19:39:33'),(29,1,'127.0.0.1','2015-07-21 14:43:37','2015-07-21 19:44:04','2015-07-21 19:43:59'),(30,1,'127.0.0.1','2015-07-21 14:44:11','2015-07-21 19:44:53','2015-07-21 19:44:43'),(31,1,'127.0.0.1','2015-07-21 14:46:43','2015-07-21 21:04:37','2015-07-21 21:04:33'),(32,1,'127.0.0.1','2015-07-21 16:04:43','2015-07-21 21:05:16','2015-07-21 21:05:11'),(33,1,'127.0.0.1','2015-07-21 16:05:20','2015-07-22 22:51:58','2015-07-22 22:51:16'),(34,1,'127.0.0.1','2015-07-22 17:52:18','2015-07-22 22:53:35','2015-07-22 22:53:30'),(35,1,'127.0.0.1','2015-07-23 14:47:01','2015-07-24 04:14:20','2015-07-24 04:13:14'),(36,1,'127.0.0.1','2015-07-23 23:14:41','2015-07-24 04:15:50','2015-07-24 04:15:40'),(37,1,'127.0.0.1','2015-07-23 23:16:01','2015-07-24 18:38:22','2015-07-24 18:38:18'),(38,1,'127.0.0.1','2015-07-24 13:38:27','2015-08-01 23:35:19','2015-07-26 08:39:53'),(39,1,'127.0.0.1','2015-08-01 06:51:52','2015-09-22 13:28:07','2015-08-01 23:45:37'),(40,1,'::1','2015-08-16 23:01:56','2015-08-27 04:24:54','2015-08-17 04:01:56'),(41,1,'::1','2015-08-26 23:24:57','2015-09-07 03:05:11','2015-08-27 04:27:59'),(42,1,'::1','2015-09-06 22:05:26','2015-09-11 16:24:12','2015-09-08 00:52:18'),(43,1,'::1','2015-09-11 11:24:21','2015-09-15 02:55:01','2015-09-11 17:49:32'),(44,1,'::1','2015-09-14 21:55:13','2015-09-15 03:14:15','2015-09-15 03:14:11'),(45,1,'::1','2015-09-14 22:14:20','2015-09-15 03:15:31','2015-09-15 03:15:25'),(46,1,'::1','2015-09-14 22:15:35','2015-09-15 03:17:48','2015-09-15 03:16:06'),(47,1,'::1','2015-09-14 22:17:56','2015-09-15 03:18:45','2015-09-15 03:18:20'),(48,1,'::1','2015-09-14 22:18:49','2015-09-22 13:28:07','2015-09-15 03:27:02'),(49,1,'::1','2015-09-17 06:01:56','2015-09-21 01:16:21','2015-09-18 20:25:29'),(50,1,'::1','2015-09-20 20:16:28','2015-09-25 17:36:47','2015-09-22 13:32:29'),(51,1,'::1','2015-09-25 12:36:55','2015-09-28 01:05:01','2015-09-25 20:53:29'),(52,1,'::1','2015-09-27 20:05:07','2015-10-02 16:54:33','2015-09-28 01:05:47'),(53,1,'::1','2015-10-02 11:54:39','2015-10-29 21:29:18','2015-10-04 16:51:41'),(54,1,'::1','2015-10-23 08:48:51','2015-10-25 15:39:00','2015-10-23 15:49:45'),(55,1,'::1','2015-10-25 12:39:04','2015-10-28 14:28:19','2015-10-25 15:39:31'),(56,1,'::1','2015-10-28 11:28:23','2015-11-08 19:16:38','2015-10-30 13:31:31'),(57,1,'::1','2015-11-08 16:16:52','2015-11-14 10:10:04','2015-11-11 02:13:53'),(58,1,'127.0.0.1','2015-11-14 06:42:58','2016-02-05 00:38:53','2015-11-14 19:20:17'),(59,1,'::1','2015-11-15 09:56:46','2015-11-19 20:27:10','2015-11-16 07:03:52'),(60,1,'::1','2015-11-15 10:38:59','2016-02-05 00:38:53','2015-11-15 16:21:58'),(61,1,'::1','2015-11-19 20:27:18','2015-12-01 01:43:39','2015-11-19 21:24:58'),(62,1,'::1','2015-11-30 22:43:46','2015-12-04 00:58:45','2015-12-01 01:44:10'),(63,1,'::1','2015-12-03 21:59:03','2015-12-07 09:42:11','2015-12-04 00:59:15'),(64,1,'::1','2015-12-07 06:42:14','2016-02-05 00:38:53','2015-12-07 10:10:08'),(65,1,'::1','2016-01-28 11:24:00','2016-02-01 12:40:46','2016-01-29 17:30:10'),(66,1,'::1','2016-02-01 09:40:50','2016-02-05 02:16:11','2016-02-05 02:16:05'),(67,1,'::1','2016-02-04 23:16:13','2016-02-05 19:53:19','2016-02-05 19:53:16'),(68,1,'::1','2016-02-05 16:53:21','2016-02-05 20:37:05','2016-02-05 20:36:38'),(69,1,'::1','2016-02-05 17:37:06','2016-02-05 20:47:19','2016-02-05 20:47:07'),(70,1,'::1','2016-02-05 17:47:20','2016-02-06 13:10:18','2016-02-06 13:10:15'),(71,1,'::1','2016-02-06 10:10:20','2016-02-06 14:50:32','2016-02-06 14:45:08'),(72,1,'::1','2016-02-06 11:50:35','2016-02-07 12:51:46','2016-02-07 12:51:06'),(73,1,'::1','2016-02-07 09:51:47','2016-02-07 12:52:20','2016-02-07 12:52:00'),(74,1,'::1','2016-02-07 09:52:21','2016-02-07 13:01:15','2016-02-07 13:00:59'),(75,1,'::1','2016-02-07 10:01:17','2016-02-08 00:39:40','2016-02-08 00:39:28'),(76,1,'::1','2016-02-07 21:39:41','2016-02-12 14:53:51','2016-02-08 12:42:32'),(77,1,'::1','2016-02-12 11:55:41','2016-02-16 13:47:56','2016-02-12 15:08:34'),(78,1,'::1','2016-02-16 10:47:59','2016-02-16 17:54:42','2016-02-16 17:54:30'),(79,1,'::1','2016-02-16 14:54:45','2016-02-16 18:22:07','2016-02-16 18:22:01'),(80,1,'::1','2016-02-16 15:22:09','2016-02-16 18:22:56','2016-02-16 18:22:51'),(81,1,'::1','2016-02-16 15:23:11','2016-02-28 20:46:21','2016-02-16 18:23:21'),(82,1,'::1','2016-02-16 15:31:08','2016-02-19 16:29:25','2016-02-17 02:07:22'),(83,1,'::1','2016-02-19 13:29:42','2016-02-19 20:11:18','2016-02-19 20:11:15'),(84,1,'::1','2016-02-19 17:11:20','2016-02-19 20:21:49','2016-02-19 20:21:47'),(85,1,'::1','2016-02-19 17:21:50','2016-02-19 20:25:32','2016-02-19 20:25:29'),(86,1,'::1','2016-02-19 17:25:33','2016-02-19 20:26:22','2016-02-19 20:26:19'),(87,1,'::1','2016-02-19 17:26:24','2016-02-19 20:26:42','2016-02-19 20:26:38'),(88,1,'::1','2016-02-19 17:26:43','2016-02-20 14:11:06','2016-02-20 14:10:59'),(89,1,'::1','2016-02-20 11:11:07','2016-02-20 21:55:38','2016-02-20 21:55:34'),(90,1,'::1','2016-02-20 18:55:39','2016-02-20 22:29:33','2016-02-20 22:29:30'),(91,1,'::1','2016-02-20 19:29:34','2016-03-05 19:35:48','2016-02-20 22:39:00'),(92,1,'::1','2016-02-27 18:48:08','2016-02-27 22:58:43','2016-02-27 22:58:41'),(93,11,'::1','2016-02-27 18:58:54','2016-02-27 22:59:00','2016-02-27 22:58:54'),(94,1,'::1','2016-02-27 18:59:02','2016-02-27 22:59:12','2016-02-27 22:59:09'),(95,11,'::1','2016-02-27 18:59:16','2016-03-04 02:41:13','2016-03-04 02:41:10'),(96,1,'::1','2016-02-28 16:46:27','2016-03-09 06:43:11','2016-03-09 06:42:58'),(97,11,'::1','2016-03-03 22:41:20','2016-03-04 02:45:17','2016-03-04 02:45:09'),(98,11,'::1','2016-03-03 22:45:19','2016-03-06 18:35:25','2016-03-06 18:35:17'),(99,11,'::1','2016-03-06 14:35:30','2016-03-09 06:42:16','2016-03-09 06:42:12'),(100,11,'::1','2016-03-09 02:42:20','2016-03-09 06:43:39','2016-03-09 06:43:36'),(101,11,'::1','2016-03-09 02:43:16','2016-03-09 15:10:12','2016-03-09 15:10:03'),(102,11,'::1','2016-03-09 02:43:50','2016-03-09 06:45:50','2016-03-09 06:45:44'),(103,11,'::1','2016-03-09 02:45:52','2016-03-09 06:52:01','2016-03-09 06:51:42'),(104,11,'::1','2016-03-09 02:52:04','2016-03-09 15:37:01','2016-03-09 15:36:42'),(105,1,'::1','2016-03-09 11:10:16','2016-03-14 15:52:57','2016-03-09 21:50:03'),(106,11,'::1','2016-03-09 11:37:03','2016-03-09 15:46:11','2016-03-09 15:46:02'),(107,11,'::1','2016-03-09 11:46:13','2016-03-09 16:22:29','2016-03-09 16:22:26'),(108,11,'::1','2016-03-09 12:22:33','2016-03-13 20:38:44','2016-03-09 21:48:18'),(109,11,'::1','2016-03-13 16:38:50','2016-03-13 20:46:03','2016-03-13 20:45:59'),(110,12,'::1','2016-03-13 16:46:10','2016-03-19 23:52:40','2016-03-17 05:51:38'),(111,1,'::1','2016-03-14 11:53:02','2016-03-20 19:10:58','2016-03-14 15:54:28'),(112,1,'::1','2016-03-19 19:53:44','2016-03-24 15:57:53','2016-03-21 13:36:56'),(113,11,'::1','2016-03-20 11:02:59','2016-03-22 04:14:52','2016-03-22 04:14:49'),(114,1,'::1','2016-03-22 00:14:56','2016-03-27 00:16:13','2016-03-22 04:15:02'),(115,1,'::1','2016-03-24 11:57:55','2016-03-26 23:50:05','2016-03-24 19:34:12'),(116,1,'::1','2016-03-26 19:50:07','2016-03-27 00:32:13','2016-03-27 00:32:06'),(117,11,'::1','2016-03-26 20:32:16','2016-03-29 16:20:40','2016-03-27 00:34:53'),(118,1,'::1','2016-03-29 11:20:24','2016-04-01 01:08:22','2016-04-01 01:08:14'),(119,11,'::1','2016-03-29 11:20:38','2016-04-14 04:06:36','2016-03-30 02:10:59'),(120,12,'::1','2016-03-31 20:08:28','2016-04-01 01:08:59','2016-04-01 01:08:47'),(121,1,'::1','2016-03-31 20:09:08','2016-04-01 01:10:20','2016-04-01 01:10:05'),(122,1,'::1','2016-03-31 20:10:22','2016-04-01 01:10:46','2016-04-01 01:10:22'),(123,1,'::1','2016-03-31 20:11:14','2016-04-01 01:11:28','2016-04-01 01:11:20'),(124,1,'::1','2016-03-31 20:11:42','2016-04-01 01:12:22','2016-04-01 01:12:16'),(125,12,'::1','2016-03-31 20:12:30','2016-04-01 01:23:23','2016-04-01 01:23:19'),(126,12,'::1','2016-03-31 20:23:31','2016-04-04 04:03:03','2016-04-01 01:33:42'),(127,1,'::1','2016-04-03 23:03:10','2016-04-09 03:58:31','2016-04-04 04:07:11'),(128,1,'::1','2016-04-08 22:58:33','2016-04-12 05:33:16','2016-04-09 15:11:42'),(129,1,'::1','2016-04-12 00:33:18','2016-04-16 23:37:22','2016-04-14 08:10:50'),(130,1,'::1','2016-04-16 18:37:24','2016-05-05 02:34:20','2016-04-17 00:16:40'),(131,1,'::1','2016-04-28 15:31:17','2016-05-01 15:25:52','2016-04-28 20:52:55'),(132,1,'::1','2016-05-01 10:25:56','2016-05-07 20:03:47','2016-05-05 03:35:20'),(133,1,'::1','2016-05-07 15:04:07','2016-05-15 12:48:23','2016-05-08 21:35:27'),(134,1,'::1','2016-05-15 07:48:25','2016-05-19 03:53:25','2016-05-19 03:53:18'),(135,1,'::1','2016-05-18 22:53:26','2016-05-22 15:15:19','2016-05-19 03:57:27'),(136,1,'::1','2016-05-18 22:55:17','2016-05-30 00:08:21','2016-05-19 03:57:56'),(137,1,'::1','2016-05-22 10:15:22','2016-05-30 00:08:21','2016-05-22 15:20:57'),(138,1,'::1','2016-05-29 19:06:45','0000-00-00 00:00:00','2016-05-30 21:57:29'),(139,1,'::1','2016-06-01 23:45:24','2016-06-11 11:29:41','2016-06-03 05:56:25'),(140,1,'::1','2016-06-11 06:29:47','0000-00-00 00:00:00','2016-06-11 11:32:32'),(141,1,'192.168.57.1','2020-11-09 21:14:23','2020-11-09 21:57:13','2020-11-09 21:55:43'),(142,1,'192.168.57.1','2020-11-09 21:57:18','2020-11-09 21:59:45','2020-11-09 21:59:37'),(143,1,'192.168.57.1','2020-11-09 21:59:57','0000-00-00 00:00:00','2020-11-09 22:01:41'),(144,1,'192.168.57.1','2020-11-09 22:26:58','2020-11-09 22:47:29','2020-11-09 22:39:33'),(145,1,'192.168.57.1','2020-11-09 22:47:48','2020-11-09 22:49:18','2020-11-09 22:49:14'),(146,1,'192.168.57.1','2020-11-09 22:50:21','2020-11-09 22:52:07','2020-11-09 22:52:02'),(147,1,'192.168.57.1','2020-11-09 22:52:12','2020-11-09 22:52:30','2020-11-09 22:52:15'),(148,1,'192.168.57.1','2020-11-10 20:28:50','2020-11-18 21:27:52','2020-11-10 20:49:44'),(149,1,'192.168.57.1','2020-11-18 21:28:22','2020-11-25 20:28:20','2020-11-18 21:29:03'),(150,1,'192.168.57.1','2020-11-25 20:29:07','2021-02-10 21:10:18','2020-11-25 21:18:09'),(151,1,'192.168.57.1','2021-02-10 21:10:31','0000-00-00 00:00:00','2021-02-10 21:13:59'),(152,1,'192.168.57.1','2021-10-07 14:49:13','0000-00-00 00:00:00','2021-10-07 14:49:29'),(153,1,'192.168.57.1','2021-10-14 19:47:21','2021-10-14 20:27:19','2021-10-14 20:16:44'),(154,1,'192.168.57.1','2021-10-14 20:28:24','2021-10-20 10:20:16','2021-10-14 20:33:08'),(155,1,'192.168.57.1','2021-10-20 10:20:37','2021-10-20 11:09:30','2021-10-20 11:01:29'),(156,1,'192.168.57.1','2021-11-04 15:37:06','2021-11-17 08:40:39','2021-11-04 15:51:44'),(157,1,'192.168.57.1','2021-11-17 08:40:45','2021-11-25 20:53:06','2021-11-18 20:31:54'),(158,1,'192.168.57.1','2021-11-25 20:53:08','2021-12-09 20:10:32','2021-11-25 21:20:17'),(159,1,'192.168.57.1','2021-12-09 20:10:34','0000-00-00 00:00:00','2021-12-09 22:14:20'),(160,1,'192.168.57.1','2021-12-09 23:19:44','0000-00-00 00:00:00','2021-12-09 23:41:37'),(161,1,'192.168.57.1','2023-05-25 18:45:34','2023-06-14 23:52:37','2023-05-25 20:32:46'),(162,1,'192.168.57.1','2023-06-14 23:52:39','0000-00-00 00:00:00','2023-06-14 23:55:30'),(163,1,'192.168.100.101','2024-07-02 13:10:01','0000-00-00 00:00:00','2024-07-02 13:53:36'),(164,1,'192.168.56.1','2024-09-18 11:41:52','0000-00-00 00:00:00','2024-09-18 11:44:28'),(165,1,'192.168.56.1','2024-10-23 09:38:22','0000-00-00 00:00:00','2024-10-23 09:47:33'),(166,1,'192.168.56.1','2025-02-24 20:05:54','0000-00-00 00:00:00','2025-02-24 20:14:16'),(167,1,'192.168.56.1','2025-05-07 18:47:39','0000-00-00 00:00:00','2025-05-07 20:19:09'),(168,1,'192.168.56.1','2025-05-21 13:11:46','0000-00-00 00:00:00','2025-05-21 15:53:28'),(169,1,'192.168.1.7','2025-10-10 16:30:28','2025-10-10 16:41:21','2025-10-10 16:41:14'),(170,1,'192.168.1.7','2025-10-10 16:41:30','2025-10-10 16:42:01','2025-10-10 16:41:58'),(171,1,'192.168.1.7','2025-10-10 16:42:07','0000-00-00 00:00:00','2025-10-10 16:42:07'),(172,1,'192.168.1.7','2025-10-10 16:42:07','2025-10-10 16:42:19','2025-10-10 16:42:18'),(173,1,'192.168.1.7','2025-10-10 16:42:26','2025-10-10 16:43:29','2025-10-10 16:43:18'),(174,1,'192.168.1.7','2025-10-10 16:43:35','0000-00-00 00:00:00','2025-10-10 16:50:37');
/*!40000 ALTER TABLE `dotp_user_access_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_user_events`
--

DROP TABLE IF EXISTS `dotp_user_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_user_events` (
  `user_id` int NOT NULL DEFAULT '0',
  `event_id` int NOT NULL DEFAULT '0',
  KEY `uek1` (`user_id`,`event_id`),
  KEY `uek2` (`event_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_user_events`
--

LOCK TABLES `dotp_user_events` WRITE;
/*!40000 ALTER TABLE `dotp_user_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_user_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_user_preferences`
--

DROP TABLE IF EXISTS `dotp_user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_user_preferences` (
  `pref_user` varchar(12) NOT NULL DEFAULT '',
  `pref_name` varchar(72) NOT NULL DEFAULT '',
  `pref_value` varchar(32) NOT NULL DEFAULT '',
  KEY `pref_user` (`pref_user`,`pref_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_user_preferences`
--

LOCK TABLES `dotp_user_preferences` WRITE;
/*!40000 ALTER TABLE `dotp_user_preferences` DISABLE KEYS */;
INSERT INTO `dotp_user_preferences` VALUES ('0','USERFORMAT','user'),('11','LOCALE','en_US'),('0','LOCALE','pt_br'),('0','TABVIEW','0'),('0','SHDATEFORMAT','%d/%m/%Y'),('0','TIMEFORMAT','%I:%M %p'),('0','CURRENCYFORM','en_AU'),('0','UISTYLE','dotproject_plus'),('0','TASKASSIGNMAX','100'),('0','EVENTFILTER','my'),('0','MAILALL','0'),('0','TASKLOGEMAIL','0'),('0','TASKLOGSUBJ',''),('0','TASKLOGNOTE','0'),('0','USEDIGESTS','0');
/*!40000 ALTER TABLE `dotp_user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_user_roles`
--

DROP TABLE IF EXISTS `dotp_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_user_roles` (
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `role_id` int unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_user_roles`
--

LOCK TABLES `dotp_user_roles` WRITE;
/*!40000 ALTER TABLE `dotp_user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_user_task_pin`
--

DROP TABLE IF EXISTS `dotp_user_task_pin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_user_task_pin` (
  `user_id` int NOT NULL DEFAULT '0',
  `task_id` int NOT NULL DEFAULT '0',
  `task_pinned` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_user_task_pin`
--

LOCK TABLES `dotp_user_task_pin` WRITE;
/*!40000 ALTER TABLE `dotp_user_task_pin` DISABLE KEYS */;
/*!40000 ALTER TABLE `dotp_user_task_pin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_user_tasks`
--

DROP TABLE IF EXISTS `dotp_user_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_user_tasks` (
  `user_id` int NOT NULL DEFAULT '0',
  `user_type` tinyint NOT NULL DEFAULT '0',
  `task_id` int NOT NULL DEFAULT '0',
  `perc_assignment` int NOT NULL DEFAULT '100',
  `user_task_priority` tinyint DEFAULT '0',
  PRIMARY KEY (`user_id`,`task_id`),
  KEY `user_type` (`user_type`),
  KEY `idx_user_tasks` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_user_tasks`
--

LOCK TABLES `dotp_user_tasks` WRITE;
/*!40000 ALTER TABLE `dotp_user_tasks` DISABLE KEYS */;
INSERT INTO `dotp_user_tasks` VALUES (2,0,3,100,0),(2,0,42,100,0),(2,0,66,100,0),(2,0,67,100,0),(2,0,79,100,0),(2,0,128,100,0),(3,0,1,100,0),(3,0,2,100,0),(3,0,3,100,0),(3,0,4,100,0),(3,0,32,100,0),(3,0,50,100,0),(3,0,66,100,0),(3,0,79,100,0),(7,0,34,100,0),(7,0,79,100,0),(8,0,79,100,0),(9,0,79,100,0),(13,0,120,100,0),(13,0,121,100,0),(14,0,119,100,0),(14,0,122,100,0);
/*!40000 ALTER TABLE `dotp_user_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_users`
--

DROP TABLE IF EXISTS `dotp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_contact` int NOT NULL DEFAULT '0',
  `user_username` varchar(255) NOT NULL DEFAULT '',
  `user_password` varchar(255) DEFAULT NULL,
  `user_parent` int NOT NULL DEFAULT '0',
  `user_type` tinyint NOT NULL DEFAULT '0',
  `user_company` int DEFAULT '0',
  `user_department` int DEFAULT '0',
  `user_owner` int NOT NULL DEFAULT '0',
  `user_signature` text,
  PRIMARY KEY (`user_id`),
  KEY `idx_uid` (`user_username`),
  KEY `idx_pwd` (`user_password`),
  KEY `idx_user_parent` (`user_parent`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_users`
--

LOCK TABLES `dotp_users` WRITE;
/*!40000 ALTER TABLE `dotp_users` DISABLE KEYS */;
INSERT INTO `dotp_users` VALUES (1,1,'admin','$2y$12$pxkK2fPsXHw91i6.oIAWMeLSLyped25p6w3KfyVzpWYLAzmqaGGo2',0,1,0,0,0,''),(2,2,'Lula Molusco','d41d8cd98f00b204e9800998ecf8427e',0,0,1,0,0,NULL),(3,3,'Bob Esponja','d41d8cd98f00b204e9800998ecf8427e',0,0,1,0,0,NULL),(4,4,'B B_Sobrenome','d41d8cd98f00b204e9800998ecf8427e',0,0,2,0,0,NULL),(5,5,'A A_Sobrenome','d41d8cd98f00b204e9800998ecf8427e',0,0,2,0,0,NULL),(6,6,'C C_Sobrenome','d41d8cd98f00b204e9800998ecf8427e',0,0,2,0,0,NULL),(7,10,'Patrick Estrela','d41d8cd98f00b204e9800998ecf8427e',0,0,1,0,0,NULL),(8,11,'Gary Caracol','d41d8cd98f00b204e9800998ecf8427e',0,0,1,0,0,NULL),(9,12,'Sr. Siriguejo','d41d8cd98f00b204e9800998ecf8427e',0,0,1,0,0,NULL),(10,17,'Ciclano beltrano','d41d8cd98f00b204e9800998ecf8427e',0,0,2,0,0,NULL),(11,19,'admin_en','76a2173be6393254e72ffa4d6df1030a',0,1,0,0,0,NULL),(12,20,'group_1','81dc9bdb52d04dc20036dbd8313ed055',0,0,0,0,0,NULL),(13,21,'Sponge Bob','d41d8cd98f00b204e9800998ecf8427e',0,0,4,0,0,NULL),(14,22,'Patrick Star','d41d8cd98f00b204e9800998ecf8427e',0,0,4,0,0,NULL),(15,24,'Goku SS','d41d8cd98f00b204e9800998ecf8427e',0,0,3,0,0,NULL),(16,25,'Vedita SS','d41d8cd98f00b204e9800998ecf8427e',0,0,3,0,0,NULL),(17,27,'Aluno 1 BSI18','d41d8cd98f00b204e9800998ecf8427e',0,0,6,0,0,NULL),(18,28,'Aluno 2 BSI18','d41d8cd98f00b204e9800998ecf8427e',0,0,6,0,0,NULL),(20,30,'AndrÃ© Fabiano de Moraes','d41d8cd98f00b204e9800998ecf8427e',0,0,7,0,0,NULL),(21,31,'Bruno Ribas','d41d8cd98f00b204e9800998ecf8427e',0,0,1,0,0,NULL);
/*!40000 ALTER TABLE `dotp_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dotp_wbs_dictionary`
--

DROP TABLE IF EXISTS `dotp_wbs_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dotp_wbs_dictionary` (
  `wbs_item_id` int NOT NULL,
  `description` text,
  PRIMARY KEY (`wbs_item_id`),
  CONSTRAINT `FK_WBS_ITEM_DICTIONARY` FOREIGN KEY (`wbs_item_id`) REFERENCES `dotp_project_eap_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dotp_wbs_dictionary`
--

LOCK TABLES `dotp_wbs_dictionary` WRITE;
/*!40000 ALTER TABLE `dotp_wbs_dictionary` DISABLE KEYS */;
INSERT INTO `dotp_wbs_dictionary` VALUES (79,'O sistema deve proporcionar que clientes possam realizar pedidos online, e que os entregadores possam consultar os dados dos pedidos por meio de dispositivos móveis.'),(80,'Inclui os documentos das diferentes versões do plano de projeto, os documentos de acompanhamento do projeto, as solicitações de mudança, o termo de abertura etc.'),(82,'O modelo do sistema é base para o desenvolvimento dos seus módulos. O modelo inclui os protótipos de telas, os diagramas de Entidade- Relacionamento (ER), e os diagramas de caso de uso, classe, e sequência utilizando a notaçã UML.'),(83,'O produto de software que será entregue ao término do projeto.'),(84,'O módulo web é integrado junto ao site de pizzaria. São acessado pelos clientes e por funcionários. Os clientes utilizam-no para se cadastrarem e realizarem pedidos. Os funcionários utilizam-no para consultar os pedidos já realizados.'),(85,'O módulo para dispositivo móvel é utilizado pelos entregadores da pizzaria. Seu objetivo é proporcionar fácil acesso às informações dos pedidos em aberto.'),(86,'Etapa do projeto após o desenvolvimento. É marcada pelo treinamento dos usuários e pela instalação do aplicativo.'),(87,'Capacitação presencial realizada para instruir os usuários do sistema sobre os procedimentos adequados para operá-lo.'),(88,'Após obter o aceite formal pelos usuários, o sistema desenvolvido será publicado em ambiente produtivo.'),(89,'Etapa do projeto em que o app desenvolvido para dispositivos móveis é instalado nos dispositivos dos entregadores.'),(90,'O site da pizzaria contendo uma tela para o cadastro de clientes e realização de pedidos.'),(93,'A consulta de detalhes do pedido deve prover para cada consulta em aberto informações como a hora de abertura do pedido, o endereço de entrega, e o telefone do cliente.'),(94,'O relatório de consulta a pedidos é utilizado pelos atendentes e administradores da pizzaria. Os relatórios apresentam informações dos pedidos ainda em aberto e do histórico de pedidos já realizados.'),(96,'Tela que em os clientes podem castrar-se e realizar pedidos de pizzas.'),(97,'Conjunto de funcionalidades que sÃ£o consideradas base para o funcionamento das demais partes do sistema.'),(98,'Um componente de software que é integrado aos módulos web e mobile. Provê a funcionalidade de autenticar clientes, atendentes e entregadores da pizzaria.'),(99,'É uma parte do módulo web que proporciona suporte ao registro de pedidos diretamente a partir do site. Ele proporciona ao cliente comprar uma ou mais pizzas e escolher seus respectivos sabores e tamanhos.'),(100,'O cadastro de clientes é um requisito para que o cadastro de pedidos possa ser efetuado. Todo cliente que deseja realizar um pedido online deve estar cadastrado no sistema. O cadastro envolve a disponibilização de informações do cliente como nome, e-mail, telefone, e endereço.'),(101,'São telas que demonstram como as informações ficam dispostas para visualização e para entrada de dados. Os protótipos auxiliam na análise dos requisitos.'),(102,'Desenhos técnicos que definem a estrutura e o comportamento do sistema. Os diagramas são realizados antes do início da programação, e atualizados sempre que mudanças afetarem o projeto.'),(103,'Documentação das característica do produto. São registradas as funcionalidades e as restrições tecnológicas esperadas.'),(104,'Etapa do projeto para realização da reuniÃµo de pos mortem e documentação de lições aprendidas.'),(105,'Etapa do projeto para acompanhar o desempenho da execução em relação plano do projeto.'),(106,'Grupo de resultados gerados após o iní­cio da execução do projeto.'),(107,'O plano do projeto é um documento composto pelo plano de escopo, tempo, custo, recursos humanos, comunicação, riscos, stakeholders, qualidade, e aquisição.'),(108,'Conjunto de documentos que registram as aquisições realizadas ao longo do projeto.'),(109,'Técnica de verificação da conformidade do processo.'),(110,'Técnica de verificação da conformidade do produto.'),(111,'Documentos formais com os pedidos de solicitações de mudanças realizados por clientes ou pelo gerente do projeto como pedido para ações corretivas.'),(112,'Documentos gerados periodicamente por reuniões que avaliam os resultados produzidos em relação aos resultados planejados nas perspectivas de tempo, custo, e escopo.'),(113,'Registro da reunião de encerramento do projeto confrontando as restrições de tempo, custo e escopo reais e planejados.'),(114,'Registros de aspectos positivos ou negativos do que ocorreram no projeto, os quais podem colaborar para execução de futuros projetos.'),(115,'Documento assinado pelo cliente após a entrega do projeto.'),(158,'A system that suppot customers to perform their requests, and employess to check this requests using mobile phones.'),(159,'All documentation related to project scope and struture.'),(160,'All set of activities and documentation produced to plan and monitor the project during its execution.'),(161,'An integrated document containg the planning for each of the 10 knowledge areas.');
/*!40000 ALTER TABLE `dotp_wbs_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2025_10_15_014142_alter_user_password_column_in_dotp_users_table',1),(2,'2026_02_24_012139_create_dotp_skills_tables',1),(3,'2026_03_02_165141_create_dotp_raci_table',1),(4,'2026_03_04_195134_create_dotp_hr_performance_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-02 15:42:28
