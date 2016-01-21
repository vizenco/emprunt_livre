-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Jeu 21 Janvier 2016 à 16:19
-- Version du serveur :  5.5.46-0+deb8u1
-- Version de PHP :  5.6.14-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `p1403930`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`p1408764`@`%` PROCEDURE `Etat`(in num_pr int, out sexe_attire char, out demande varchar(10))
begin
declare somme_h int default 0;
declare somme_f int default 0;
declare quantite int;

select count(CLIENT.nom) into somme_h
from CLIENT natural join FACTURE natural join LIGNE_FACT natural join PRODUIT
where CLIENT.sexe='m' and PRODUIT.num = num_pr; 

select count(CLIENT.nom) into somme_f
from CLIENT natural join FACTURE natural join LIGNE_FACT natural join PRODUIT
where CLIENT.sexe='f' and PRODUIT.num = num_pr; 

if somme_h < somme_f
then
	set sexe_attire = 'f';
else
	set sexe_attire = 'm';
end if;

select sum(LIGNE_FACT.qte) into quantite
from PRODUIT natural join LIGNE_FACT
where PRODUIT.num = num_pr; 

if quantite<4
then
	set demande = 'faible';
    else if quantite<10
    then
		set demande = 'moyenne';
	else
		set demande = 'forte';
end if;
end if;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `Emprunt`
--

CREATE TABLE IF NOT EXISTS `Emprunt` (
  `id_pers` int(11) NOT NULL,
  `id_album` int(11) NOT NULL,
  `date_deb` date NOT NULL,
  `date_fin` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Emprunt`
--

INSERT INTO `Emprunt` (`id_pers`, `id_album`, `date_deb`, `date_fin`) VALUES
(1, 1, '2016-01-21', '2016-01-28'),
(2, 2, '2016-01-21', '2016-01-28');

-- --------------------------------------------------------

--
-- Structure de la table `Album`
--

CREATE TABLE IF NOT EXISTS `Album` (
  `titre` varchar(30) NOT NULL,
  `auteur` varchar(20) NOT NULL,
`id_album` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Album`
--

INSERT INTO `Album` (`titre`, `auteur`, `id_album`) VALUES
('Copier coller', 'ZEND tuto', 1),
('Wesh wesh', 'canne à peche', 2);

-- --------------------------------------------------------

--
-- Structure de la table `Personne`
--

CREATE TABLE IF NOT EXISTS `Personne` (
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
`id_pers` int(11) NOT NULL,
  `mdp` varchar(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Personne`
--

INSERT INTO `Personne` (`nom`, `prenom`, `id_pers`, `mdp`, `is_admin`) VALUES
('Basile', 'Pracca', 1, 'test', 1),
('Toinon', 'Vincent', 2, 'test', 1);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Emprunt`
--
ALTER TABLE `Emprunt`
 ADD PRIMARY KEY (`id_pers`,`id_album`), ADD KEY `fk_emprunt_album` (`id_album`);

--
-- Index pour la table `Album`
--
ALTER TABLE `Album`
 ADD PRIMARY KEY (`id_album`);

--
-- Index pour la table `Personne`
--
ALTER TABLE `Personne`
 ADD PRIMARY KEY (`id_pers`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Album`
--
ALTER TABLE `Album`
MODIFY `id_album` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `Personne`
--
ALTER TABLE `Personne`
MODIFY `id_pers` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Emprunt`
--
ALTER TABLE `Emprunt`
ADD CONSTRAINT `fk_emprunt_pers` FOREIGN KEY (`id_pers`) REFERENCES `Personne` (`id_pers`),
ADD CONSTRAINT `fk_emprunt_album` FOREIGN KEY (`id_album`) REFERENCES `Album` (`id_album`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
