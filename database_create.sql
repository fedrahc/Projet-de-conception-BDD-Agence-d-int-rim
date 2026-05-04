DROP SCHEMA IF EXISTS mydb;
CREATE SCHEMA mydb DEFAULT CHARACTER SET utf8;
USE mydb;

create table PERSONNE (
    id_personne      int         not null,
    nom              varchar(45) not null,
    prenom           varchar(45) not null,
    date_naissance   date        not null,
    adresse          varchar(45),
    telephone        varchar(45),
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
        on delete cascade on update cascade);

create table OFFRE_EMPLOI (
    id_offre                 int         not null,
    intitule                 varchar(45) not null,
    taux_horaire             decimal     not null,
    heures_mensuel           int         not null,
    date_debut               date        not null,
    date_fin                 date,
    statut                   varchar(45) not null,
    type_contrat             varchar(45) not null,
    date_fermeture           date,
    ENTREPRISE_id_entreprise int         not null,
    SALARIE_id_salarie       int,
    primary key (id_offre, ENTREPRISE_id_entreprise),
    foreign key (ENTREPRISE_id_entreprise) references ENTREPRISE(id_entreprise)
        on delete cascade on update cascade,
    foreign key (SALARIE_id_salarie) references SALARIE(id_salarie)
        on delete no action on update no action);

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
        on delete cascade on update cascade);

create table CANDIDATURE (
    statut_candidature    int not null,
    CANDIDAT_id_candidat  int not null,
    OFFRE_EMPLOI_id_offre int not null,
    primary key (CANDIDAT_id_candidat, OFFRE_EMPLOI_id_offre),
    foreign key (CANDIDAT_id_candidat) references CANDIDAT(id_candidat)
        on delete cascade on update cascade,
    foreign key (OFFRE_EMPLOI_id_offre) references OFFRE_EMPLOI(id_offre)
        on delete cascade on update cascade);

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


-- Triggers --