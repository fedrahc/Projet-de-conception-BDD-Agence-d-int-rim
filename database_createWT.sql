USE mydb;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `PERSONNE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PERSONNE` (
  `id_personne` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `date_naissance` DATE NOT NULL,
  `adresse` VARCHAR(45) NULL,
  `téléphone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id_personne`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ENTREPRISE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ENTREPRISE` (
  `id_entreprise` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_entreprise`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMPETENCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMPETENCE` (
  `id_competence` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_competence`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `METIER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `METIER` (
  `id_metier` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_metier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SALARIE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SALARIE` (
  `id_salarie` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `PERSONNE_id_personne` INT NOT NULL,
  PRIMARY KEY (`id_salarie`, `PERSONNE_id_personne`),
  INDEX `fk_SALARIE_PERSONNE1_idx` (`PERSONNE_id_personne` ASC) VISIBLE,
  CONSTRAINT `fk_SALARIE_PERSONNE1`
    FOREIGN KEY (`PERSONNE_id_personne`)
    REFERENCES `PERSONNE` (`id_personne`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CANDIDAT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CANDIDAT` (
  `id_candidat` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `disponibilite` VARCHAR(45) NOT NULL,
  `PERSONNE_id_personne` INT NOT NULL,
  PRIMARY KEY (`id_candidat`, `PERSONNE_id_personne`),
  INDEX `fk_CANDIDAT_PERSONNE1_idx` (`PERSONNE_id_personne` ASC) VISIBLE,
  CONSTRAINT `fk_CANDIDAT_PERSONNE1`
    FOREIGN KEY (`PERSONNE_id_personne`)
    REFERENCES `PERSONNE` (`id_personne`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OFFRE_EMPLOI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OFFRE_EMPLOI` (
  `id_offre` INT NOT NULL,
  `intitule` VARCHAR(45) NOT NULL,
  `taux_horaire` DECIMAL NOT NULL,
  `heures_mensuel` INT NOT NULL,
  `date_debut` DATE NOT NULL,
  `date_fin` DATE NULL,
  `statut` VARCHAR(45) NOT NULL,
  `type_contrat` VARCHAR(45) NOT NULL,
  `date_fermeture` DATE NULL,
  `ENTREPRISE_id_entreprise` INT NOT NULL,
  `SALARIE_id_salarie` INT NULL,
  PRIMARY KEY (`id_offre`, `ENTREPRISE_id_entreprise`),
  INDEX `fk_OFFRE_EMPLOI_ENTREPRISE_idx` (`ENTREPRISE_id_entreprise` ASC) VISIBLE,
  INDEX `fk_OFFRE_EMPLOI_SALARIE1_idx` (`SALARIE_id_salarie` ASC) VISIBLE,
  CONSTRAINT `fk_OFFRE_EMPLOI_ENTREPRISE`
    FOREIGN KEY (`ENTREPRISE_id_entreprise`)
    REFERENCES `ENTREPRISE` (`id_entreprise`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OFFRE_EMPLOI_SALARIE1`
    FOREIGN KEY (`SALARIE_id_salarie`)
    REFERENCES `SALARIE` (`id_salarie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIPLOME`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIPLOME` (
  `id_diplome` INT NOT NULL,
  `libelle` VARCHAR(45) NOT NULL,
  `niveau_etudes` VARCHAR(45) NOT NULL,
  `CANDIDAT_id_candidat` INT NOT NULL,
  PRIMARY KEY (`id_diplome`, `CANDIDAT_id_candidat`),
  INDEX `fk_DIPLOME_CANDIDAT1_idx` (`CANDIDAT_id_candidat` ASC) VISIBLE,
  CONSTRAINT `fk_DIPLOME_CANDIDAT1`
    FOREIGN KEY (`CANDIDAT_id_candidat`)
    REFERENCES `CANDIDAT` (`id_candidat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EXPERIENCE_PRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EXPERIENCE_PRO` (
  `id_experience` INT NOT NULL,
  `type_contrat` VARCHAR(45) NOT NULL,
  `date_debut` DATE NOT NULL,
  `date_fin` DATE NULL,
  `CANDIDAT_id_candidat` INT NOT NULL,
  PRIMARY KEY (`id_experience`, `CANDIDAT_id_candidat`),
  INDEX `fk_EXPERIENCE_PRO_CANDIDAT1_idx` (`CANDIDAT_id_candidat` ASC) VISIBLE,
  CONSTRAINT `fk_EXPERIENCE_PRO_CANDIDAT1`
    FOREIGN KEY (`CANDIDAT_id_candidat`)
    REFERENCES `CANDIDAT` (`id_candidat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CANDIDATURE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CANDIDATURE` (
  `statut_candidature` INT NOT NULL,
  `CANDIDAT_id_candidat` INT NOT NULL,
  `OFFRE_EMPLOI_id_offre` INT NOT NULL,
  PRIMARY KEY (`CANDIDAT_id_candidat`, `OFFRE_EMPLOI_id_offre`),
  INDEX `fk_CANDIDATURE_OFFRE_EMPLOI1_idx` (`OFFRE_EMPLOI_id_offre` ASC) VISIBLE,
  CONSTRAINT `fk_CANDIDATURE_CANDIDAT1`
    FOREIGN KEY (`CANDIDAT_id_candidat`)
    REFERENCES `CANDIDAT` (`id_candidat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CANDIDATURE_OFFRE_EMPLOI1`
    FOREIGN KEY (`OFFRE_EMPLOI_id_offre`)
    REFERENCES `OFFRE_EMPLOI` (`id_offre`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CANDIDAT_METIER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CANDIDAT_METIER` (
  `CANDIDAT_id_candidat` INT NOT NULL,
  `METIER_id_metier` INT NOT NULL,
  PRIMARY KEY (`CANDIDAT_id_candidat`, `METIER_id_metier`),
  INDEX `fk_CANDIDAT_METIER_METIER1_idx` (`METIER_id_metier` ASC) VISIBLE,
  CONSTRAINT `fk_CANDIDAT_METIER_CANDIDAT1`
    FOREIGN KEY (`CANDIDAT_id_candidat`)
    REFERENCES `CANDIDAT` (`id_candidat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CANDIDAT_METIER_METIER1`
    FOREIGN KEY (`METIER_id_metier`)
    REFERENCES `METIER` (`id_metier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CANDIDAT_has_COMPETENCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CANDIDAT_has_COMPETENCE` (
  `CANDIDAT_id_candidat` INT NOT NULL,
  `COMPETENCE_id_competence` INT NOT NULL,
  PRIMARY KEY (`CANDIDAT_id_candidat`, `COMPETENCE_id_competence`),
  INDEX `fk_CANDIDAT_has_COMPETENCE_COMPETENCE1_idx` (`COMPETENCE_id_competence` ASC) VISIBLE,
  INDEX `fk_CANDIDAT_has_COMPETENCE_CANDIDAT1_idx` (`CANDIDAT_id_candidat` ASC) VISIBLE,
  CONSTRAINT `fk_CANDIDAT_has_COMPETENCE_CANDIDAT1`
    FOREIGN KEY (`CANDIDAT_id_candidat`)
    REFERENCES `CANDIDAT` (`id_candidat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CANDIDAT_has_COMPETENCE_COMPETENCE1`
    FOREIGN KEY (`COMPETENCE_id_competence`)
    REFERENCES `COMPETENCE` (`id_competence`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OFFRE_EMPLOI_has_COMPETENCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OFFRE_EMPLOI_has_COMPETENCE` (
  `OFFRE_EMPLOI_id_offre` INT NOT NULL,
  `OFFRE_EMPLOI_ENTREPRISE_id_entreprise` INT NOT NULL,
  `COMPETENCE_id_competence` INT NOT NULL,
  PRIMARY KEY (`OFFRE_EMPLOI_id_offre`, `OFFRE_EMPLOI_ENTREPRISE_id_entreprise`, `COMPETENCE_id_competence`),
  INDEX `fk_OFFRE_EMPLOI_has_COMPETENCE_COMPETENCE1_idx` (`COMPETENCE_id_competence` ASC) VISIBLE,
  INDEX `fk_OFFRE_EMPLOI_has_COMPETENCE_OFFRE_EMPLOI1_idx` (`OFFRE_EMPLOI_id_offre` ASC, `OFFRE_EMPLOI_ENTREPRISE_id_entreprise` ASC) VISIBLE,
  CONSTRAINT `fk_OFFRE_EMPLOI_has_COMPETENCE_OFFRE_EMPLOI1`
    FOREIGN KEY (`OFFRE_EMPLOI_id_offre` , `OFFRE_EMPLOI_ENTREPRISE_id_entreprise`)
    REFERENCES `OFFRE_EMPLOI` (`id_offre` , `ENTREPRISE_id_entreprise`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OFFRE_EMPLOI_has_COMPETENCE_COMPETENCE1`
    FOREIGN KEY (`COMPETENCE_id_competence`)
    REFERENCES `COMPETENCE` (`id_competence`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OFFRE_EMPLOI_has_METIER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OFFRE_EMPLOI_has_METIER` (
  `OFFRE_EMPLOI_id_offre` INT NOT NULL,
  `OFFRE_EMPLOI_ENTREPRISE_id_entreprise` INT NOT NULL,
  `METIER_id_metier` INT NOT NULL,
  PRIMARY KEY (`OFFRE_EMPLOI_id_offre`, `OFFRE_EMPLOI_ENTREPRISE_id_entreprise`, `METIER_id_metier`),
  INDEX `fk_OFFRE_EMPLOI_has_METIER_METIER1_idx` (`METIER_id_metier` ASC) VISIBLE,
  INDEX `fk_OFFRE_EMPLOI_has_METIER_OFFRE_EMPLOI1_idx` (`OFFRE_EMPLOI_id_offre` ASC, `OFFRE_EMPLOI_ENTREPRISE_id_entreprise` ASC) VISIBLE,
  CONSTRAINT `fk_OFFRE_EMPLOI_has_METIER_OFFRE_EMPLOI1`
    FOREIGN KEY (`OFFRE_EMPLOI_id_offre` , `OFFRE_EMPLOI_ENTREPRISE_id_entreprise`)
    REFERENCES `OFFRE_EMPLOI` (`id_offre` , `ENTREPRISE_id_entreprise`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OFFRE_EMPLOI_has_METIER_METIER1`
    FOREIGN KEY (`METIER_id_metier`)
    REFERENCES `METIER` (`id_metier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- procedure update_disponibilite
-- -----------------------------------------------------

DELIMITER $$
CREATE PROCEDURE `update_disponibilite` ()
BEGIN
    -- Règle 6 : Changer le statut des candidats à "disponible" si leur emploi est terminé
    UPDATE CANDIDAT c
    SET c.disponibilite = 'disponible'
    WHERE c.disponibilite = 'indisponible'
      AND NOT EXISTS (
          -- On vérifie qu'il n'y a PAS de contrat encore actif pour ce candidat
          SELECT 1
          FROM CANDIDATURE cand
          JOIN OFFRE_EMPLOI o ON cand.OFFRE_EMPLOI_id_offre = o.id_offre
          WHERE cand.CANDIDAT_id_candidat = c.id_candidat
            AND cand.statut_candidature = 2 
            AND (o.date_fin IS NULL OR o.date_fin >= CURDATE())
      );
END$$

DELIMITER ;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`CANDIDAT_BEFORE_INSERT` BEFORE INSERT ON `CANDIDAT` FOR EACH ROW
BEGIN
DECLARE age_candidat INT;
	-- Règle 7 : Vérifier que le candidat a au moins 16 ans
    SELECT TIMESTAMPDIFF(YEAR, date_naissance, CURDATE()) INTO age_candidat
    FROM PERSONNE
    WHERE id_personne = NEW.PERSONNE_id_personne;

    IF age_candidat < 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erreur : Le candidat doit avoir au moins 16 ans.';
    END IF;
END$$

CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`CANDIDAT_BEFORE_DELETE` BEFORE DELETE ON `CANDIDAT` FOR EACH ROW
BEGIN
-- Règle 3 : Conservation des données non personnelles (Archive)
    UPDATE PERSONNE
    SET nom = 'Anonyme',
        prenom = 'Anonyme',
        adresse = NULL,
        téléphone = NULL,
        email = NULL
    WHERE id_personne = OLD.PERSONNE_id_personne;

    -- On bloque la suppression physique de la ligne
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Action bloquée : Données personnelles effacées (Archive conservée).';
END$$

CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`OFFRE_EMPLOI_BEFORE_DELETE` BEFORE DELETE ON `OFFRE_EMPLOI` FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Suppression interdite : une offre d emploi ne peut pas être supprimée, uniquement archivée.';
END$$

CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`OFFRE_EMPLOI_BEFORE_UPDATE` BEFORE UPDATE ON `OFFRE_EMPLOI` FOR EACH ROW
BEGIN
   IF OLD.statut = 'ouverte' AND NEW.statut = 'fermee' THEN
        SET NEW.date_fermeture = CURDATE();
   END IF;
END$$

CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`CANDIDATURE_BEFORE_UPDATE`
BEFORE UPDATE ON CANDIDATURE
FOR EACH ROW
BEGIN
    DECLARE candidat_indispo INT;
    DECLARE offre_deja_obtenue INT;

    IF NEW.statut_candidature = 2 AND OLD.statut_candidature != 2 THEN

        -- Contrainte 4 : Le candidat est-il disponible ?
        SELECT COUNT(*) INTO candidat_indispo
        FROM CANDIDATURE c
        JOIN OFFRE_EMPLOI o ON c.OFFRE_EMPLOI_id_offre = o.id_offre
        WHERE c.CANDIDAT_id_candidat = NEW.CANDIDAT_id_candidat
          AND c.statut_candidature = 2
          AND (o.date_fin IS NULL OR o.date_fin > CURDATE());

        IF candidat_indispo > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erreur (Règle 4) : Ce candidat n est pas disponible (déjà en poste).';
        END IF;

        -- Contrainte 5 : L'offre a-t-elle déjà été obtenue par un autre candidat ?
        SELECT COUNT(*) INTO offre_deja_obtenue
        FROM CANDIDATURE
        WHERE OFFRE_EMPLOI_id_offre = NEW.OFFRE_EMPLOI_id_offre
          AND statut_candidature = 2
          AND CANDIDAT_id_candidat != NEW.CANDIDAT_id_candidat;

        IF offre_deja_obtenue > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erreur (Règle 5) : Cette offre a déjà été obtenue par un autre candidat.';
        END IF;

    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
