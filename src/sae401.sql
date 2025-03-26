-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 19 mars 2025 à 20:18
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sae401`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  `administrateur_reseau` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id_admin`, `id_personne`, `administrateur_reseau`) VALUES
(1, 3, 'Gestion des serveurs'),
(2, 4, 'Sécurité réseau'),
(3, 8, 'Supervision IT'),
(4, 9, 'Maintenance infrastructure'),
(5, 10, 'Développement interne');

-- --------------------------------------------------------

--
-- Structure de la table `appartient`
--

CREATE TABLE `appartient` (
  `id_etudiant` int(11) NOT NULL,
  `id_auto_ecole` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `appartient`
--

INSERT INTO `appartient` (`id_etudiant`, `id_auto_ecole`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `autoecole`
--

CREATE TABLE `autoecole` (
  `id_auto_ecole` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `autoecole`
--

INSERT INTO `autoecole` (`id_auto_ecole`, `nom`, `adresse`) VALUES
(1, 'Auto École Paris', '12 Rue de Paris, 75001 Paris'),
(2, 'Conduite Plus', '34 Avenue de Lyon, 69003 Lyon'),
(3, 'Permis Facile', '78 Boulevard de Marseille, 13006 Marseille');

-- --------------------------------------------------------

--
-- Structure de la table `avis`
--

CREATE TABLE `avis` (
  `id_avis` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `contenu` text NOT NULL,
  `date_depot` date NOT NULL,
  `date_publication` date NOT NULL,
  `score_avis` float DEFAULT NULL CHECK (`score_avis` >= 0 and `score_avis` <= 5),
  `statut_moderation` varchar(50) NOT NULL DEFAULT 'en attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `avis`
--

INSERT INTO `avis` (`id_avis`, `id_etudiant`, `contenu`, `date_depot`, `date_publication`, `score_avis`, `statut_moderation`) VALUES
(1, 1, 'Très bonne auto-école, formateurs à l\'écoute.', '2024-03-01', '2024-03-05', 4.5, 'publié'),
(2, 2, 'Manque d\'organisation mais bon suivi.', '2024-02-20', '2024-02-25', 3, 'publié'),
(3, 3, 'Les cours sont clairs et bien expliqués.', '2024-02-28', '2024-03-02', 5, 'publié');

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `id_etudiant` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  `neph` varchar(50) NOT NULL,
  `date_inscription` date NOT NULL,
  `etg` tinyint(1) NOT NULL,
  `echec_etg` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id_etudiant`, `id_personne`, `neph`, `date_inscription`, `etg`, `echec_etg`) VALUES
(1, 1, 'NEPH123456', '2023-01-15', 1, 0),
(2, 2, 'NEPH789012', '2022-09-10', 0, 2),
(3, 5, 'NEPH345678', '2023-05-20', 1, 1),
(4, 6, 'NEPH901234', '2023-06-15', 0, 3),
(5, 7, 'NEPH567890', '2022-12-01', 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `examens`
--

CREATE TABLE `examens` (
  `id_examen` int(11) NOT NULL,
  `theme` varchar(100) NOT NULL,
  `date_examen` date NOT NULL,
  `nombre_questions` int(11) NOT NULL,
  `score` float DEFAULT NULL CHECK (`score` >= 0 and `score` <= 100),
  `resultat` varchar(50) NOT NULL,
  `motif_echec` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `examens`
--

INSERT INTO `examens` (`id_examen`, `theme`, `date_examen`, `nombre_questions`, `score`, `resultat`, `motif_echec`) VALUES
(1, 'Examen pratique', '2024-01-20', 25, 90, 'Réussi', NULL),
(2, 'Examen théorique', '2024-02-15', 30, 45, 'Échoué', 'Trop d\'erreurs sur la signalisation'),
(3, 'Examen final', '2024-03-10', 35, 60, 'Réussi', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `passeexamens`
--

CREATE TABLE `passeexamens` (
  `id_etudiant` int(11) NOT NULL,
  `id_examen` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `passeexamens`
--

INSERT INTO `passeexamens` (`id_etudiant`, `id_examen`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `passetest`
--

CREATE TABLE `passetest` (
  `id_etudiant` int(11) NOT NULL,
  `id_test` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `passetest`
--

INSERT INTO `passetest` (`id_etudiant`, `id_test`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

CREATE TABLE `personne` (
  `id_personne` int(11) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `date_naissance` date NOT NULL,
  `login` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`id_personne`, `prenom`, `nom`, `date_naissance`, `login`, `password`) VALUES
(1, 'Alice', 'Durand', '1995-04-23', 'alice.durand', 'hashedpassword1'),
(2, 'Bob', 'Martin', '1998-07-12', 'bob.martin', 'hashedpassword2'),
(3, 'Charlie', 'Lemoine', '2000-11-05', 'charlie.lemoine', 'hashedpassword3'),
(4, 'David', 'Moreau', '1993-02-17', 'david.moreau', 'hashedpassword4'),
(5, 'Emma', 'Leroy', '1997-08-30', 'emma.leroy', 'hashedpassword5'),
(6, 'Lucas', 'Bernard', '1996-05-14', 'lucas.bernard', 'hashedpassword6'),
(7, 'Sophie', 'Rousseau', '2001-09-22', 'sophie.rousseau', 'hashedpassword7'),
(8, 'Thomas', 'Garnier', '1994-12-11', 'thomas.garnier', 'hashedpassword8'),
(9, 'Julie', 'Dupont', '1999-06-18', 'julie.dupont', 'hashedpassword9'),
(10, 'Maxime', 'Fournier', '2002-03-07', 'maxime.fournier', 'hashedpassword10');

-- --------------------------------------------------------

--
-- Structure de la table `test`
--

CREATE TABLE `test` (
  `id_test` int(11) NOT NULL,
  `theme` varchar(100) NOT NULL,
  `date_test` date NOT NULL,
  `nombre_questions` int(11) NOT NULL,
  `score` float DEFAULT NULL CHECK (`score` >= 0 and `score` <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `test`
--

INSERT INTO `test` (`id_test`, `theme`, `date_test`, `nombre_questions`, `score`) VALUES
(1, 'Code de la route', '2024-02-10', 40, 85.5),
(2, 'Signalisation', '2024-03-05', 50, 72),
(3, 'Conduite défensive', '2024-03-15', 45, 80);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `id_personne` (`id_personne`);

--
-- Index pour la table `appartient`
--
ALTER TABLE `appartient`
  ADD PRIMARY KEY (`id_etudiant`,`id_auto_ecole`),
  ADD KEY `id_auto_ecole` (`id_auto_ecole`);

--
-- Index pour la table `autoecole`
--
ALTER TABLE `autoecole`
  ADD PRIMARY KEY (`id_auto_ecole`);

--
-- Index pour la table `avis`
--
ALTER TABLE `avis`
  ADD PRIMARY KEY (`id_avis`),
  ADD KEY `id_etudiant` (`id_etudiant`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id_etudiant`),
  ADD UNIQUE KEY `id_personne` (`id_personne`),
  ADD UNIQUE KEY `neph` (`neph`);

--
-- Index pour la table `examens`
--
ALTER TABLE `examens`
  ADD PRIMARY KEY (`id_examen`);

--
-- Index pour la table `passeexamens`
--
ALTER TABLE `passeexamens`
  ADD PRIMARY KEY (`id_etudiant`,`id_examen`),
  ADD KEY `id_examen` (`id_examen`);

--
-- Index pour la table `passetest`
--
ALTER TABLE `passetest`
  ADD PRIMARY KEY (`id_etudiant`,`id_test`),
  ADD KEY `id_test` (`id_test`);

--
-- Index pour la table `personne`
--
ALTER TABLE `personne`
  ADD PRIMARY KEY (`id_personne`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Index pour la table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id_test`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `autoecole`
--
ALTER TABLE `autoecole`
  MODIFY `id_auto_ecole` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `avis`
--
ALTER TABLE `avis`
  MODIFY `id_avis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `id_etudiant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `examens`
--
ALTER TABLE `examens`
  MODIFY `id_examen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `personne`
--
ALTER TABLE `personne`
  MODIFY `id_personne` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `test`
--
ALTER TABLE `test`
  MODIFY `id_test` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`) ON DELETE CASCADE;

--
-- Contraintes pour la table `appartient`
--
ALTER TABLE `appartient`
  ADD CONSTRAINT `appartient_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE,
  ADD CONSTRAINT `appartient_ibfk_2` FOREIGN KEY (`id_auto_ecole`) REFERENCES `autoecole` (`id_auto_ecole`) ON DELETE CASCADE;

--
-- Contraintes pour la table `avis`
--
ALTER TABLE `avis`
  ADD CONSTRAINT `avis_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE;

--
-- Contraintes pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `etudiant_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personne` (`id_personne`) ON DELETE CASCADE;

--
-- Contraintes pour la table `passeexamens`
--
ALTER TABLE `passeexamens`
  ADD CONSTRAINT `passeexamens_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE,
  ADD CONSTRAINT `passeexamens_ibfk_2` FOREIGN KEY (`id_examen`) REFERENCES `examens` (`id_examen`) ON DELETE CASCADE;

--
-- Contraintes pour la table `passetest`
--
ALTER TABLE `passetest`
  ADD CONSTRAINT `passetest_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`) ON DELETE CASCADE,
  ADD CONSTRAINT `passetest_ibfk_2` FOREIGN KEY (`id_test`) REFERENCES `test` (`id_test`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
