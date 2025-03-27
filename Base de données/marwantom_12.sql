-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql-marwantom.alwaysdata.net
-- Generation Time: Mar 27, 2025 at 01:46 AM
-- Server version: 10.11.11-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marwantom_12`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `id_personne` int(11) DEFAULT NULL,
  `administrateur_reseau` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `id_personne`, `administrateur_reseau`) VALUES
(1, 1, 'Responsable Réseau'),
(2, 3, 'Gestionnaire IT'),
(3, 4, 'Superviseur Région');

-- --------------------------------------------------------

--
-- Table structure for table `appartient`
--

CREATE TABLE `appartient` (
  `id_etudiant` int(11) DEFAULT NULL,
  `id_auto_ecole` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `autoecole`
--

CREATE TABLE `autoecole` (
  `id_auto_ecole` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `autoecole`
--

INSERT INTO `autoecole` (`id_auto_ecole`, `nom`, `adresse`) VALUES
(1, 'Auto-École Paris', '12 Rue de la Paix, Paris'),
(2, 'Conduite Facile', '45 Avenue des Champs, Lyon'),
(3, 'Drive Academy', '33 Boulevard Haussmann, Paris'),
(4, 'Auto-École Sud', '78 Rue Nationale, Marseille');

-- --------------------------------------------------------

--
-- Table structure for table `avis`
--

CREATE TABLE `avis` (
  `id_avis` int(11) NOT NULL,
  `id_etudiant` int(11) DEFAULT NULL,
  `contenu` text DEFAULT NULL,
  `date_depot` date DEFAULT NULL,
  `date_publication` date DEFAULT NULL,
  `score_avis` float DEFAULT NULL,
  `statut_moderation` varchar(50) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `note` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `avis`
--

INSERT INTO `avis` (`id_avis`, `id_etudiant`, `contenu`, `date_depot`, `date_publication`, `score_avis`, `statut_moderation`, `titre`, `note`) VALUES
(1, 1, 'Très bonne auto-école avec des moniteurs sympas.', '2025-03-26', '2025-03-27', 4.5, 'Validé', 'Super expérience !', 5),
(2, 2, 'Bonne formation mais trop d’attente pour les examens.', '2025-03-24', '2025-03-25', 3, 'Validé', 'Peut mieux faire', 3),
(5, 1, 'Très bonne auto-école avec un excellent suivi.', '2025-03-27', NULL, 4.8, 'En attente', 'Super expérience !', 5);

-- --------------------------------------------------------

--
-- Table structure for table `etudiant`
--

CREATE TABLE `etudiant` (
  `id_etudiant` int(11) NOT NULL,
  `id_personne` int(11) DEFAULT NULL,
  `neph` varchar(50) DEFAULT NULL,
  `date_inscription` date DEFAULT NULL,
  `etg` tinyint(1) DEFAULT NULL,
  `echec_etg` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `etudiant`
--

INSERT INTO `etudiant` (`id_etudiant`, `id_personne`, `neph`, `date_inscription`, `etg`, `echec_etg`) VALUES
(1, 2, '123456', '2024-03-01', 2, 1),
(2, 3, '987654321', '2025-03-20', 0, 1),
(3, 4, '123987456', '2025-02-15', 1, 0),
(5, 6, '789456123', '2025-03-05', 0, 0),
(7, 57, '123456789', '2024-03-25', 1, 0),
(9, 59, '123456789', '2025-03-26', 2, 1),
(10, 60, '123456789', '2025-03-26', 2, 1),
(11, 61, '12345', '2025-03-14', 3, 1),
(12, 62, '45591', '2025-02-25', 3, -1);

-- --------------------------------------------------------

--
-- Table structure for table `examens`
--

CREATE TABLE `examens` (
  `id_examen` int(11) NOT NULL,
  `theme` varchar(100) DEFAULT NULL,
  `date_examen` date DEFAULT NULL,
  `nombre_questions` int(11) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `resultat` varchar(50) DEFAULT NULL,
  `motif_echec` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `examens`
--

INSERT INTO `examens` (`id_examen`, `theme`, `date_examen`, `nombre_questions`, `score`, `resultat`, `motif_echec`) VALUES
(1, 'Code de la route', '2025-03-26', 40, 18.5, 'Réussi', NULL),
(2, 'Code de la route', '2025-04-01', 40, 32, 'Réussi', NULL),
(3, 'Sécurité Routière', '2025-04-10', 40, 25, 'Échoué', 'Trop de fautes'),
(4, 'Conduite', '2025-04-15', 30, 28, 'Réussi', NULL),
(5, 'Code avancé', '2025-04-20', 50, 40, 'Réussi', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `passeexamens`
--

CREATE TABLE `passeexamens` (
  `id_etudiant` int(11) DEFAULT NULL,
  `id_examen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passeexamens`
--

INSERT INTO `passeexamens` (`id_etudiant`, `id_examen`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `passetest`
--

CREATE TABLE `passetest` (
  `id_etudiant` int(11) DEFAULT NULL,
  `id_test` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passetest`
