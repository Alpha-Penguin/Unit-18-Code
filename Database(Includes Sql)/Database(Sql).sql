-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: journey_to_cariryn
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `alignment`
--

DROP TABLE IF EXISTS `alignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alignment` (
  `AlignmentID` int NOT NULL AUTO_INCREMENT,
  `AlignmentType` text,
  PRIMARY KEY (`AlignmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alignment`
--

LOCK TABLES `alignment` WRITE;
/*!40000 ALTER TABLE `alignment` DISABLE KEYS */;
INSERT INTO `alignment` VALUES (1,'Any '),(2,'Evil'),(3,'Good'),(4,'Good. Neutral or Evil'),(5,'Neutral'),(6,'Neutral or Evil'),(7,'Good or Evil'),(8,'No Alignment ');
/*!40000 ALTER TABLE `alignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armour`
--

DROP TABLE IF EXISTS `armour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `armour` (
  `ArmourID` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  `Cost` int DEFAULT NULL,
  `Protection` int DEFAULT NULL,
  `Agility Penalty` int DEFAULT NULL,
  `Load` int DEFAULT NULL,
  PRIMARY KEY (`ArmourID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armour`
--

LOCK TABLES `armour` WRITE;
/*!40000 ALTER TABLE `armour` DISABLE KEYS */;
INSERT INTO `armour` VALUES (1,'Leather Armour (light)',3,4,0,1),(2,'Padded Armour (light)',2,3,0,1),(3,'Hardened Armour (light)',5,6,-1,2),(4,'Chainmail (medium)',6,9,-2,4),(5,'Scale Mail (medium)',7,11,-3,8),(6,'Splint mail (heavy)',15,13,-3,8),(7,'Full plate (heavy)',75,15,-4,12),(8,'Shield',1,2,0,3),(9,'Helm',1,2,0,1),(10,'No Armour ',0,0,0,0);
/*!40000 ALTER TABLE `armour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `ClassID` int NOT NULL AUTO_INCREMENT,
  `ClassName` text,
  PRIMARY KEY (`ClassID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'Assassin'),(2,'Druid'),(3,'Minstrel'),(4,'Priest'),(5,'Prophet'),(6,'Scout'),(7,'Sorcerer'),(8,'Thief'),(9,'Warrior'),(10,'Wizard');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter` (
  `EncounterID` int NOT NULL AUTO_INCREMENT,
  `LocationID` int DEFAULT NULL,
  `NPCID` int DEFAULT NULL,
  `EnemyID` int DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  PRIMARY KEY (`EncounterID`),
  KEY `LocationIDFK_idx` (`LocationID`),
  KEY `NPCIDFK_idx` (`NPCID`),
  KEY `EnemyIDFK_idx` (`EnemyID`),
  KEY `ItemIDFK_idx` (`ItemID`),
  CONSTRAINT `EnemyIDFK` FOREIGN KEY (`EnemyID`) REFERENCES `enemy` (`EnemyID`),
  CONSTRAINT `ItemIDFK` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`),
  CONSTRAINT `LocationIDFK` FOREIGN KEY (`LocationID`) REFERENCES `location` (`LocationID`),
  CONSTRAINT `NPCIDFK` FOREIGN KEY (`NPCID`) REFERENCES `npc` (`NPCID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
INSERT INTO `encounter` VALUES (1,1,47,70,116),(2,5,47,6,17),(3,1,40,1,13),(4,1,1,1,1);
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enemy`
--

DROP TABLE IF EXISTS `enemy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enemy` (
  `EnemyID` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  `AlignmentID` int DEFAULT NULL,
  `EnemyTypeID` int DEFAULT NULL,
  `Threat` int DEFAULT NULL,
  `Strength` int DEFAULT NULL,
  `Craft` int DEFAULT NULL,
  `Armour` int DEFAULT NULL,
  `Life` int DEFAULT NULL,
  `Attacks` int DEFAULT NULL,
  `Speed` int DEFAULT NULL,
  PRIMARY KEY (`EnemyID`),
  KEY `AlignmentID_idx` (`AlignmentID`),
  KEY `EnemyTypeIDFK_idx` (`EnemyTypeID`),
  CONSTRAINT `AlignmentIDFK` FOREIGN KEY (`AlignmentID`) REFERENCES `alignment` (`AlignmentID`),
  CONSTRAINT `EnemyTypeIDFK` FOREIGN KEY (`EnemyTypeID`) REFERENCES `enemytype` (`EnemyTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enemy`
--

LOCK TABLES `enemy` WRITE;
/*!40000 ALTER TABLE `enemy` DISABLE KEYS */;
INSERT INTO `enemy` VALUES (1,'Sidhe',1,5,17,6,4,15,20,2,12),(2,'Vampire Bat',2,1,11,2,1,0,7,1,13),(3,'Dark Acolyte',2,2,13,2,4,1,13,1,12),(4,'Dark Initiates',2,2,16,2,6,2,14,1,12),(5,'Dragon',2,3,20,8,6,21,30,3,18),(6,'Woodland Drake',2,3,18,7,6,18,26,3,16),(7,'Wyrd Dragon',2,3,18,7,7,15,22,3,18),(8,'Wyvern',2,3,15,7,7,12,18,1,16),(9,'Water Elemental',2,4,15,4,6,0,20,1,10),(10,'Boggart',2,5,14,2,4,0,10,1,10),(11,'Coblynau',2,5,14,4,4,6,12,1,12),(12,'Fomorian',2,5,15,6,2,12,24,1,14),(13,'Naiad',2,5,14,3,4,0,10,1,14),(14,'Red Cap',2,5,17,6,3,9,15,1,13),(15,'Sluagh',2,5,17,3,6,0,18,1,11),(16,'Gnoll',2,6,13,4,2,3,12,1,15),(17,'Goblin',2,6,12,3,2,3,12,1,12),(18,'Hobgoblin',2,6,13,5,1,6,15,1,10),(19,'Ogre',2,6,15,6,2,6,24,1,10),(20,'Basilisk',2,7,14,3,2,3,15,1,13),(21,'Doppelganger',2,7,14,101010,101001,10101,101010,101010,1010101),(22,'Harpy',2,7,14,4,3,3,16,2,18),(23,'Banshee',2,8,13,2,4,0,13,1,12),(24,'Barrow Wight',2,8,14,2,2,6,12,1,12),(25,'Shadow',2,8,12,1,2,0,12,1,10),(26,'Wraith',2,8,16,2,5,0,25,1,12),(27,'Death Knight',2,9,18,6,8,15,22,2,10),(28,'Lemure',2,9,11,2,2,0,11,1,10),(29,'Lich',2,9,17,3,8,0,18,1,12),(30,'Mummy',2,9,14,4,2,3,18,1,8),(31,'Putrid Zombie',2,9,13,3,2,0,15,1,4),(32,'Skeleton',2,9,13,2,2,5,12,1,10),(33,'Breeze Sylph',3,5,16,2,4,0,3,1,12),(34,'White Stag',3,5,18,6,5,6,24,2,16),(35,'Fae Witch',4,5,16,3,6,6,15,1,9),(36,'Knocker',4,5,13,3,2,3,12,1,8),(37,'Ape',5,1,13,4,2,3,15,1,12),(38,'Bear',5,1,13,5,2,3,18,1,10),(39,'Carrion Crows',5,1,11,1,1,0,6,1,15),(40,'Forest Goat',5,1,12,3,1,3,12,1,12),(41,'Giant Beetle',5,1,13,4,1,12,12,1,12),(42,'Giant Fly',5,1,12,2,1,0,8,1,16),(43,'Giant Rat',5,1,12,2,1,0,8,1,13),(44,'Giant Spider',5,1,14,4,2,3,15,1,15),(45,'Giant Worm',5,1,15,5,2,6,15,1,10),(46,'Lion',5,1,14,4,1,3,13,1,14),(47,'Mammoth',5,1,15,8,3,6,15,1,13),(48,'Mountain Goat',5,1,13,4,2,3,14,1,13),(49,'Mountain Lion',5,1,14,3,1,3,13,1,20),(50,'Serpent',5,1,14,2,1,6,14,1,13),(51,'Wild Boar',5,1,12,5,1,3,14,1,12),(52,'Wolf',5,1,13,3,2,3,12,1,13),(53,'Bandit',5,2,14,4,2,3,12,1,12),(54,'Vassal of Mab',5,2,11,2,3,0,12,1,14),(55,'Air Elemental',5,4,16,4,6,0,12,2,24),(56,'Crawling Slime',5,4,15,6,2,0,14,1,6),(57,'Earth Elemental',5,4,16,5,5,24,22,1,8),(58,'Fire Elemental',5,4,17,5,6,0,18,1,12),(59,'Brownie',5,5,14,3,4,3,8,2,8),(60,'Pixies',5,5,17,2,4,0,8,1,12),(61,'Cave Troll',5,6,16,8,2,9,25,2,13),(62,'Kobold',5,6,11,2,2,3,7,1,13),(63,'Gargoyle',5,7,15,4,2,15,12,2,18),(64,'Giant',5,7,18,10,1,6,30,1,15),(65,'Manticore',5,7,15,6,2,6,16,2,15),(66,'Apparition',5,8,11,1,2,0,10,1,10),(67,'Will-O-The-Wisps',5,8,10,1,1,0,10,1,15),(68,'Ghost',6,8,14,2,4,0,14,1,10),(69,'Spectre',6,8,14,1,3,0,15,1,12),(70,'No Enemy ',8,10,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `enemy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enemytype`
--

DROP TABLE IF EXISTS `enemytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enemytype` (
  `EnemyTypeID` int NOT NULL AUTO_INCREMENT,
  `Enemy Type` text,
  PRIMARY KEY (`EnemyTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enemytype`
--

LOCK TABLES `enemytype` WRITE;
/*!40000 ALTER TABLE `enemytype` DISABLE KEYS */;
INSERT INTO `enemytype` VALUES (1,'Animal'),(2,'Cultist/Outlaw'),(3,'Dragon'),(4,'Elemental'),(5,'Fae'),(6,'Goblinoid'),(7,'Monster'),(8,'Spirit'),(9,'Undead'),(10,'No Type ');
/*!40000 ALTER TABLE `enemytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `InventoryID` int NOT NULL AUTO_INCREMENT,
  `PlayerID` int DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  PRIMARY KEY (`InventoryID`),
  KEY `PlayerIDFK_idx` (`PlayerID`),
  KEY `ItemIDFK_idx` (`ItemID`),
  KEY `ItemFK_idx` (`ItemID`),
  CONSTRAINT `ItemFK` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`),
  CONSTRAINT `PlayerIDFK` FOREIGN KEY (`PlayerID`) REFERENCES `pc` (`PlayerID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,1),(3,2,8),(6,1,4),(7,1,101);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `ItemID` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  `Cost` int DEFAULT NULL,
  `Load` int DEFAULT NULL,
  `ItemTypeID` int DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `ItemTypeIDF_idx` (`ItemTypeID`),
  CONSTRAINT `ItemTypeIDF` FOREIGN KEY (`ItemTypeID`) REFERENCES `itemtype` (`ItemTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Aegis',500,2,1),(2,'Amulet of Abjuration',100,0,1),(3,'Amulet of the Magician\'s Escape',250,0,1),(4,'Ancient Elven Bow',200,1,1),(5,'Armour Repair Kit',1,1,1),(6,'Astrolabe',5,2,1),(7,'Bane Sword',400,2,1),(8,'Bedroll & blanket',1,1,1),(9,'Bottomless Haversack',100,1,1),(10,'Candles (5)',1,1,1),(11,'Censer with 20cones of incense',1,1,1),(12,'Climbing Harness',2,2,1),(13,'Concealed Pouch',3,1,1),(14,'Crowbar',1,1,1),(15,'Crown of Judgement',600,1,1),(16,'Crystal Sceptre',300,1,1),(17,'Crystal Shard',100,0,1),(18,'Cure Disease Elixir',10,0,1),(19,'Cure Poison Elixir',10,0,1),(20,'Disguise Kit',2,1,1),(21,'Doomsword',600,1,1),(22,'Downing Rod',3,1,1),(23,'Dragon Helm',300,2,1),(24,'Dragon\'s Blood',25,0,1),(25,'Dragonscale Shirt',700,3,1),(26,'Eagle Talon',50,0,1),(27,'Elixir of Destiny',50,0,1),(28,'Elixir of Vitality',50,0,1),(29,'Entertaining Costume',5,0,1),(30,'Everfull Purse',100,1,1),(31,'Finger Bone of Blessed Samuel',10,0,1),(32,'Fishing Tackle',1,1,1),(33,'Flask of Oil',1,0,1),(34,'Flight Potion',15,0,1),(35,'Guilded Compass',5,1,1),(36,'Hammer',1,1,1),(37,'Haversack',1,1,1),(38,'Healer\'s Kit',3,1,1),(39,'Helm of Warding',300,2,1),(40,'Holy Lance',800,3,1),(41,'Holy Water',10,1,1),(42,'Ice Sceptre',500,1,1),(43,'Inferno Spear',800,2,1),(44,'Invisibility Potion',15,0,1),(45,'Journal, Personal',2,0,1),(46,'Lantern',1,2,1),(47,'Lorebook',10,1,1),(48,'Luckstone',200,1,1),(49,'Lucky Coin',100,0,1),(50,'Magnifying Glass',1,0,1),(51,'Manacles',2,1,1),(52,'Map',1,1,1),(53,'Mess Kit',1,1,1),(54,'Musical Instrument',100,2,1),(55,'Myrmidon Helmet',100,2,1),(56,'Paper (5 sheets)',1,0,1),(57,'Pen & Ink',1,1,1),(58,'Pharoah\'s Crown',400,1,1),(59,'Phoenix Potion',100,0,1),(60,'Pitons (10)',1,1,1),(61,'Potion of Psychic Power',15,0,1),(62,'Potion, Healing',5,0,1),(63,'Prayer Book',3,1,1),(64,'Prayer Candles (5)',2,1,1),(65,'Raft Kit',1,2,1),(66,'Rations (1 week)',1,1,1),(67,'Renewal Potion',20,0,1),(68,'Ring of Misdirection',150,0,1),(69,'Ring of Protection',250,0,1),(70,'Rope (50ft)',1,2,1),(71,'Rope Ladder',1,3,1),(72,'Runestones',3,1,1),(73,'Saddlebags',1,1,1),(74,'Sealing Wax',1,0,1),(75,'Shield of Defiance',300,1,1),(76,'Shovel',1,2,1),(77,'Signet Ring',1,0,1),(78,'Snare (5)',1,1,1),(79,'Songbook',3,1,1),(80,'Spellbook',3,1,1),(81,'Strength Potion',15,0,1),(82,'Suleiman\'s Seal',1000,1,1),(83,'Sun Shield',400,2,1),(84,'Tent',1,3,1),(85,'Thieves\' Tools',1,1,1),(86,'Tinderbox',1,0,1),(87,'Tinkers\' Tooklit',1,1,1),(88,'Torches (10)',1,2,1),(89,'Walking Stick',1,2,1),(90,'Water Bottle',1,1,1),(91,'Winter Oil',5,1,1),(92,'Blowgun',1,1,2),(93,'Bow',3,2,2),(94,'Bow, Elven',15,1,2),(95,'Crossbow, light',3,1,2),(96,'Dagger',1,0,2),(97,'Net',1,2,2),(98,'Sling',1,1,2),(99,'Spear',2,3,2),(100,'Axe',2,2,2),(101,'Battle axe',3,3,2),(102,'Dagger',1,1,2),(103,'Flail',3,2,2),(104,'Greatsword',3,4,2),(105,'Greataxe',3,4,2),(106,'Mace',2,2,2),(107,'Pike',2,3,2),(108,'Rapier',4,1,2),(109,'Scimitar',3,3,2),(110,'Scythe',1,2,2),(111,'Shortsword',2,2,2),(112,'Spear',2,3,2),(113,'Staff',0,3,2),(114,'Stiletto',2,1,2),(115,'Sword',2,2,2),(116,'No Item',0,0,3),(117,'Short Dagger',1,1,2);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemtype`
--

DROP TABLE IF EXISTS `itemtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemtype` (
  `ItemTypeID` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  PRIMARY KEY (`ItemTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemtype`
--

LOCK TABLES `itemtype` WRITE;
/*!40000 ALTER TABLE `itemtype` DISABLE KEYS */;
INSERT INTO `itemtype` VALUES (1,'Item'),(2,'Weapon'),(3,'No Type ');
/*!40000 ALTER TABLE `itemtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Description` varchar(164) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`LocationID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Altar of Desire','An ancient, worn marble altar rests atop a small hill. The altar is engraved with images.'),(2,'Altar of Greed','This altar was exquisitely carved from white marble. It\'s adorned with gold inlay and gemstones. The ground around the altar is soft.'),(3,'Altar of Wrath','This altar is made of polished black basalt. An obsidian dagger rests atop it. Images carved on the altar show a spear or bolt of lightning striking a human figure.'),(4,'Ancient Altar','An ancient and crumbling altar is covered in vines and weeds.'),(5,'Arena','A temporary combat arena.'),(6,'Black Market','A goblin is holding a black market, one where stolen and illegal goods can be bought and sold.'),(7,'Blighted Shrine','A small shrine rests upon a barren hill. Many small dead animals lay around the perimeter of the shrine. The air has a putrid and unwholesome smell.'),(8,'Boneyard','A charnel pit is filled with bones and decaying corpses.'),(9,'Carnival','A small carnival is being held here in a tent.'),(10,'Castle Ruins','The crumbling ruins of an ancient castle rise from the ground. Only a few rising pillars, an archway and the foundations remain.'),(11,'Cave','A deep cave lies beyond. It may be empty or it might hold a random enemy. It may even connect to a dungeon deep below the ground.'),(12,'Cave of Bones','A small cave filled with bones of the long dead.'),(13,'Dungeon','An entrance to an underground dungeon.'),(14,'Faery Gate','This gate can take many forms. It might appear as a waterfall, faery ring, split oak tree or something more exotic hidden in the wilderness.'),(15,'Faery Glade','This pleasant glade is filled with mushroom rings and bright flowers.'),(16,'Faery Mound','An ancient faery mound.'),(17,'Forgotten Pantheon','Runied statues portray a forgotten pantheon of ancient gods.'),(18,'Fountain of Wisdom','Pure water flows from a fountain'),(19,'Idol','This crumbling statue roughly resembles a humanoid with skaly skin and four arms.'),(20,'Magic Stream','Water flows from this locale in a sparkling, crystal clear stream.'),(21,'Mystic Portal','A mystic portal grants instantaneous passage to another place in the realm.'),(22,'Pool of Fortitude','Pure water flows from a fountain'),(23,'Pool of Fortune','This fountain offers pure water.'),(24,'Pool of Life','Thick green moss speckled with white flowers surrounds a small pool of clear water.'),(25,'Pool of Vision','A small pool is set in a basin of brightly coloured stones.'),(26,'Riddle Stone','This rough-hewn stone is inscribed with ancient runes. When the stone is touched, the stone speaks a riddl in a deep and rumbly voice.'),(27,'Sacred Ground','A place sacred to one of the alignments.'),(28,'Sacrificial Altar','A large, round stone altar has an unlit pyre built atop it. A stack of chopped wood is nearby and the bare ground surrounding the altar is covered in soot.'),(29,'Sacrificial Stone','This tall standing stone is fitted with manacles for arms and ankles.'),(30,'Shrine','A small shrine surrounded with thick moss sits in a small clearing in the forest.'),(31,'Shortcut','A supposedly shorter route to where the players need to get to.'),(32,'Standing Stones','Ancient standing stones of great power rest here, enduring the elements.'),(33,'Tomb','An ancient and crumbling tomb. The carved name is so worn it is no longer visible.'),(34,'Tranquil Glade','This peaceful glade is filled with flowers and toadstools.'),(35,'Treasure Trove','A treasure has been buried here under a pile of rocks. It might be guarded.'),(36,'Well of Life','This old ramshackle well has crumbling walls. Lush and verdant plant life covers the ground around it.'),(37,'Rome','It was a place');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `npc`
--

DROP TABLE IF EXISTS `npc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `npc` (
  `NPCID` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  `Strength` int DEFAULT NULL,
  `Craft` int DEFAULT NULL,
  `Life` int DEFAULT NULL,
  PRIMARY KEY (`NPCID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `npc`
--

LOCK TABLES `npc` WRITE;
/*!40000 ALTER TABLE `npc` DISABLE KEYS */;
INSERT INTO `npc` VALUES (1,'Apprentice Minstrel',2,3,10),(2,'Apprentice Wizard',1,4,10),(3,'Armoursmith',5,2,15),(4,'Astrologer',2,6,12),(5,'Bartender',3,3,14),(6,'Bear',5,2,18),(7,'Camel',5,1,15),(8,'Cat',1,3,5),(9,'Crow / Raven',1,3,3),(10,'Cutpurse',4,2,12),(11,'Dog',3,2,10),(12,'Dungsweeper',3,3,12),(13,'Earth Elemental',5,2,20),(14,'Enchanter',2,6,13),(15,'Faery',1,5,5),(16,'Falcon / Hawk',2,3,5),(17,'Familiar Spirit',1,4,5),(18,'Good Acolyte',2,4,10),(19,'Healer',2,4,10),(20,'Horse',5,1,15),(21,'Imp',1,5,12),(22,'Junior Assassin',4,2,15),(23,'Junior Thief',3,3,12),(24,'Leper',3,3,10),(25,'Leprechaun',2,7,15),(26,'Mercenary',4,1,15),(27,'Messenger Pigeon',1,1,3),(28,'Mule',6,1,15),(29,'Pedlar',3,3,12),(30,'Pixie',1,5,7),(31,'Prospector',3,3,14),(32,'Sage Owl',2,6,6),(33,'Scout',3,3,10),(34,'Servant',2,3,10),(35,'Shambler',5,1,15),(36,'Shrine Priest',2,6,14),(37,'Spirit',7,1,10),(38,'Stag',4,2,15),(39,'Street Sage',2,6,14),(40,'Talismonger',0,0,0),(41,'Temple Acolyte',3,3,10),(42,'Tracker',3,4,14),(43,'Weaponsmith',5,2,15),(44,'Wild Boar',5,1,15),(45,'Wildcat',3,3,10),(46,'Wolf',3,2,15),(47,'No NPC ',0,0,0),(48,'Hermit',1,4,2);
/*!40000 ALTER TABLE `npc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc`
--

DROP TABLE IF EXISTS `pc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pc` (
  `PlayerID` int NOT NULL AUTO_INCREMENT,
  `First Name` text,
  `Last Name` text,
  `RaceID` int DEFAULT NULL,
  `ClassID` int DEFAULT NULL,
  `AlignmentID` int DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `Strength` int DEFAULT NULL,
  `Brawn` int DEFAULT NULL,
  `Agility` int DEFAULT NULL,
  `Mettle` int DEFAULT NULL,
  `Craft` int DEFAULT NULL,
  `Insight` int DEFAULT NULL,
  `Wits` int DEFAULT NULL,
  `Resolve` int DEFAULT NULL,
  `Life` int DEFAULT NULL,
  `ArmourID` int DEFAULT NULL,
  `Shield` text,
  `Helm` text,
  PRIMARY KEY (`PlayerID`),
  KEY `RaceIDFK_idx` (`RaceID`),
  KEY `ClassIDFK_idx` (`ClassID`),
  KEY `AlignmentFK_idx` (`AlignmentID`),
  KEY `ArmourIDFK_idx` (`ArmourID`),
  CONSTRAINT `AlignmentFK` FOREIGN KEY (`AlignmentID`) REFERENCES `alignment` (`AlignmentID`),
  CONSTRAINT `ArmourIDFK` FOREIGN KEY (`ArmourID`) REFERENCES `armour` (`ArmourID`),
  CONSTRAINT `ClassIDFK` FOREIGN KEY (`ClassID`) REFERENCES `class` (`ClassID`),
  CONSTRAINT `RaceIDFK` FOREIGN KEY (`RaceID`) REFERENCES `race` (`RaceID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pc`
--

LOCK TABLES `pc` WRITE;
/*!40000 ALTER TABLE `pc` DISABLE KEYS */;
INSERT INTO `pc` VALUES (1,'Gitog','Strongbeard',1,4,3,1,2,2,1,2,5,5,3,2,11,3,'Y','Y'),(2,'Leena','Iliqen',2,6,3,1,4,2,4,2,3,2,2,3,18,1,'N','Y'),(3,'Bogyog','Swampreaver',3,1,5,1,4,3,4,2,3,2,2,2,14,2,'N','Y'),(4,'Zoa','Caim',4,7,2,2,1,2,2,1,5,3,5,3,12,10,'N','N'),(5,'Tarragon','Betterglimmer',6,2,5,1,3,1,3,2,4,2,2,5,14,10,'N','N'),(6,'Dorkuraz','Skullsplitter',7,9,5,1,5,5,2,4,2,1,1,2,19,4,'Y','Y'),(7,'Jason','Tran',1,1,3,0,1,1,1,1,1,1,1,1,10,2,'N','Y'),(8,'James ','Mad',4,9,2,0,1,1,2,0,0,4,1,2,3,1,'Y','Y');
/*!40000 ALTER TABLE `pc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `race` (
  `RaceID` int NOT NULL AUTO_INCREMENT,
  `Name` text,
  PRIMARY KEY (`RaceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race`
--

LOCK TABLES `race` WRITE;
/*!40000 ALTER TABLE `race` DISABLE KEYS */;
INSERT INTO `race` VALUES (1,'Dwarf'),(2,'Elf'),(3,'Ghoul'),(4,'Human'),(5,'Leywalker'),(6,'Sprite'),(7,'Troll');
/*!40000 ALTER TABLE `race` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'journey_to_cariryn'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-15 14:32:19
