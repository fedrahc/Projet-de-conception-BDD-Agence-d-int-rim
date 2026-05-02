USE mydb;

-- -----------------------------------------------------
-- Data for table PERSONNE
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO PERSONNE VALUES (1, 'Dolby', 'Perkin', '2003-11-11', '7030 Goodland Parkway', '+46 538 581 5064', 'pdolby0@ovh.net');
INSERT INTO PERSONNE VALUES (2, 'Baggs', 'Charlie', '1976-07-27', '57673 Gulseth Street', '+86 197 578 6580', 'cbaggs1@mozilla.org');
INSERT INTO PERSONNE VALUES (3, 'Eite', 'Kore', '1986-12-14', '97 Main Circle', '+63 793 470 4136', 'keite2@tuttocitta.it');
INSERT INTO PERSONNE VALUES (4, 'Safe', 'Lew', '1980-07-15', '16653 Birchwood Way', '+33 410 839 3382', 'lsafe3@zimbio.com');
INSERT INTO PERSONNE VALUES (5, 'Newsham', 'Christiana', '1973-10-04', '3 Twin Pines Parkway', '+52 292 907 9815', 'cnewsham4@simplemachines.org');
INSERT INTO PERSONNE VALUES (6, 'Hartzenberg', 'Leontyne', '1970-04-14', '85688 Sunfield Park', '+57 874 339 2673', 'lhartzenberg5@nhs.uk');
INSERT INTO PERSONNE VALUES (7, 'Masurel', 'Leonidas', '1987-07-07', '519 Carpenter Pass', '+238 778 877 6372', 'lmasurel6@businesswire.com');
INSERT INTO PERSONNE VALUES (8, 'Gainsford', 'Kain', '1977-09-29', '4374 Golf View Drive', '+62 307 335 4947', 'kgainsford7@uolcom.br');
INSERT INTO PERSONNE VALUES (9, 'McGurn', 'Netti', '1982-08-26', '473 Old Gate Lane', '+86 875 561 7238', 'nmcgurn8@nydailynews.com');
INSERT INTO PERSONNE VALUES (10, 'Chateau', 'Thayne', '1989-05-29', '8417 Mifflin Plaza', '+48 638 295 0372', 'tchateau9@google.es');
INSERT INTO PERSONNE VALUES (11, 'Doull', 'Cloe', '1982-02-10', '88 Iowa Place', '+81 943 998 2660', 'cdoulla@abcnet.au');
INSERT INTO PERSONNE VALUES (12, 'Steketee', 'Elisa', '1975-12-25', '44 American Road', '+961 393 637 0761', 'esteketeeb@independentco.uk');
INSERT INTO PERSONNE VALUES (13, 'Tolcharde', 'Reeta', '1994-03-22', '0702 Shoshone Hill', '+357 328 217 9043', 'rtolchardec@unce.du');
INSERT INTO PERSONNE VALUES (14, 'Domke', 'Moe', '2001-10-24', '6 Fremont Pass', '+86 474 589 1204', 'mdomked@oaicgov.au');
INSERT INTO PERSONNE VALUES (15, 'Clew', 'Walther', '1978-10-07', '6198 Manufacturers Drive', '+86 691 883 4192', 'wclewe@hp.com');
COMMIT;

-- -----------------------------------------------------
-- Data for table ENTREPRISE
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO ENTREPRISE VALUES (1, 'Quimba');
INSERT INTO ENTREPRISE VALUES (2, 'Eimbee');
INSERT INTO ENTREPRISE VALUES (3, 'Wikizz');
INSERT INTO ENTREPRISE VALUES (4, 'Kwinu');
INSERT INTO ENTREPRISE VALUES (5, 'Vinte');
COMMIT;

-- -----------------------------------------------------
-- Data for table COMPETENCE
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO COMPETENCE VALUES (1, 'Docker');
INSERT INTO COMPETENCE VALUES (2, 'PHP');
INSERT INTO COMPETENCE VALUES (3, 'Python');
INSERT INTO COMPETENCE VALUES (4, 'JavaScript');
INSERT INTO COMPETENCE VALUES (5, 'Machine Learning');
INSERT INTO COMPETENCE VALUES (6, 'React');
INSERT INTO COMPETENCE VALUES (7, 'AWS');
INSERT INTO COMPETENCE VALUES (8, 'Azure');
INSERT INTO COMPETENCE VALUES (9, 'Kubernetes');
INSERT INTO COMPETENCE VALUES (10, 'MongoDB');
INSERT INTO COMPETENCE VALUES (11, 'PostgreSQL');
INSERT INTO COMPETENCE VALUES (12, 'Java');
INSERT INTO COMPETENCE VALUES (13, 'MySQL');
INSERT INTO COMPETENCE VALUES (14, 'Git');
INSERT INTO COMPETENCE VALUES (15, 'Linux');
INSERT INTO COMPETENCE VALUES (16, 'TypeScript');
INSERT INTO COMPETENCE VALUES (17, 'Vuejs');
INSERT INTO COMPETENCE VALUES (18, 'Angular');
INSERT INTO COMPETENCE VALUES (19, 'Spring Boot');
INSERT INTO COMPETENCE VALUES (20, 'GraphQL');
COMMIT;

