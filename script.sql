CREATE DATABASE IF NOT EXISTS `test`;

USE `test`;

# -----------------------------------------------------------------------------
#       TABLE : film
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `film` (
    `film_id` int(11) NOT NULL AUTO_INCREMENT,
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
    `rental_rate` decimal(4, 2) NOT NULL,
     PRIMARY KEY (`film_id`)   
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#      TABLE : genre
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `genre` (
    `genre_id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `description` text NOT NULL,
    `film_id` int(11) NOT NULL,
     KEY (`film_id`),
     INDEX par_ind (`film_id`),
    PRIMARY KEY (`genre_id`),
    UNIQUE KEY `name_UNIQUE` (`name`),
    FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       TABLE : seat
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `seat` (
    `seat_id` int(11) NOT NULL AUTO_INCREMENT,
    `row` int(11) NOT NULL,
    `number` int(11) NOT NULL,
    `type` varchar(50) NOT NULL,
    PRIMARY KEY (`seat_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       TABLE : seance
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `seance` (
    `seance_id` int(11) NOT NULL AUTO_INCREMENT,
    `film_id` int(11) NOT NULL,
    `start_time` datetime NOT NULL,
    `end_time` datetime NOT NULL,
    PRIMARY KEY (`seance_id`),
    KEY `fk_seance_film1_idx` (`film_id`),
    CONSTRAINT `fk_seance_film1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`)

) ENGINE = InnoDB DEFAULT CHARSET = utf8;


# -----------------------------------------------------------------------------
#       TABLE : tarifs
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tarifs` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `tarif_reduction` varchar(255) NOT NULL,
    `tarif_normal` varchar(255) NOT NULL,
    `tarif_student` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       TABLE : clients
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `clients` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `surname` varchar(255) NOT NULL,
    `phone` varchar(255) NOT NULL,
    `email` varchar(255) NOT NULL,
    `adress` text(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `email_UNIQUE` (`email`)
 ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       TABLE : mode_payment
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `mode_payment` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `credit_card` varchar(255) NOT NULL,
    `cash` varchar(255) NOT NULL,
    `abonnement` varchar(255) NOT NULL,
    `seance_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `mode_payment_ibfk_1` FOREIGN KEY (`seance_id`) REFERENCES `seance` (`seance_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       TABLE : complex
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `complex` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `address` varchar(255) NOT NULL,
    `phone` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       TABLE : reservation
# -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `reservation` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `complex_id` int(11) NOT NULL,
    `client_id` int(11) NOT NULL,
    `seat_id` int(11) NOT NULL,
    `mode_payment_id` int(11) NOT NULL,
    `tarif_id` int(11) NOT NULL,
    `date_reservation` datetime NOT NULL,
    PRIMARY KEY (`id`),
    KEY `complex_id` (`complex_id`),
    KEY `client_id` (`client_id`),
    KEY `seat_id` (`seat_id`),
    KEY `mode_payment_id` (`mode_payment_id`),
    KEY `tarif_id` (`tarif_id`),
    CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`id`) REFERENCES `complex` (`id`),
    CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`id`) REFERENCES `clients` (`id`),
    CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`),
    CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`id`) REFERENCES `mode_payment` (`id`),
    CONSTRAINT `reservation_ibfk_5` FOREIGN KEY (`id`) REFERENCES `tarifs` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# -----------------------------------------------------------------------------
#       INSERT DATA
# -----------------------------------------------------------------------------
INSERT `clients` (`name`, `surname`, `phone`, `email`, `adress`) VALUES	
( 'John', 'Doe', '+375291234567', 'exemple@wanadoo.fr', '17 rue de la paix'),
( 'Jane', 'Doe', '+375291234567', 'exemple@aol.com', '17 rue de la paix'),
( 'John', 'Doe', '+375291234567', 'exemple@yahoo.fr', '17 rue de la paix'),
( 'Jane', 'Doe', '+375291234567', 'exemple@msn.fr', '17 rue de la paix');


