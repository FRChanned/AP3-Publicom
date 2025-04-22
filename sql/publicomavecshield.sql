-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 05 déc. 2024 à 19:47
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
-- Base de données : `publicom`
--

-- --------------------------------------------------------
CREATE DATABASE `publicom`;
USE `publicom`;

--
-- Structure de la table `auth_groups_users`
--

DROP TABLE IF EXISTS `auth_groups_users`;
CREATE TABLE IF NOT EXISTS `auth_groups_users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_groups_users_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `auth_groups_users`
--

INSERT INTO `auth_groups_users` (`id`, `user_id`, `group`, `created_at`) VALUES
(1, 1, 'admin', '2024-11-29 20:38:28'),
(4, 4, 'user', '2024-11-30 01:57:40'),
(5, 5, 'user', '2024-12-05 17:40:29');

-- --------------------------------------------------------

--
-- Structure de la table `auth_identities`
--

DROP TABLE IF EXISTS `auth_identities`;
CREATE TABLE IF NOT EXISTS `auth_identities` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `secret` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `secret2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `extra` text COLLATE utf8mb4_general_ci,
  `force_reset` tinyint(1) NOT NULL DEFAULT '0',
  `last_used_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_secret` (`type`,`secret`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `auth_identities`
--

INSERT INTO `auth_identities` (`id`, `user_id`, `type`, `name`, `secret`, `secret2`, `expires`, `extra`, `force_reset`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'email_password', NULL, 'admin@admin.com', '$2y$12$MWGvF2XmdKe2Q6cYNMbnruDS2HGxiZZksVr9VCDK8RHRpO0fAVo.C', NULL, NULL, 0, '2024-12-05 18:18:44', '2024-11-29 20:37:56', '2024-12-05 18:18:44'),
(4, 4, 'email_password', NULL, 'toulouse@publicom.com', '$2y$12$Gh1TW9zs/699BVma5qnkIe95DiVvYd3XKQnQRdHEaeXin0kvGZIzy', NULL, NULL, 0, '2024-12-05 17:39:41', '2024-11-30 01:57:40', '2024-12-05 17:39:41'),
(5, 5, 'email_password', NULL, 'montauban@publicom.com', '$2y$12$SSryNDB93.K1DgGeV4XNLuCqec1unW4dzOqAaVgk/7kGGRQPYGfaW', NULL, NULL, 0, '2024-12-05 18:13:17', '2024-12-05 17:40:29', '2024-12-05 18:13:17');

-- --------------------------------------------------------

--
-- Structure de la table `auth_logins`
--

DROP TABLE IF EXISTS `auth_logins`;
CREATE TABLE IF NOT EXISTS `auth_logins` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type_identifier` (`id_type`,`identifier`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `auth_logins`
--

INSERT INTO `auth_logins` (`id`, `ip_address`, `user_agent`, `id_type`, `identifier`, `user_id`, `date`, `success`) VALUES
(1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-11-29 20:38:40', 1),
(2, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', 2, '2024-11-29 20:40:11', 1),
(3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-11-30 01:57:08', 1),
(4, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'bordeaux@publicom.com', 4, '2024-11-30 01:58:04', 1),
(5, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'bordeaux@publicom.com', NULL, '2024-11-30 01:58:27', 0),
(6, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'bordeaux@publicom.com', NULL, '2024-11-30 01:58:37', 0),
(7, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'bordeaux@publicom.com', NULL, '2024-11-30 01:58:43', 0),
(8, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-11-30 01:58:55', 1),
(9, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'bordeaux@publicom.com', 4, '2024-11-30 01:59:19', 1),
(10, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'toulouse@publicom.com', 4, '2024-11-30 02:03:44', 1),
(11, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 17:37:15', 1),
(12, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', NULL, '2024-12-05 17:39:27', 0),
(13, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'toulouse@publicom.com', 4, '2024-12-05 17:39:41', 1),
(14, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', NULL, '2024-12-05 17:39:54', 0),
(15, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 17:40:03', 1),
(16, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', 5, '2024-12-05 17:40:42', 1),
(17, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 17:40:55', 1),
(18, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', 5, '2024-12-05 17:50:27', 1),
(19, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 17:51:03', 1),
(20, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', 5, '2024-12-05 17:51:23', 1),
(21, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 17:52:45', 1),
(22, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', 5, '2024-12-05 17:53:32', 1),
(23, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 17:56:58', 1),
(24, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'montauban@publicom.com', 5, '2024-12-05 18:13:17', 1),
(25, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'email_password', 'admin@admin.com', 1, '2024-12-05 18:18:44', 1);

-- --------------------------------------------------------

--
-- Structure de la table `auth_permissions_users`
--

DROP TABLE IF EXISTS `auth_permissions_users`;
CREATE TABLE IF NOT EXISTS `auth_permissions_users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `permission` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_permissions_users_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_remember_tokens`
--

DROP TABLE IF EXISTS `auth_remember_tokens`;
CREATE TABLE IF NOT EXISTS `auth_remember_tokens` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `selector` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `hashedValidator` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `expires` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `selector` (`selector`),
  KEY `auth_remember_tokens_user_id_foreign` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_token_logins`
--

DROP TABLE IF EXISTS `auth_token_logins`;
CREATE TABLE IF NOT EXISTS `auth_token_logins` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type_identifier` (`id_type`,`identifier`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commune`
--

DROP TABLE IF EXISTS `commune`;
CREATE TABLE IF NOT EXISTS `commune` (
  `IDCOMMUNE` int NOT NULL AUTO_INCREMENT,
  `NOM` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DEPARTEMENT` int NOT NULL,
  PRIMARY KEY (`IDCOMMUNE`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commune`
--

INSERT INTO `commune` (`IDCOMMUNE`, `NOM`, `DEPARTEMENT`) VALUES
(1, 'Montauban', 82),
(2, 'Paris', 75),
(3, 'Toulouse', 31),
(4, 'Lyon', 69),
(5, 'Bordeaux', 33),
(6, 'Rennes', 35),
(7, 'Marseille', 13),
(8, 'Béziers', 34),
(9, 'Metz', 57),
(10, 'Perpignan', 66);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `IDMESSAGE` int NOT NULL AUTO_INCREMENT,
  `IDCOMMUNE` int NOT NULL,
  `ETAT` tinyint(1) NOT NULL,
  `TEXTE` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `COULEUR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TAILLE` decimal(65,2) NOT NULL,
  PRIMARY KEY (`IDMESSAGE`),
  KEY `I_FK_MESSAGE_COMMUNE` (`IDCOMMUNE`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `message`
--

/* INSERT INTO `message` (`IDMESSAGE`, `IDCOMMUNE`, `ETAT`, `TEXTE`, `COULEUR`, `TAILLE`) VALUES
(1, 1, 0, 'Rouge', '15', 3.00); */

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `version` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `namespace` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `time` int NOT NULL,
  `batch` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2020-12-28-223112', 'CodeIgniter\\Shield\\Database\\Migrations\\CreateAuthTables', 'default', 'CodeIgniter\\Shield', 1732912612, 1),
(2, '2021-07-04-041948', 'CodeIgniter\\Settings\\Database\\Migrations\\CreateSettingsTable', 'default', 'CodeIgniter\\Settings', 1732912612, 1),
(3, '2021-11-14-143905', 'CodeIgniter\\Settings\\Database\\Migrations\\AddContextColumn', 'default', 'CodeIgniter\\Settings', 1732912612, 1),
(4, '2024-11-08-123109', 'App\\Database\\Migrations\\AddColumnsToUsers', 'default', 'App', 1732912612, 1);

-- --------------------------------------------------------

--
-- Structure de la table `panneau`
--

DROP TABLE IF EXISTS `panneau`;
CREATE TABLE IF NOT EXISTS `panneau` (
  `IDPANNEAU` int NOT NULL AUTO_INCREMENT,
  `IDCOMMUNE` int NOT NULL,
  `REFERENCE` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LATITUDE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LONGITUDE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IDPANNEAU`),
  KEY `I_FK_PANNEAU_COMMUNE` (`IDCOMMUNE`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `panneau`
--

/* INSERT INTO `panneau` (`IDPANNEAU`, `IDCOMMUNE`, `REFERENCE`, `LATITUDE`, `LONGITUDE`) VALUES
(52, 1, 'oui', '@44.0437593', 'sgfsdfsdf'); */

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` text COLLATE utf8mb4_general_ci,
  `type` varchar(31) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'string',
  `context` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_message` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `last_active` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `IDCOMMUNE` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `I_FK_PANNEAU_COMMUNE` (`IDCOMMUNE`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `status`, `status_message`, `active`, `last_active`, `created_at`, `updated_at`, `deleted_at`, `IDCOMMUNE`) VALUES
(1, 'admin', NULL, NULL, 0, '2024-12-05 19:46:11', '2024-11-29 20:37:56', '2024-11-29 20:37:56', NULL, NULL),
(4, 'toulouse', NULL, NULL, 0, '2024-12-05 17:39:47', '2024-11-30 01:57:40', '2024-11-30 02:03:29', NULL, 3),
(5, 'montauban', NULL, NULL, 0, '2024-12-05 18:18:01', '2024-12-05 17:40:29', '2024-12-05 17:40:29', NULL, 1);

-- --------------------------------------------------------

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `auth_groups_users`
--
ALTER TABLE `auth_groups_users`
  ADD CONSTRAINT `auth_groups_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `auth_identities`
--
ALTER TABLE `auth_identities`
  ADD CONSTRAINT `auth_identities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `auth_permissions_users`
--
ALTER TABLE `auth_permissions_users`
  ADD CONSTRAINT `auth_permissions_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `auth_remember_tokens`
--
ALTER TABLE `auth_remember_tokens`
  ADD CONSTRAINT `auth_remember_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`IDCOMMUNE`) REFERENCES `commune` (`IDCOMMUNE`);

--
-- Contraintes pour la table `panneau`
--
ALTER TABLE `panneau`
  ADD CONSTRAINT `panneau_ibfk_1` FOREIGN KEY (`IDCOMMUNE`) REFERENCES `commune` (`IDCOMMUNE`);
  
 --
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`IDCOMMUNE`) REFERENCES `commune` (`IDCOMMUNE`);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