-- -----------------------------------------------------
-- Data for table METIER
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO METIER VALUES (1, 'Analyste Data');
INSERT INTO METIER VALUES (2, 'Développeur Mobile');
INSERT INTO METIER VALUES (3, 'Data Scientist');
INSERT INTO METIER VALUES (4, 'Administrateur Systèmes');
INSERT INTO METIER VALUES (5, 'Développeur Web');
INSERT INTO METIER VALUES (6, 'Architecte Cloud');
INSERT INTO METIER VALUES (7, 'Consultant Cybersécurité');
INSERT INTO METIER VALUES (8, 'Chef de Projet');
INSERT INTO METIER VALUES (9, 'DevOps Engineer');
INSERT INTO METIER VALUES (10, 'UX Designer');
COMMIT;

-- -----------------------------------------------------
-- Data for table SALARIE
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO SALARIE VALUES (1, 'Manager', 1);
INSERT INTO SALARIE VALUES (2, 'Secrétaire', 2);
INSERT INTO SALARIE VALUES (3, 'Directeur', 3);
INSERT INTO SALARIE VALUES (4, 'Assistant', 4);
INSERT INTO SALARIE VALUES (5, 'Consultant', 5);
COMMIT;

-- -----------------------------------------------------
-- Data for table CANDIDAT
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO CANDIDAT VALUES (1, 'Motivé', 'disponible', 6);
INSERT INTO CANDIDAT VALUES (2, 'Experimenté', 'disponible', 7);
INSERT INTO CANDIDAT VALUES (3, 'Multilingue', 'indisponible', 8);
INSERT INTO CANDIDAT VALUES (4, 'Artiste', 'indisponible', 9);
INSERT INTO CANDIDAT VALUES (5, 'Professionnel', 'disponible', 10);
INSERT INTO CANDIDAT VALUES (6, 'Motivé', 'disponible', 11);
INSERT INTO CANDIDAT VALUES (7, 'Réorientation', 'disponible', 12);
INSERT INTO CANDIDAT VALUES (8, 'Experimenté', 'indisponible', 13);
INSERT INTO CANDIDAT VALUES (9, 'Versatile', 'disponible', 14);
INSERT INTO CANDIDAT VALUES (10, 'Mobilité réduite', 'indisponible', 15);
COMMIT;

-- -----------------------------------------------------
-- Data for table OFFRE_EMPLOI
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO OFFRE_EMPLOI VALUES (1, 'Senior Quality Engineer', 17.14, 70, '2025-08-08', NULL, 'ouverte', 'alternance', NULL, 1, 2);
INSERT INTO OFFRE_EMPLOI VALUES (2, 'Help Desk Operator', 16.5, 70, '2025-05-13', '2025-09-19', 'fermée', 'stage', '2025-09-19', 2, 3);
INSERT INTO OFFRE_EMPLOI VALUES (3, 'Desktop Support Technician', 24.48, 70, '2025-11-09', '2025-07-19', 'ouverte', 'alternance', NULL, 3, 1);
INSERT INTO OFFRE_EMPLOI VALUES (4, 'Health Coach IV', 20.25, 152, '2026-02-15', NULL, 'fermée', 'alternance', '2025-09-07', 4, 3);
INSERT INTO OFFRE_EMPLOI VALUES (5, 'Food Chemist', 40.9, 152, '2025-05-11', '2025-09-10', 'ouverte', 'CDD', NULL, 5, 4);
INSERT INTO OFFRE_EMPLOI VALUES (6, 'Structural Engineer', 14.57, 70, '2025-11-19', NULL, 'ouverte', 'CDI', NULL, 1, 3);
INSERT INTO OFFRE_EMPLOI VALUES (7, 'Compensation Analyst', 27.89, 160, '2025-11-10', NULL, 'fermée', 'CDI', '2025-11-10', 2, 5);
INSERT INTO OFFRE_EMPLOI VALUES (8, 'Analog Circuit Design Manager', 3572, 70, '2025-12-10', NULL, 'ouverte', 'CDI', NULL, 3, 4);
INSERT INTO OFFRE_EMPLOI VALUES (9, 'Engineer I', 35.54, 70, '2025-09-12', '2025-04-29', 'fermée', 'alternance', '2025-04-29', 4, 4);
INSERT INTO OFFRE_EMPLOI VALUES (10, 'Nurse', 41.16, 152, '2026-01-09', NULL, 'ouverte', 'CDI', NULL, 5, 2);
COMMIT;


