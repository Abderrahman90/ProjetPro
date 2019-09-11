-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 11 sep. 2019 à 14:34
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `abde`
--

-- --------------------------------------------------------

--
-- Structure de la table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
CREATE TABLE IF NOT EXISTS `adresse` (
  `id_adresse` int(11) NOT NULL AUTO_INCREMENT,
  `num_rue` varchar(10) DEFAULT NULL,
  `nom_rue` varchar(145) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `ville` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_adresse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `id_article` int(25) NOT NULL AUTO_INCREMENT,
  `nom_article` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `disponibilité` char(5) NOT NULL,
  `lien_images` varchar(150) NOT NULL,
  `tva_id_TVA` int(25) NOT NULL,
  `Tarif_id_Tarif` int(11) NOT NULL,
  PRIMARY KEY (`id_article`),
  KEY `fk_article_tva1_idx` (`tva_id_TVA`),
  KEY `fk_article_Tarif1_idx` (`Tarif_id_Tarif`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `article_has_stock`
--

DROP TABLE IF EXISTS `article_has_stock`;
CREATE TABLE IF NOT EXISTS `article_has_stock` (
  `article_id_article` int(25) NOT NULL,
  `stock_id_stock` int(11) NOT NULL,
  PRIMARY KEY (`article_id_article`,`stock_id_stock`),
  KEY `fk_article_has_stock_stock1_idx` (`stock_id_stock`),
  KEY `fk_article_has_stock_article1_idx` (`article_id_article`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `prix_total` varchar(30) NOT NULL,
  `date` varchar(30) NOT NULL,
  `id_user` int(50) NOT NULL,
  `soldé` varchar(20) NOT NULL,
  `litige` varchar(150) NOT NULL,
  `id_ville` varchar(30) NOT NULL,
  `tab_users_id_user` int(25) NOT NULL,
  `article_id_article` int(25) NOT NULL,
  KEY `fk_panier_tab_users1_idx` (`tab_users_id_user`),
  KEY `fk_panier_article1_idx` (`article_id_article`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `id_stock` int(11) NOT NULL AUTO_INCREMENT,
  `disponiblité_ville` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_stock`),
  UNIQUE KEY `id_stock_UNIQUE` (`id_stock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `tarif`
--

DROP TABLE IF EXISTS `tarif`;
CREATE TABLE IF NOT EXISTS `tarif` (
  `id_Tarif` int(11) NOT NULL,
  `Tarifcol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_Tarif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `tva`
--

DROP TABLE IF EXISTS `tva`;
CREATE TABLE IF NOT EXISTS `tva` (
  `id_TVA` int(25) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(20) NOT NULL,
  PRIMARY KEY (`id_TVA`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(25) NOT NULL AUTO_INCREMENT,
  `nom_users` varchar(15) NOT NULL,
  `prenom_users` varchar(15) NOT NULL,
  `statut_users` varchar(11) NOT NULL,
  `actif_non` char(1) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(16) NOT NULL,
  `téléphone` varchar(16) NOT NULL,
  `statut_users_id_statut_users` int(25) NOT NULL,
  `adresse_id_adresse` int(11) NOT NULL,
  `Type_user` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `id_user_UNIQUE` (`id_user`),
  KEY `fk_tab_users_adresse1_idx` (`adresse_id_adresse`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

DROP TABLE IF EXISTS `ville`;
CREATE TABLE IF NOT EXISTS `ville` (
  `id_ville` int(11) NOT NULL AUTO_INCREMENT,
  `nom_ville` varchar(45) DEFAULT NULL,
  `région` varchar(45) DEFAULT NULL,
  `departement` varchar(45) DEFAULT NULL,
  `stock_id_stock` int(11) NOT NULL,
  PRIMARY KEY (`id_ville`),
  UNIQUE KEY `id_ville_UNIQUE` (`id_ville`),
  KEY `fk_ville_stock1_idx` (`stock_id_stock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `users`
--
ALTER TABLE `users` ADD FULLTEXT KEY `nom_users` (`nom_users`);
ALTER TABLE `users` ADD FULLTEXT KEY `prenom_users` (`prenom_users`);
ALTER TABLE `users` ADD FULLTEXT KEY `statut_users` (`statut_users`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ville`
--
ALTER TABLE `ville`
  ADD CONSTRAINT `fk_ville_stock1` FOREIGN KEY (`stock_id_stock`) REFERENCES `stock` (`id_stock`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
