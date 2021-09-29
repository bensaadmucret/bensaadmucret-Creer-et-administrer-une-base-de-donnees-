-- Version du serveur :  5.7.24
-- Version de PHP : 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `test`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `adress` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `name`, `surname`, `phone`, `email`, `adress`) VALUES
(1, 'John', 'Doe', '+375291234567', 'exemple@wanadoo.fr', '17 rue de la paix'),
(2, 'Jane', 'Doe', '+375291234567', 'exemple@aol.com', '17 rue de la paix'),
(3, 'John', 'Doe', '+375291234567', 'exemple@yahoo.fr', '17 rue de la paix'),
(4, 'Jane', 'Doe', '+375291234567', 'exemple@msn.fr', '17 rue de la paix');

-- --------------------------------------------------------

--
-- Structure de la table `complex`
--

CREATE TABLE `complex` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `complex`
--

INSERT INTO `complex` (`id`, `name`, `address`, `phone`) VALUES
(1, 'cézanne', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545'),
(2, 'pablo picasso', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545'),
(3, 'monet', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545'),
(4, 'vangogh', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545');

-- --------------------------------------------------------

--
-- Structure de la table `film`
--

CREATE TABLE `film` (
  `film_id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `annee` int(4) NOT NULL,
  `realisateur` varchar(255) NOT NULL,
  `acteurs` varchar(255) NOT NULL,
  `synopsis` text NOT NULL,
  `genre` varchar(255) NOT NULL,
  `note` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `release_year` int(11) NOT NULL,
  `rental_duration` int(11) NOT NULL,
  `rental_rate` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `genre`
--

CREATE TABLE `genre` (
  `genre_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `film_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `mode_payment`
--

CREATE TABLE `mode_payment` (
  `id` int(11) NOT NULL,
  `credit_card` varchar(255) NOT NULL,
  `cash` varchar(255) NOT NULL,
  `abonnement` varchar(255) NOT NULL,
  `seance_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `id` int(11) NOT NULL,
  `complex_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL,
  `mode_payment_id` int(11) NOT NULL,
  `tarif_id` int(11) NOT NULL,
  `date_reservation` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `seance`
--

CREATE TABLE `seance` (
  `seance_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `seat`
--

CREATE TABLE `seat` (
  `seat_id` int(11) NOT NULL,
  `row` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `tarifs`
--

CREATE TABLE `tarifs` (
  `id` int(11) NOT NULL,
  `tarif_reduction` varchar(255) NOT NULL,
  `tarif_normal` varchar(255) NOT NULL,
  `tarif_student` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Index pour la table `complex`
--
ALTER TABLE `complex`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`film_id`);

--
-- Index pour la table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`genre_id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`),
  ADD KEY `film_id` (`film_id`),
  ADD KEY `par_ind` (`film_id`);

--
-- Index pour la table `mode_payment`
--
ALTER TABLE `mode_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mode_payment_ibfk_1` (`seance_id`);

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complex_id` (`complex_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `seat_id` (`seat_id`),
  ADD KEY `mode_payment_id` (`mode_payment_id`),
  ADD KEY `tarif_id` (`tarif_id`);

--
-- Index pour la table `seance`
--
ALTER TABLE `seance`
  ADD PRIMARY KEY (`seance_id`),
  ADD KEY `fk_seance_film1_idx` (`film_id`);

--
-- Index pour la table `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`seat_id`);

--
-- Index pour la table `tarifs`
--
ALTER TABLE `tarifs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `complex`
--
ALTER TABLE `complex`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `film`
--
ALTER TABLE `film`
  MODIFY `film_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `genre`
--
ALTER TABLE `genre`
  MODIFY `genre_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `mode_payment`
--
ALTER TABLE `mode_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `seance`
--
ALTER TABLE `seance`
  MODIFY `seance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `seat`
--
ALTER TABLE `seat`
  MODIFY `seat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tarifs`
--
ALTER TABLE `tarifs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `genre`
--
ALTER TABLE `genre`
  ADD CONSTRAINT `genre_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `mode_payment`
--
ALTER TABLE `mode_payment`
  ADD CONSTRAINT `mode_payment_ibfk_1` FOREIGN KEY (`seance_id`) REFERENCES `seance` (`seance_id`);

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id`) REFERENCES `complex` (`id`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`),
  ADD CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`id`) REFERENCES `mode_payment` (`id`),
  ADD CONSTRAINT `reservation_ibfk_5` FOREIGN KEY (`id`) REFERENCES `tarifs` (`id`);

--
-- Contraintes pour la table `seance`
--
ALTER TABLE `seance`
  ADD CONSTRAINT `fk_seance_film1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
