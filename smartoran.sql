-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 25 avr. 2025 à 00:23
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `smartoran`
--

-- --------------------------------------------------------

--
-- Structure de la table `appuser`
--

DROP TABLE IF EXISTS `appuser`;
CREATE TABLE IF NOT EXISTS `appuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `lname` text,
  `phone` text,
  `password` text,
  `email` text,
  `id_role` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_role` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `appuser`
--

INSERT INTO `appuser` (`id`, `name`, `lname`, `phone`, `password`, `email`, `id_role`) VALUES
(3, 'bouba', 'bouba', '05555', 'a', 'a', 1);

-- --------------------------------------------------------

--
-- Structure de la table `driver`
--

DROP TABLE IF EXISTS `driver`;
CREATE TABLE IF NOT EXISTS `driver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int DEFAULT NULL,
  `id_vehicle` int DEFAULT NULL,
  `driver_license` text,
  `national_id` text,
  `job_license` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `driver_user` (`id_user`),
  KEY `driver_vehicle` (`id_vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `location` text,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id`, `name`, `location`, `date_start`, `date_end`) VALUES
(1, 'Innoverse', 'ORAN', '2025-04-01', '2025-04-02'),
(2, 'Salon de l\'Innovation', 'ORAN', '2025-05-10', '2025-05-12'),
(3, 'Festival International du Film', 'ORAN', '2025-06-20', '2025-06-25'),
(4, 'Conférence Santé & Bien-être', 'ORAN', '2025-04-28', '2025-04-30'),
(5, 'Forum de l’Emploi', 'ORAN', '2025-05-05', '2025-05-06'),
(6, 'Journées Scientifiques', 'ORAN', '2025-07-01', '2025-07-03'),
(7, 'Concert de Printemps', 'ORAN', '2025-04-15', '2025-04-15'),
(8, 'Expo Artisanat et Culture', 'ORAN', '2025-05-20', '2025-05-25'),
(9, 'Hackathon National', 'ORAN', '2025-06-01', '2025-06-02'),
(10, 'Marathon de la Ville', 'ORAN', '2025-04-18', '2025-04-18');

-- --------------------------------------------------------

--
-- Structure de la table `gpscoord`
--

DROP TABLE IF EXISTS `gpscoord`;
CREATE TABLE IF NOT EXISTS `gpscoord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_vehicle` int DEFAULT NULL,
  `latituded` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `gps_vehicle` (`id_vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `parking`
--

DROP TABLE IF EXISTS `parking`;
CREATE TABLE IF NOT EXISTS `parking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `latituded` float NOT NULL,
  `longitude` float NOT NULL,
  `available_places` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `parking`
--

INSERT INTO `parking` (`id`, `name`, `latituded`, `longitude`, `available_places`) VALUES
(1, 'Parking - Place 1er Novembre', 35.6975, -0.6331, 50),
(2, 'Parking - Gare Routière El Bahia', 35.702, -0.6405, 75),
(3, 'Parking - Université d\'Oran 2', 35.73, -0.67, 100),
(4, 'Parking - Es Sénia Airport', 35.6233, -0.6212, 120),
(5, 'Parking - Akid Lotfi Center', 35.71, -0.65, 60),
(6, 'Parking - Hai El Sabah', 35.712, -0.645, 80),
(7, 'Parking - Maraval Intersection', 35.72, -0.66, 70),
(8, 'Parking - Bir El Djir Market', 35.715, -0.653, 90),
(9, 'Parking - Sidi El Bachir Park', 35.655, -0.599, 40),
(10, 'Parking - Palais des Sports', 35.705, -0.645, 85);

-- --------------------------------------------------------

--
-- Structure de la table `report`
--

DROP TABLE IF EXISTS `report`;
CREATE TABLE IF NOT EXISTS `report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `report`
--

INSERT INTO `report` (`id`, `report`) VALUES
(1, 'Thanks'),
(2, 'Gg'),
(3, 'وجود حفرة'),
(4, 'شكوى عن حفرة');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'user'),
(2, 'driver'),
(3, 'admin');

-- --------------------------------------------------------

--
-- Structure de la table `station`
--

DROP TABLE IF EXISTS `station`;
CREATE TABLE IF NOT EXISTS `station` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `latituded` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `id_type` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `station_type` (`id_type`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `station`
--

INSERT INTO `station` (`id`, `name`, `latituded`, `longitude`, `id_type`) VALUES
(97, 'Taxi Stand - Akid Lotfi Center', 35.68, -0.65, 1),
(98, 'Taxi Stand - Hai El Sabah', 35.682, -0.645, 1),
(99, 'Taxi Stand - Bir El Djir Market', 35.685, -0.653, 1),
(100, 'Taxi Stand - Maraval Intersection', 35.687, -0.66, 1),
(101, 'Taxi Stand - Université d\'Oran 2', 35.689, -0.67, 1),
(102, 'Bus Stop - Place Valéro', 35.68, -0.65, 2),
(103, 'Bus Stop - Bd. Maata', 35.683, -0.655, 2),
(104, 'Bus Stop - Hai Es-Seddikia', 35.686, -0.66, 2),
(105, 'Bus Stop - Hai Akid Lotfi', 35.687, -0.665, 2),
(106, 'Bus Stop - Université d\'Oran 2', 35.689, -0.67, 2),
(107, 'Tram Station - Bir El Djir', 35.685, -0.65, 3),
(108, 'Tram Station - Université Es-Sénia', 35.686, -0.655, 3),
(109, 'Tram Station - Hai El Akid Lotfi', 35.687, -0.66, 3),
(110, 'Tram Station - Gare Routière', 35.689, -0.665, 3),
(111, 'Tram Station - Place 1er Novembre', 35.69, -0.67, 3),
(112, 'Tram Station - Aéroport d\'Oran', 35.688, -0.675, 3);

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id`, `name`) VALUES
(1, 'taxi'),
(2, 'bus'),
(3, 'tram');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_driver` int DEFAULT NULL,
  `license_plate` text,
  `id_type` int DEFAULT NULL,
  `registration_document` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_vehicle_driver` (`id_driver`),
  KEY `vehicle_type` (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `appuser`
--
ALTER TABLE `appuser`
  ADD CONSTRAINT `user_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `driver`
--
ALTER TABLE `driver`
  ADD CONSTRAINT `driver_user` FOREIGN KEY (`id_user`) REFERENCES `appuser` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `driver_vehicle` FOREIGN KEY (`id_vehicle`) REFERENCES `vehicle` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `gpscoord`
--
ALTER TABLE `gpscoord`
  ADD CONSTRAINT `gps_vehicle` FOREIGN KEY (`id_vehicle`) REFERENCES `vehicle` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `station`
--
ALTER TABLE `station`
  ADD CONSTRAINT `station_type` FOREIGN KEY (`id_type`) REFERENCES `type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `vehicle_type` FOREIGN KEY (`id_type`) REFERENCES `type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
