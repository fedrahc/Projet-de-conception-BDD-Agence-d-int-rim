DROP SCHEMA IF EXISTS mydb;
CREATE SCHEMA mydb DEFAULT CHARACTER SET utf8;
USE mydb;

create table PERSONNE (
    id_personne      int         not null,
    nom              varchar(45) not null,
    prenom           varchar(45) not null,
    date_naissance   date        not null,
    adresse          varchar(45),
    téléphone        varchar(45),
    email            varchar(45),
    primary key (id_personne));

create table ENTREPRISE (
    id_entreprise  int         not null,
    nom            varchar(45) not null,
    primary key (id_entreprise));

create table COMPETENCE (
    id_competence  int         not null,
    libelle        varchar(45) not null,
    primary key (id_competence));

create table METIER (
    id_metier  int         not null,
    libelle    varchar(45) not null,
    primary key (id_metier));

create table SALARIE (
    id_salarie           int         not null,
    `role`               varchar(45) not null,
    PERSONNE_id_personne int         not null,
    primary key (id_salarie, PERSONNE_id_personne),
    foreign key (PERSONNE_id_personne) references PERSONNE(id_personne)
        on delete cascade on update cascade);

create table CANDIDAT (
    id_candidat          int         not null,
    description          varchar(45),
    disponibilite        varchar(45) not null,
    PERSONNE_id_personne int         not null,
    primary key (id_candidat),
    foreign key (PERSONNE_id_personne) references PERSONNE(id_personne)
        on delete cascade on update cascade,
    check (disponibilite in ('disponible', 'indisponible')));

create table OFFRE_EMPLOI (
    id_offre                 int            not null,
    intitule                 varchar(45)    not null,
    taux_horaire             decimal(10,2)  not null,
    heures_mensuel           int            not null,
    date_debut               date           not null,
    date_fin                 date,
    statut                   varchar(45)    not null,
    type_contrat             varchar(45)    not null,
    date_fermeture           date,
    ENTREPRISE_id_entreprise int            not null,
    SALARIE_id_salarie       int,
    primary key (id_offre, ENTREPRISE_id_entreprise),
    foreign key (ENTREPRISE_id_entreprise) references ENTREPRISE(id_entreprise)
        on delete cascade on update cascade,
    foreign key (SALARIE_id_salarie) references SALARIE(id_salarie)
        on delete no action on update no action,
    check (statut in ('ouverte', 'fermee')),
    check (type_contrat in ('CDI', 'CDD', 'stage', 'benevolat', 'alternance')),
    check (taux_horaire > 0),
    check (heures_mensuel > 0));

create table DIPLOME (
    id_diplome           int         not null,
    libelle              varchar(45) not null,
    niveau_etudes        varchar(45) not null,
    CANDIDAT_id_candidat int         not null,
    primary key (id_diplome, CANDIDAT_id_candidat),
    foreign key (CANDIDAT_id_candidat) references CANDIDAT(id_candidat)
        on delete cascade on update cascade);

create table EXPERIENCE_PRO (
    id_experience        int         not null,
    type_contrat         varchar(45) not null,
    date_debut           date        not null,
    date_fin             date,
    CANDIDAT_id_candidat int         not null,
    primary key (id_experience, CANDIDAT_id_candidat),
    foreign key (CANDIDAT_id_candidat) references CANDIDAT(id_candidat)
        on delete cascade on update cascade,
    check (type_contrat in ('CDI', 'CDD', 'stage', 'benevolat', 'alternance')));

create table CANDIDATURE (
    statut_candidature    int not null,
    CANDIDAT_id_candidat  int not null,
    OFFRE_EMPLOI_id_offre int not null,
    primary key (CANDIDAT_id_candidat, OFFRE_EMPLOI_id_offre),
    foreign key (CANDIDAT_id_candidat) references CANDIDAT(id_candidat)
        on delete cascade on update cascade,
    foreign key (OFFRE_EMPLOI_id_offre) references OFFRE_EMPLOI(id_offre)
        on delete cascade on update cascade,
    check (statut_candidature in (0, 1, 2)));

create table CANDIDAT_METIER (
    CANDIDAT_id_candidat int not null,
    METIER_id_metier     int not null,
    primary key (CANDIDAT_id_candidat, METIER_id_metier),
    foreign key (CANDIDAT_id_candidat) references CANDIDAT(id_candidat)
        on delete cascade on update cascade,
    foreign key (METIER_id_metier) references METIER(id_metier)
        on delete no action on update no action);

create table CANDIDAT_has_COMPETENCE (
    CANDIDAT_id_candidat     int not null,
    COMPETENCE_id_competence int not null,
    primary key (CANDIDAT_id_candidat, COMPETENCE_id_competence),
    foreign key (CANDIDAT_id_candidat) references CANDIDAT(id_candidat)
        on delete cascade on update cascade,
    foreign key (COMPETENCE_id_competence) references COMPETENCE(id_competence)
        on delete no action on update no action);

