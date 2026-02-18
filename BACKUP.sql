-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistema_ventas
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `categoria_id` int NOT NULL AUTO_INCREMENT,
  `tipo_producto` varchar(150) NOT NULL,
  PRIMARY KEY (`categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Electrónica'),(2,'Hogar');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `cliente_id` int NOT NULL AUTO_INCREMENT,
  `apellido` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `genero` enum('F','M','O') NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_alta` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(30) DEFAULT 'ACTIVO',
  PRIMARY KEY (`cliente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Martinez','Lucía','F','Calle 10','lucia1@mail.com','1995-04-10','2026-02-17 18:15:46','ACTIVO'),(2,'Sosa','Carlos','M','Calle 11','carlos2@mail.com','1990-07-22','2026-02-17 18:15:46','ACTIVO'),(3,'Fernandez','Ana','F','Calle 12','ana3@mail.com','1987-09-15','2026-02-17 18:15:46','ACTIVO'),(4,'Ramirez','Jorge','M','Calle 13','jorge4@mail.com','1993-01-30','2026-02-17 18:15:46','ACTIVO'),(5,'Diaz','Camila','F','Calle 14','camila5@mail.com','1998-12-11','2026-02-17 18:15:46','ACTIVO'),(6,'Torres','Miguel','M','Calle 15','miguel6@mail.com','1985-06-05','2026-02-17 18:15:46','ACTIVO'),(7,'Vega','Sofía','F','Calle 16','sofia7@mail.com','1991-03-19','2026-02-17 18:15:46','ACTIVO'),(8,'Castro','Pablo','M','Calle 17','pablo8@mail.com','1989-08-27','2026-02-17 18:15:46','ACTIVO'),(9,'Rojas','Valentina','F','Calle 18','vale9@mail.com','1996-02-14','2026-02-17 18:15:46','ACTIVO'),(10,'Silva','Diego','M','Calle 19','diego10@mail.com','1994-05-21','2026-02-17 18:15:46','ACTIVO'),(11,'Morales','Julieta','F','Calle 20','julieta11@mail.com','1997-11-03','2026-02-17 18:15:46','ACTIVO'),(12,'Herrera','Lucas','M','Calle 21','lucas12@mail.com','1992-10-08','2026-02-17 18:15:46','ACTIVO'),(13,'Suarez','Paula','F','Calle 22','paula13@mail.com','1990-04-01','2026-02-17 18:15:46','ACTIVO'),(14,'Mendez','Andrés','M','Calle 23','andres14@mail.com','1986-12-17','2026-02-17 18:15:46','ACTIVO'),(15,'Gimenez','Carla','F','Calle 24','carla15@mail.com','1999-07-07','2026-02-17 18:15:46','ACTIVO'),(16,'Navarro','Marcos','M','Calle 25','marcos16@mail.com','1988-01-13','2026-02-17 18:15:46','ACTIVO'),(17,'Ortiz','Florencia','F','Calle 26','flor17@mail.com','1993-09-29','2026-02-17 18:15:46','ACTIVO'),(18,'Peralta','Ezequiel','M','Calle 27','eze18@mail.com','1991-06-16','2026-02-17 18:15:46','ACTIVO'),(19,'Acosta','Brenda','F','Calle 28','brenda19@mail.com','1995-08-12','2026-02-17 18:15:46','ACTIVO'),(20,'Benitez','Franco','M','Calle 29','franco20@mail.com','1994-03-02','2026-02-17 18:15:46','ACTIVO');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `compra_id` int NOT NULL AUTO_INCREMENT,
  `proveedor_id` int DEFAULT NULL,
  `fecha_compra` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(12,2) DEFAULT NULL,
  `estado_pago` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`compra_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,1,'2026-02-17 15:15:46',200000.00,'PAGADO'),(2,2,'2026-02-17 15:24:07',150000.00,'PAGADO'),(3,3,'2026-02-17 15:24:07',90000.00,'PAGADO'),(4,4,'2026-02-17 15:24:07',120000.00,'PAGADO'),(5,5,'2026-02-17 15:24:07',80000.00,'PAGADO');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposito`
--

DROP TABLE IF EXISTS `deposito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deposito` (
  `deposito_id` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(200) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`deposito_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposito`
--

LOCK TABLES `deposito` WRITE;
/*!40000 ALTER TABLE `deposito` DISABLE KEYS */;
INSERT INTO `deposito` VALUES (1,'Depósito Central','Principal'),(2,'Depósito Secundario','Auxiliar');
/*!40000 ALTER TABLE `deposito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_compra` (
  `detallec_id` int NOT NULL AUTO_INCREMENT,
  `compra_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  PRIMARY KEY (`detallec_id`),
  KEY `compra_id` (`compra_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compra` (`compra_id`),
  CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compra`
--

LOCK TABLES `detalle_compra` WRITE;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` VALUES (1,1,1,20,10000.00,200000.00),(2,2,2,10,20000.00,200000.00),(3,2,3,15,8000.00,120000.00),(4,3,4,5,60000.00,300000.00),(5,3,5,12,7000.00,84000.00),(6,4,6,8,15000.00,120000.00),(7,4,7,4,90000.00,360000.00),(8,5,8,6,250000.00,1500000.00),(9,5,9,10,120000.00,1200000.00);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta` (
  `detallev_id` int NOT NULL AUTO_INCREMENT,
  `venta_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  PRIMARY KEY (`detallev_id`),
  KEY `venta_id` (`venta_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`venta_id`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (1,1,1,2,13000.00,26000.00),(2,2,2,2,25000.00,50000.00),(3,3,1,5,13000.00,65000.00),(4,4,3,10,12000.00,120000.00),(5,5,4,3,80000.00,240000.00),(6,6,1,3,13000.00,39000.00),(7,7,2,2,25000.00,50000.00),(8,8,1,2,13000.00,26000.00),(9,9,2,1,25000.00,25000.00),(10,10,1,6,13000.00,78000.00),(11,11,2,1,25000.00,25000.00),(12,12,1,3,13000.00,39000.00),(13,13,2,1,25000.00,25000.00),(14,14,1,4,13000.00,52000.00),(15,15,2,1,25000.00,25000.00),(16,16,1,1,13000.00,13000.00),(17,17,2,1,25000.00,25000.00),(18,18,1,1,13000.00,13000.00),(19,19,2,1,25000.00,25000.00),(20,20,1,3,13000.00,39000.00);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envio`
--

DROP TABLE IF EXISTS `envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envio` (
  `envio_id` int NOT NULL AUTO_INCREMENT,
  `costo_envio` decimal(10,2) DEFAULT NULL,
  `fecha_envio` date DEFAULT NULL,
  `estado_envio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`envio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envio`
--

LOCK TABLES `envio` WRITE;
/*!40000 ALTER TABLE `envio` DISABLE KEYS */;
INSERT INTO `envio` VALUES (1,1500.00,'2026-02-17','EN PREPARACIÓN'),(2,2000.00,'2026-02-17','DESPACHADO');
/*!40000 ALTER TABLE `envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_precio`
--

DROP TABLE IF EXISTS `lista_precio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista_precio` (
  `lista_id` int NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `costo_unitario` decimal(10,2) NOT NULL,
  `porcentaje_id` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`lista_id`),
  KEY `producto_id` (`producto_id`),
  KEY `porcentaje_id` (`porcentaje_id`),
  CONSTRAINT `lista_precio_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`producto_id`),
  CONSTRAINT `lista_precio_ibfk_2` FOREIGN KEY (`porcentaje_id`) REFERENCES `porcentaje_gcia` (`porcentaje_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_precio`
--

LOCK TABLES `lista_precio` WRITE;
/*!40000 ALTER TABLE `lista_precio` DISABLE KEYS */;
INSERT INTO `lista_precio` VALUES (1,1,10000.00,1,13000.00),(2,2,20000.00,2,25000.00);
/*!40000 ALTER TABLE `lista_precio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodo_pago`
--

DROP TABLE IF EXISTS `metodo_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_pago` (
  `metodo_pago_id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`metodo_pago_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_pago`
--

LOCK TABLES `metodo_pago` WRITE;
/*!40000 ALTER TABLE `metodo_pago` DISABLE KEYS */;
INSERT INTO `metodo_pago` VALUES (1,'Efectivo'),(2,'Tarjeta de Crédito');
/*!40000 ALTER TABLE `metodo_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movstock`
--

DROP TABLE IF EXISTS `movstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movstock` (
  `movimiento_id` int NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `deposito_id` int NOT NULL,
  `tipo_mov` enum('ENTRADA','SALIDA','AJUSTE') NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `compra_id` int DEFAULT NULL,
  `venta_id` int DEFAULT NULL,
  PRIMARY KEY (`movimiento_id`),
  KEY `producto_id` (`producto_id`),
  KEY `deposito_id` (`deposito_id`),
  KEY `compra_id` (`compra_id`),
  KEY `venta_id` (`venta_id`),
  CONSTRAINT `movstock_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`producto_id`),
  CONSTRAINT `movstock_ibfk_2` FOREIGN KEY (`deposito_id`) REFERENCES `deposito` (`deposito_id`),
  CONSTRAINT `movstock_ibfk_3` FOREIGN KEY (`compra_id`) REFERENCES `compra` (`compra_id`),
  CONSTRAINT `movstock_ibfk_4` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`venta_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movstock`
--

LOCK TABLES `movstock` WRITE;
/*!40000 ALTER TABLE `movstock` DISABLE KEYS */;
INSERT INTO `movstock` VALUES (1,1,1,'ENTRADA',20,'2026-02-17 15:15:46',1,NULL),(2,1,1,'SALIDA',2,'2026-02-17 15:15:46',NULL,1),(3,2,1,'ENTRADA',10,'2026-02-17 15:24:07',2,NULL),(4,3,1,'ENTRADA',15,'2026-02-17 15:24:07',2,NULL),(5,4,1,'ENTRADA',5,'2026-02-17 15:24:07',3,NULL),(6,5,1,'ENTRADA',12,'2026-02-17 15:24:07',3,NULL),(7,6,1,'ENTRADA',8,'2026-02-17 15:24:07',4,NULL),(8,7,1,'ENTRADA',4,'2026-02-17 15:24:07',4,NULL),(9,8,1,'ENTRADA',6,'2026-02-17 15:24:07',5,NULL),(10,9,1,'ENTRADA',10,'2026-02-17 15:24:07',5,NULL),(11,2,1,'SALIDA',-2,'2026-02-17 15:24:07',NULL,2),(12,1,1,'SALIDA',-5,'2026-02-17 15:24:07',NULL,3),(13,3,1,'SALIDA',-10,'2026-02-17 15:24:07',NULL,4),(14,4,1,'SALIDA',-3,'2026-02-17 15:24:07',NULL,5),(15,1,1,'SALIDA',-3,'2026-02-17 15:36:44',NULL,6),(16,2,1,'SALIDA',-2,'2026-02-17 15:36:44',NULL,7),(17,1,1,'SALIDA',-2,'2026-02-17 15:36:44',NULL,8),(18,2,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,9),(19,1,1,'SALIDA',-6,'2026-02-17 15:36:44',NULL,10),(20,2,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,11),(21,1,1,'SALIDA',-3,'2026-02-17 15:36:44',NULL,12),(22,2,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,13),(23,1,1,'SALIDA',-4,'2026-02-17 15:36:44',NULL,14),(24,2,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,15),(25,1,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,16),(26,2,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,17),(27,1,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,18),(28,2,1,'SALIDA',-1,'2026-02-17 15:36:44',NULL,19),(29,1,1,'SALIDA',-3,'2026-02-17 15:36:44',NULL,20);
/*!40000 ALTER TABLE `movstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `porcentaje_gcia`
--

DROP TABLE IF EXISTS `porcentaje_gcia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `porcentaje_gcia` (
  `porcentaje_id` int NOT NULL AUTO_INCREMENT,
  `porcentaje` decimal(5,2) NOT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`porcentaje_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `porcentaje_gcia_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `porcentaje_gcia`
--

LOCK TABLES `porcentaje_gcia` WRITE;
/*!40000 ALTER TABLE `porcentaje_gcia` DISABLE KEYS */;
INSERT INTO `porcentaje_gcia` VALUES (1,30.00,1),(2,25.00,2);
/*!40000 ALTER TABLE `porcentaje_gcia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `producto_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `stock_minimo` int DEFAULT '0',
  `categoria_id` int DEFAULT NULL,
  `reponer` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`producto_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`categoria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Mouse Gamer',10,1,1),(2,'Monitor 24\"',8,1,1),(3,'Teclado Mecánico',12,1,1),(4,'Smart TV 50\"',5,1,1),(5,'Plancha',6,2,0),(6,'Microondas',4,2,0),(7,'Heladera',3,2,0),(8,'Notebook',7,1,1),(9,'Tablet',9,1,0),(10,'Impresora',5,1,0),(11,'Cafetera',6,2,0),(12,'Ventilador',10,2,0),(13,'Parlante Bluetooth',15,1,0),(14,'Aspiradora',4,2,0),(15,'Router WiFi',8,1,0),(16,'Cargador Portátil',20,1,0),(17,'Freidora',6,2,0),(18,'Secador de Pelo',10,2,0),(19,'Smartwatch',12,1,0),(20,'Horno Eléctrico',5,2,0);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `proveedor_id` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(200) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`proveedor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Distribuidora Uno','Av 100','Argentina'),(2,'Tech Global','Av 200','Argentina'),(3,'Electro SA','Av 300','Argentina'),(4,'Hogar Total','Av 400','Argentina'),(5,'Importadora Sur','Av 500','Argentina'),(6,'Mayorista Norte','Av 600','Argentina'),(7,'Comercial Delta','Av 700','Argentina'),(8,'Logística Express','Av 800','Argentina'),(9,'Suministros SRL','Av 900','Argentina'),(10,'Distribuciones AR','Av 1000','Argentina'),(11,'Proveedor X','Av 1100','Argentina'),(12,'Proveedor Y','Av 1200','Argentina'),(13,'Proveedor Z','Av 1300','Argentina'),(14,'Electro Hogar','Av 1400','Argentina'),(15,'Tech Store','Av 1500','Argentina'),(16,'Full Import','Av 1600','Argentina'),(17,'Comercial Andina','Av 1700','Argentina'),(18,'Mercantil SA','Av 1800','Argentina'),(19,'Distribuciones Centro','Av 1900','Argentina'),(20,'Supply Chain SA','Av 2000','Argentina');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `stock_bajo`
--

DROP TABLE IF EXISTS `stock_bajo`;
/*!50001 DROP VIEW IF EXISTS `stock_bajo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `stock_bajo` AS SELECT 
 1 AS `producto_id`,
 1 AS `nombre`,
 1 AS `stock_actual`,
 1 AS `stock_minimo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedor` (
  `vendedor_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `ranking` int DEFAULT NULL,
  `comision` decimal(5,2) DEFAULT NULL,
  `zona_id` int DEFAULT NULL,
  PRIMARY KEY (`vendedor_id`),
  KEY `zona_id` (`zona_id`),
  CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`zona_id`) REFERENCES `zona_venta` (`zona_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES (1,'Sergio','Lopez',3,4.00,1),(2,'Marina','Ruiz',4,3.50,2),(3,'Gustavo','Perez',2,5.00,1),(4,'Laura','Diaz',1,6.00,2),(5,'Nicolas','Torres',5,3.00,1),(6,'Carolina','Vega',2,4.50,2),(7,'Martin','Castro',3,4.00,1),(8,'Natalia','Rojas',4,3.75,2),(9,'Facundo','Silva',2,5.25,1),(10,'Daniela','Morales',3,4.10,2),(11,'Esteban','Herrera',1,6.50,1),(12,'Romina','Suarez',5,3.20,2),(13,'Ivan','Mendez',4,3.90,1),(14,'Melina','Gimenez',2,4.80,2),(15,'Bruno','Navarro',3,4.30,1),(16,'Flor','Ortiz',1,6.00,2),(17,'Alan','Peralta',4,3.60,1),(18,'Micaela','Acosta',2,5.10,2),(19,'Tomas','Benitez',3,4.40,1),(20,'Agustina','Santos',5,3.30,2);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `venta_id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `fecha_venta` datetime DEFAULT CURRENT_TIMESTAMP,
  `metodo_pago_id` int DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  `estado_pago` varchar(50) DEFAULT NULL,
  `vendedor_id` int DEFAULT NULL,
  `envio_id` int DEFAULT NULL,
  PRIMARY KEY (`venta_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `metodo_pago_id` (`metodo_pago_id`),
  KEY `vendedor_id` (`vendedor_id`),
  KEY `envio_id` (`envio_id`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`cliente_id`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`metodo_pago_id`) REFERENCES `metodo_pago` (`metodo_pago_id`),
  CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedor` (`vendedor_id`),
  CONSTRAINT `venta_ibfk_4` FOREIGN KEY (`envio_id`) REFERENCES `envio` (`envio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (1,1,'2026-02-17 15:15:46',2,26000.00,'PAGADO',1,1),(2,2,'2026-02-17 15:24:07',1,26000.00,'PAGADO',2,2),(3,3,'2026-02-17 15:24:07',2,13000.00,'PAGADO',3,1),(4,4,'2026-02-17 15:24:07',1,50000.00,'PAGADO',4,2),(5,5,'2026-02-17 15:24:07',2,60000.00,'PAGADO',5,1),(6,1,'2026-02-17 15:36:44',2,39000.00,'PAGADO',1,1),(7,2,'2026-02-17 15:36:44',1,50000.00,'PAGADO',1,2),(8,1,'2026-02-17 15:36:44',2,26000.00,'PAGADO',2,1),(9,3,'2026-02-17 15:36:44',1,25000.00,'PAGADO',3,2),(10,4,'2026-02-17 15:36:44',2,78000.00,'PAGADO',1,1),(11,5,'2026-02-17 15:36:44',1,25000.00,'PAGADO',4,2),(12,2,'2026-02-17 15:36:44',2,39000.00,'PAGADO',1,1),(13,6,'2026-02-17 15:36:44',1,25000.00,'PAGADO',2,2),(14,1,'2026-02-17 15:36:44',2,52000.00,'PAGADO',1,1),(15,7,'2026-02-17 15:36:44',1,25000.00,'PAGADO',3,2),(16,2,'2026-02-17 15:36:44',2,13000.00,'PAGADO',1,1),(17,8,'2026-02-17 15:36:44',1,25000.00,'PAGADO',4,2),(18,1,'2026-02-17 15:36:44',2,13000.00,'PAGADO',1,1),(19,9,'2026-02-17 15:36:44',1,25000.00,'PAGADO',2,2),(20,10,'2026-02-17 15:36:44',2,39000.00,'PAGADO',3,1);
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ventas_detalladas`
--

DROP TABLE IF EXISTS `ventas_detalladas`;
/*!50001 DROP VIEW IF EXISTS `ventas_detalladas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ventas_detalladas` AS SELECT 
 1 AS `venta_id`,
 1 AS `apellido`,
 1 AS `nombre`,
 1 AS `fecha_venta`,
 1 AS `producto`,
 1 AS `cantidad`,
 1 AS `precio_unitario`,
 1 AS `subtotal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `ventas_por_vendedor`
--

DROP TABLE IF EXISTS `ventas_por_vendedor`;
/*!50001 DROP VIEW IF EXISTS `ventas_por_vendedor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ventas_por_vendedor` AS SELECT 
 1 AS `vendedor_id`,
 1 AS `cantidad_ventas`,
 1 AS `total_vendido`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zona_venta`
--

DROP TABLE IF EXISTS `zona_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zona_venta` (
  `zona_id` int NOT NULL AUTO_INCREMENT,
  `sector` varchar(100) NOT NULL,
  PRIMARY KEY (`zona_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zona_venta`
--

LOCK TABLES `zona_venta` WRITE;
/*!40000 ALTER TABLE `zona_venta` DISABLE KEYS */;
INSERT INTO `zona_venta` VALUES (1,'Centro'),(2,'Norte');
/*!40000 ALTER TABLE `zona_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `stock_bajo`
--

/*!50001 DROP VIEW IF EXISTS `stock_bajo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `stock_bajo` AS select `p`.`producto_id` AS `producto_id`,`p`.`nombre` AS `nombre`,greatest(sum(`ms`.`cantidad`),0) AS `stock_actual`,`p`.`stock_minimo` AS `stock_minimo` from (`producto` `p` join `movstock` `ms` on((`p`.`producto_id` = `ms`.`producto_id`))) group by `p`.`producto_id`,`p`.`nombre`,`p`.`stock_minimo` having (greatest(sum(`ms`.`cantidad`),0) <= `p`.`stock_minimo`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ventas_detalladas`
--

/*!50001 DROP VIEW IF EXISTS `ventas_detalladas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ventas_detalladas` AS select `v`.`venta_id` AS `venta_id`,`c`.`apellido` AS `apellido`,`c`.`nombre` AS `nombre`,`v`.`fecha_venta` AS `fecha_venta`,`p`.`nombre` AS `producto`,`dv`.`cantidad` AS `cantidad`,`dv`.`precio_unitario` AS `precio_unitario`,`dv`.`subtotal` AS `subtotal` from (((`venta` `v` join `cliente` `c` on((`v`.`cliente_id` = `c`.`cliente_id`))) join `detalle_venta` `dv` on((`v`.`venta_id` = `dv`.`venta_id`))) join `producto` `p` on((`dv`.`producto_id` = `p`.`producto_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ventas_por_vendedor`
--

/*!50001 DROP VIEW IF EXISTS `ventas_por_vendedor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ventas_por_vendedor` AS select `venta`.`vendedor_id` AS `vendedor_id`,count(0) AS `cantidad_ventas`,sum(`venta`.`total`) AS `total_vendido` from `venta` group by `venta`.`vendedor_id` */;
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

-- Dump completed on 2026-02-17 18:11:53