USE mydb;

-- CANDIDAT_has_COMPETENCE
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (1, 3);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (1, 4);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (2, 5);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (2, 12);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (3, 1);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (4, 7);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (5, 3);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (6, 4);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (7, 14);
INSERT INTO CANDIDAT_has_COMPETENCE VALUES (8, 9);

-- CANDIDAT_METIER
INSERT INTO CANDIDAT_METIER VALUES (1, 5);
INSERT INTO CANDIDAT_METIER VALUES (2, 3);
INSERT INTO CANDIDAT_METIER VALUES (3, 4);
INSERT INTO CANDIDAT_METIER VALUES (4, 10);
INSERT INTO CANDIDAT_METIER VALUES (5, 1);
INSERT INTO CANDIDAT_METIER VALUES (6, 5);
INSERT INTO CANDIDAT_METIER VALUES (7, 9);
INSERT INTO CANDIDAT_METIER VALUES (8, 6);

-- OFFRE_EMPLOI_has_COMPETENCE (id_offre, id_entreprise, id_competence)
INSERT INTO OFFRE_EMPLOI_has_COMPETENCE VALUES (1, 1, 3);
INSERT INTO OFFRE_EMPLOI_has_COMPETENCE VALUES (1, 1, 4);
INSERT INTO OFFRE_EMPLOI_has_COMPETENCE VALUES (2, 2, 12);
INSERT INTO OFFRE_EMPLOI_has_COMPETENCE VALUES (3, 3, 1);
INSERT INTO OFFRE_EMPLOI_has_COMPETENCE VALUES (5, 5, 3);

-- OFFRE_EMPLOI_has_METIER (id_offre, id_entreprise, id_metier)
INSERT INTO OFFRE_EMPLOI_has_METIER VALUES (1, 1, 5);
INSERT INTO OFFRE_EMPLOI_has_METIER VALUES (2, 2, 3);
INSERT INTO OFFRE_EMPLOI_has_METIER VALUES (3, 3, 4);
INSERT INTO OFFRE_EMPLOI_has_METIER VALUES (5, 5, 1);

-- CANDIDATURE (statut, id_candidat, id_offre)
INSERT INTO CANDIDATURE VALUES (0, 1, 2);
INSERT INTO CANDIDATURE VALUES (1, 2, 3);
INSERT INTO CANDIDATURE VALUES (2, 3, 5);
INSERT INTO CANDIDATURE VALUES (0, 4, 1);
INSERT INTO CANDIDATURE VALUES (1, 5, 2);

-- DIPLOME (id_diplome, libelle, niveau_etudes, id_candidat)
INSERT INTO DIPLOME VALUES (1, 'Licence Informatique', 'Bac+3', 1);
INSERT INTO DIPLOME VALUES (2, 'Master Data Science', 'Bac+5', 2);
INSERT INTO DIPLOME VALUES (3, 'BTS SIO', 'Bac+2', 3);
INSERT INTO DIPLOME VALUES (4, 'Licence Maths', 'Bac+3', 4);
INSERT INTO DIPLOME VALUES (5, 'Master IA', 'Bac+5', 5);

-- EXPERIENCE_PRO (id_experience, type_contrat, date_debut, date_fin, id_candidat)
INSERT INTO EXPERIENCE_PRO VALUES (1, 'CDI', '2020-01-01', '2023-06-30', 1);
INSERT INTO EXPERIENCE_PRO VALUES (2, 'stage', '2021-03-01', '2021-08-31', 2);
INSERT INTO EXPERIENCE_PRO VALUES (3, 'CDD', '2019-09-01', '2021-12-31', 3);
INSERT INTO EXPERIENCE_PRO VALUES (4, 'alternance', '2022-09-01', NULL, 4);
INSERT INTO EXPERIENCE_PRO VALUES (5, 'CDI', '2018-05-01', '2022-04-30', 5);