create table OFFRE_EMPLOI_has_COMPETENCE (
    OFFRE_EMPLOI_id_offre                 int not null,
    OFFRE_EMPLOI_ENTREPRISE_id_entreprise int not null,
    COMPETENCE_id_competence              int not null,
    primary key (OFFRE_EMPLOI_id_offre, OFFRE_EMPLOI_ENTREPRISE_id_entreprise, COMPETENCE_id_competence),
    foreign key (OFFRE_EMPLOI_id_offre, OFFRE_EMPLOI_ENTREPRISE_id_entreprise)
        references OFFRE_EMPLOI(id_offre, ENTREPRISE_id_entreprise)
        on delete cascade on update cascade,
    foreign key (COMPETENCE_id_competence) references COMPETENCE(id_competence)
        on delete no action on update no action);

create table OFFRE_EMPLOI_has_METIER (
    OFFRE_EMPLOI_id_offre                 int not null,
    OFFRE_EMPLOI_ENTREPRISE_id_entreprise int not null,
    METIER_id_metier                      int not null,
    primary key (OFFRE_EMPLOI_id_offre, OFFRE_EMPLOI_ENTREPRISE_id_entreprise, METIER_id_metier),
    foreign key (OFFRE_EMPLOI_id_offre, OFFRE_EMPLOI_ENTREPRISE_id_entreprise)
        references OFFRE_EMPLOI(id_offre, ENTREPRISE_id_entreprise)
        on delete cascade on update cascade,
    foreign key (METIER_id_metier) references METIER(id_metier)
        on delete no action on update no action);


-- ============================================================
-- TRIGGERS ET PROCEDURE (dans l'ordre des contraintes 1 à 7)
-- ============================================================

DELIMITER $$

-- ============================================================
-- Contrainte 1 : Une offre d'emploi ne peut pas être supprimée,
-- uniquement archivée (statut = fermee)
-- ============================================================
CREATE TRIGGER OFFRE_EMPLOI_BEFORE_DELETE
BEFORE DELETE ON OFFRE_EMPLOI
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Suppression interdite : une offre d emploi ne peut pas être supprimée, uniquement archivée.';
END$$


-- ============================================================
-- Contrainte 2 : Lorsqu'une offre passe de ouverte à fermee,
-- la date de fermeture est enregistrée automatiquement
-- ============================================================
CREATE TRIGGER OFFRE_EMPLOI_BEFORE_UPDATE
BEFORE UPDATE ON OFFRE_EMPLOI
FOR EACH ROW
BEGIN
    IF OLD.statut = 'ouverte' AND NEW.statut = 'fermee' THEN
        SET NEW.date_fermeture = CURDATE();
    END IF;
END$$


-- ============================================================
-- Contrainte 3 : Conservation des données non personnelles pour archive
-- La suppression anonymise les données personnelles et bloque la suppression physique
-- ============================================================
CREATE TRIGGER CANDIDAT_BEFORE_DELETE
BEFORE DELETE ON CANDIDAT
FOR EACH ROW
BEGIN
    UPDATE PERSONNE
    SET nom       = 'Anonyme',
        prenom    = 'Anonyme',
        adresse   = NULL,
        téléphone = NULL,
        email     = NULL
    WHERE id_personne = OLD.PERSONNE_id_personne;

    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Action bloquée : Données personnelles effacées (Archive conservée).';
END$$


-- ============================================================
-- Contraintes 4 + 5 combinées (MySQL n'autorise qu'un seul
-- BEFORE UPDATE par table)
-- Contrainte 4 : Le candidat doit être disponible pour obtenir une offre
-- Contrainte 5 : L'offre ne peut pas avoir déjà été obtenue par un autre candidat
-- ============================================================
CREATE TRIGGER CANDIDATURE_BEFORE_UPDATE
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


-- ============================================================
-- Contrainte 6 : Procédure qui change le statut des candidats
-- à disponible si leur emploi actuel est terminé
-- ============================================================
CREATE PROCEDURE update_disponibilite()
BEGIN
    UPDATE CANDIDAT c
    SET c.disponibilite = 'disponible'
    WHERE c.disponibilite = 'indisponible'
      AND NOT EXISTS (
          SELECT 1
          FROM CANDIDATURE cand
          JOIN OFFRE_EMPLOI o ON cand.OFFRE_EMPLOI_id_offre = o.id_offre
          WHERE cand.CANDIDAT_id_candidat = c.id_candidat
            AND cand.statut_candidature = 2
            AND (o.date_fin IS NULL OR o.date_fin >= CURDATE())
      );
END$$


-- ============================================================
-- Contrainte 7 : Les candidats doivent avoir au moins 16 ans
-- ============================================================
CREATE TRIGGER CANDIDAT_BEFORE_INSERT
BEFORE INSERT ON CANDIDAT
FOR EACH ROW
BEGIN
    DECLARE age_candidat INT;
    SELECT TIMESTAMPDIFF(YEAR, date_naissance, CURDATE()) INTO age_candidat
    FROM PERSONNE
    WHERE id_personne = NEW.PERSONNE_id_personne;

    IF age_candidat < 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erreur : Le candidat doit avoir au moins 16 ans.';
    END IF;
END$$

DELIMITER ;