INSERT `complex` (`name`, `address`, `phone`) VALUES
('cézanne', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545'),
('pablo picasso', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545'),
('monet', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545'),
('vangogh', '1 Rue Marcel Guillaume, 13100 Aix-en-Provence', '+330442424545');

INSERT `film`(  `titre`,`annee`,`realisateur`, `acteurs` , `synopsis`,`genre`, `note`, `image`,`description`,`release_year`, `rental_duration`,`rental_rate`) VALUES
('The Godfather',1972,'Francis Ford Coppola','Marlon Brando, Al Pacino, James Caan','The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.','Crime, Drama','9.2','https://images-na.ssl-images-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWZmNzUtZTdiMjFjNzFlOTc2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SY1000_CR0,0,674,1000_AL_.jpg','The Godfather is a 1972 American crime film directed by Francis Ford Coppola and produced by Albert S. Ruddy. It stars Marlon Brando, Al Pacino, and James Caan. The film is set in the fictional town of Corleone in Southern Italy during the American Civil War (1939–1945), with the story of the Corleone family under the patriarch Vito Corleone.',1972,7,30),
('The Godfather: Part II',1974,'Francis Ford Coppola','Al Pacino, Robert De Niro, Joe Pesci','The continuing saga of the Corleone crime family tells the story of the Corleone crime family over three decades from the events of The Godfather: Part I.','Crime, Drama','9.0','https://images-na.ssl-images-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SY1000_CR0,0,674,1000_AL_.jpg','The Godfather: Part II is a 1974 American crime film directed by Francis Ford Coppola and produced by Albert S. Ruddy. It stars Al Pacino, Robert De Niro, and Joe Pesci. The film is set in the fictional town of Corleone in Southern Italy during the American Civil War (1939–1945), with the story of the Corleone family under the patriarch Vito Corleone.',1974,7,30),
('The Dark Knight',2008,'Christopher Nolan','Christian Bale, Heath Ledger, Aaron Eckhart','When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham, the Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.','Action, Crime, Drama','9.0','https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SY1000_CR0,0,675,1000_AL_.jpg','The Dark Knight is a 2008 superhero film directed, produced, and co-written by Christopher Nolan. Batman (Christian Bale) is an American superhero film based on the DC Comics character Batman, co-produced by Warner Bros. Pictures and distributed by Warner Bros. Television. It is the second installment in the DC Extended Universe (DCEU), the first of which was titled Batman Begins. The film was released in 2008 in the United States and in Europe, with the first theatrical release in the United States on April 18, 2008. The film received generally favorable reviews, and was nominated for an Academy Award for Best Picture and a BAFTA Award for Best Actor. The film was also a box office success, grossing over $1.3 billion worldwide, making it the highest-grossing film of the 2008 decade.',2008,7,30),
('The Dark Knight Rises',2012,'Christopher Nolan','Christian Bale, Anne Hathaway, Gary Oldman',"Eight years after the Joker emerges from his mysterious past, Batman, Gordon and Harvey Dent launch an assault on Gotham\'s organised crime, the Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",'Action, Crime, Drama','9.0','https://images-na.ssl-images-amazon.com/images/M/MV5BMTk4ODQzNDY3Ml5BMl5BanBnXkFtZTcwODA0NTM4Nw@@._V1_SY1000_CR0,0,675,1000_AL_.jpg','The Dark Knight Rises is a 2012 superhero film directed, produced, and co-written by Christopher Nolan. Batman (Christian Bale) is an American superhero film based on the DC Comics character Batman, co-produced by Warner Bros. Pictures and distributed by Warner Bros. Television. It is the second installment in the DC Extended Universe (DCEU), the first of which was titled Batman Begins. The film was released in the United States on May 5, 2012, and in Europe on November 28, 2012. The film received generally favorable reviews, and was nominated for an Academy Award for Best Picture and a BAFTA Award for Best Actor. The film was also a box office success, grossing over $1.3 billion worldwide, making it the highest-grossing film of the 2012 decade.',2012,7,30),
('The Dark Knight Returns',2013,'Christopher Nolan','Christian Bale, Anne Hathaway, Gary Oldman',"Eight years after the Joker emerges from his mysterious past, Batman, Gordon and Harvey Dent launch an assault on Gotham\'s organised crime, the Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.",'Action, Crime, Drama','9.0','https://images-na.ssl-images-amazon.com/images/M/MV5BMjA4MjA3ODkzOV5BMl5BanBnXkFtZTcwMDA5MzYwNw@@._V1_SY1000_CR0,0,675,1000_AL_.jpg','The Dark Knight Returns is a 2013 superhero film directed, produced, and co-written by Christopher Nolan. Batman (Christian Bale) is an American superhero film based on the DC Comics character Batman, co-produced by Warner Bros. Pictures and distributed by Warner Bros. Television. It is the second installment in the DC Extended Universe (DCEU), the first of which was titled Batman Begins. The film was released in the United States on May 5, 2012, and in Europe on November 28, 2012. The film received generally favorable reviews, and was nominated for an Academy Award for Best Picture and a BAFTA Award for Best Actor. The film was also a box office success, grossing over $1.3 billion worldwide, making it the highest-grossing film of the 2012 decade.',2013,7,30);

INSERT `genre`(`name`, `description`, `film_id`) VALUES
('action', 'action', 1),
('comédie', 'comédie', 1),
('drame', 'drame', 1),
('horreur', 'horreur', 1),
('thriller', 'thriller', 1),
('animation', 'animation', 2),
('comédie musicale', 'comédie musicale', 2),
('drame', 'drame', 2);