--

INSERT INTO `passetest` (`id_etudiant`, `id_test`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `personne`
--

CREATE TABLE `personne` (
  `id_personne` int(11) NOT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `personne`
--

INSERT INTO `personne` (`id_personne`, `prenom`, `nom`, `date_naissance`, `login`, `password`) VALUES
(1, 'Alice', 'Admin', '1980-01-01', 'admin.test', '$2b$12$3W3us5A9aVltrv3WVzKFyOzT4EMWL8qH5KdeZXV..MKJLg0jWI1QC'),
(2, 'Jean', 'Dupont', '2000-05-15', 'eleve.test', '$2y$10$Cw3.70Abb8rODXfSgpodVOoe6/UD1iFhvBITZuBAuVzLkUGB1KsY.'),
(3, 'Paul', 'Durand', '2001-07-20', 'paul.durand', 'paul123'),
(4, 'Sophie', 'Martin', '1999-11-30', 'sophie.martin', 'sophie123'),
(6, 'Emma', 'Dubois', '2002-12-01', 'emma.dubois', 'emma123'),
(57, 'Jean', 'Dupont', NULL, NULL, NULL),
(59, 'Jean', 'Dupont', NULL, NULL, NULL),
(60, 'Jean', 'Dupont', NULL, NULL, NULL),
(61, 'J', 'Dupont', NULL, NULL, NULL),
(62, 'test', 'test', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id_test` int(11) NOT NULL,
  `theme` varchar(100) DEFAULT NULL,
  `date_test` date DEFAULT NULL,
  `nombre_questions` int(11) DEFAULT NULL,
  `score` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id_test`, `theme`, `date_test`, `nombre_questions`, `score`) VALUES
(1, 'Code de la route', '2025-03-28', 40, 30),
(2, 'Premiers secours', '2025-04-05', 30, 27),
(3, 'Signalisation', '2025-04-10', 25, 22),
(4, 'Conduite Théorique', '2025-04-12', 35, 30);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_personne` (`id_personne`);

--
-- Indexes for table `appartient`
--
ALTER TABLE `appartient`
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_auto_ecole` (`id_auto_ecole`);

--
-- Indexes for table `autoecole`
--
ALTER TABLE `autoecole`
  ADD PRIMARY KEY (`id_auto_ecole`);

--
-- Indexes for table `avis`
--
ALTER TABLE `avis`
  ADD PRIMARY KEY (`id_avis`),
  ADD KEY `id_etudiant` (`id_etudiant`);

--
-- Indexes for table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id_etudiant`),
  ADD KEY `id_personne` (`id_personne`);

--
-- Indexes for table `examens`
--
ALTER TABLE `examens`
  ADD PRIMARY KEY (`id_examen`);

--
-- Indexes for table `passeexamens`
--
ALTER TABLE `passeexamens`
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_examen` (`id_examen`);

--
-- Indexes for table `passetest`
--
ALTER TABLE `passetest`
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_test` (`id_test`);

--
-- Indexes for table `personne`
--
ALTER TABLE `personne`
  ADD PRIMARY KEY (`id_personne`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id_test`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `autoecole`
--
ALTER TABLE `autoecole`
  MODIFY `id_auto_ecole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `avis`
--
ALTER TABLE `avis`
  MODIFY `id_avis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `id_etudiant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `examens`
--
ALTER TABLE `examens`
  MODIFY `id_examen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personne`
--
ALTER TABLE `personne`
  MODIFY `id_personne` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id_test` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`);

--
-- Constraints for table `appartient`
--
ALTER TABLE `appartient`
  ADD CONSTRAINT `appartient_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`),
  ADD CONSTRAINT `appartient_ibfk_2` FOREIGN KEY (`id_auto_ecole`) REFERENCES `autoecole` (`id_auto_ecole`);

--
-- Constraints for table `avis`
--
ALTER TABLE `avis`
  ADD CONSTRAINT `avis_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`);

--
-- Constraints for table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `etudiant_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`);

--
-- Constraints for table `passeexamens`
--
ALTER TABLE `passeexamens`
  ADD CONSTRAINT `passeexamens_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`),
  ADD CONSTRAINT `passeexamens_ibfk_2` FOREIGN KEY (`id_examen`) REFERENCES `examens` (`id_examen`);

--
-- Constraints for table `passetest`
--
ALTER TABLE `passetest`
  ADD CONSTRAINT `passetest_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`),
  ADD CONSTRAINT `passetest_ibfk_2` FOREIGN KEY (`id_test`) REFERENCES `test` (`id_test`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
