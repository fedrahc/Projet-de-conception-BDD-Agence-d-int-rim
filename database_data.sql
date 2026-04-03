USE `mydb`;

-- -----------------------------------------------------
-- Data for table `mydb`.`PERSONNE`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`PERSONNE` VALUES (1, 'Dolby', 'Perkin', '2003-11-11', '7030 Goodland Parkway', '+46 538 581 5064', 'pdolby0@ovh.net');
INSERT INTO `mydb`.`PERSONNE` VALUES (2, 'Baggs', 'Charlie', '1976-07-27', '57673 Gulseth Street', '+86 197 578 6580', 'cbaggs1@mozilla.org');
INSERT INTO `mydb`.`PERSONNE` VALUES (3, 'Eite', 'Kore', '1986-12-14', '97 Main Circle', '+63 793 470 4136', 'keite2@tuttocitta.it');
INSERT INTO `mydb`.`PERSONNE` VALUES (4, 'Safe', 'Lew', '1980-07-15', '16653 Birchwood Way', '+33 410 839 3382', 'lsafe3@zimbio.com');
INSERT INTO `mydb`.`PERSONNE` VALUES (5, 'Newsham', 'Christiana', '1973-10-04', '3 Twin Pines Parkway', '+52 292 907 9815', 'cnewsham4@simplemachines.org');
INSERT INTO `mydb`.`PERSONNE` VALUES (6, 'Hartzenberg', 'Leontyne', '1970-04-14', '85688 Sunfield Park', '+57 874 339 2673', 'lhartzenberg5@nhs.uk');
INSERT INTO `mydb`.`PERSONNE` VALUES (7, 'Masurel', 'Leonidas', '1987-07-07', '519 Carpenter Pass', '+238 778 877 6372', 'lmasurel6@businesswire.com');
INSERT INTO `mydb`.`PERSONNE` VALUES (8, 'Gainsford', 'Kain', '1977-09-29', '4374 Golf View Drive', '+62 307 335 4947', 'kgainsford7@uol.com.br');
INSERT INTO `mydb`.`PERSONNE` VALUES (9, 'McGurn', 'Netti', '1982-08-26', '473 Old Gate Lane', '+86 875 561 7238', 'nmcgurn8@nydailynews.com');
INSERT INTO `mydb`.`PERSONNE` VALUES (10, 'Chateau', 'Thayne', '1989-05-29', '8417 Mifflin Plaza', '+48 638 295 0372', 'tchateau9@google.es');
INSERT INTO `mydb`.`PERSONNE` VALUES (11, 'Doull', 'Cloe', '1982-02-10', '88 Iowa Place', '+81 943 998 2660', 'cdoulla@abc.net.au');
INSERT INTO `mydb`.`PERSONNE` VALUES (12, 'Steketee', 'Elisa', '1975-12-25', '44 American Road', '+961 393 637 0761', 'esteketeeb@independent.co.uk');
INSERT INTO `mydb`.`PERSONNE` VALUES (13, 'Tolcharde', 'Reeta', '1994-03-22', '0702 Shoshone Hill', '+357 328 217 9043', 'rtolchardec@unc.edu');
INSERT INTO `mydb`.`PERSONNE` VALUES (14, 'Domke', 'Moe', '2001-10-24', '6 Fremont Pass', '+86 474 589 1204', 'mdomked@oaic.gov.au');
INSERT INTO `mydb`.`PERSONNE` VALUES (15, 'Clew', 'Walther', '1978-10-07', '6198 Manufacturers Drive', '+86 691 883 4192', 'wclewe@hp.com');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`ENTREPRISE`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`ENTREPRISE` VALUES (1, 'Quimba');
INSERT INTO `mydb`.`ENTREPRISE` VALUES (2, 'Eimbee');
INSERT INTO `mydb`.`ENTREPRISE` VALUES (3, 'Wikizz');
INSERT INTO `mydb`.`ENTREPRISE` VALUES (4, 'Kwinu');
INSERT INTO `mydb`.`ENTREPRISE` VALUES (5, 'Vinte');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`COMPETENCE`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`COMPETENCE` VALUES (1, 'Docker');
INSERT INTO `mydb`.`COMPETENCE` VALUES (2, 'PHP');
INSERT INTO `mydb`.`COMPETENCE` VALUES (3, 'Python');
INSERT INTO `mydb`.`COMPETENCE` VALUES (4, 'JavaScript');
INSERT INTO `mydb`.`COMPETENCE` VALUES (5, 'Machine Learning');
INSERT INTO `mydb`.`COMPETENCE` VALUES (6, 'React');
INSERT INTO `mydb`.`COMPETENCE` VALUES (7, 'AWS');
INSERT INTO `mydb`.`COMPETENCE` VALUES (8, 'Azure');
INSERT INTO `mydb`.`COMPETENCE` VALUES (9, 'Kubernetes');
INSERT INTO `mydb`.`COMPETENCE` VALUES (10, 'MongoDB');
INSERT INTO `mydb`.`COMPETENCE` VALUES (11, 'PostgreSQL');
INSERT INTO `mydb`.`COMPETENCE` VALUES (12, 'Java');
INSERT INTO `mydb`.`COMPETENCE` VALUES (13, 'MySQL');
INSERT INTO `mydb`.`COMPETENCE` VALUES (14, 'Git');
INSERT INTO `mydb`.`COMPETENCE` VALUES (15, 'Linux');
INSERT INTO `mydb`.`COMPETENCE` VALUES (16, 'TypeScript');
INSERT INTO `mydb`.`COMPETENCE` VALUES (17, 'Vue.js');
INSERT INTO `mydb`.`COMPETENCE` VALUES (18, 'Angular');
INSERT INTO `mydb`.`COMPETENCE` VALUES (19, 'Spring Boot');
INSERT INTO `mydb`.`COMPETENCE` VALUES (20, 'GraphQL');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`METIER`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`METIER` VALUES (1, 'Analyste Data');
INSERT INTO `mydb`.`METIER` VALUES (2, 'Développeur Mobile');
INSERT INTO `mydb`.`METIER` VALUES (3, 'Data Scientist');
INSERT INTO `mydb`.`METIER` VALUES (4, 'Administrateur Systèmes');
INSERT INTO `mydb`.`METIER` VALUES (5, 'Développeur Web');
INSERT INTO `mydb`.`METIER` VALUES (6, 'Architecte Cloud');
INSERT INTO `mydb`.`METIER` VALUES (7, 'Consultant Cybersécurité');
INSERT INTO `mydb`.`METIER` VALUES (8, 'Chef de Projet');
INSERT INTO `mydb`.`METIER` VALUES (9, 'DevOps Engineer');
INSERT INTO `mydb`.`METIER` VALUES (10, 'UX Designer');
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`SALARIE`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`SALARIE` VALUES (1, 'Manager', 1);
INSERT INTO `mydb`.`SALARIE` VALUES (2, 'Secrétaire', 2);
INSERT INTO `mydb`.`SALARIE` VALUES (3, 'Directeur', 3);
INSERT INTO `mydb`.`SALARIE` VALUES (4, 'Assistant', 4);
INSERT INTO `mydb`.`SALARIE` VALUES (5, 'Consultant', 5);
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`CANDIDAT`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`CANDIDAT` VALUES (1, 'Motivé', 'disponible', 6);
INSERT INTO `mydb`.`CANDIDAT` VALUES (2, 'Experimenté', 'disponible', 7);
INSERT INTO `mydb`.`CANDIDAT` VALUES (3, 'Multilingue', 'indisponible', 8);
INSERT INTO `mydb`.`CANDIDAT` VALUES (4, 'Artiste', 'indisponible', 9);
INSERT INTO `mydb`.`CANDIDAT` VALUES (5, 'Professionnel', 'disponible', 10);
INSERT INTO `mydb`.`CANDIDAT` VALUES (6, 'Motivé', 'disponible', 11);
INSERT INTO `mydb`.`CANDIDAT` VALUES (7, 'Réorientation', 'disponible', 12);
INSERT INTO `mydb`.`CANDIDAT` VALUES (8, 'Experimenté', 'indisponible', 13);
INSERT INTO `mydb`.`CANDIDAT` VALUES (9, 'Versatile', 'disponible', 14);
INSERT INTO `mydb`.`CANDIDAT` VALUES (10, 'Mobilité réduite', 'indisponible', 15);
COMMIT;

-- -----------------------------------------------------
-- Data for table `mydb`.`OFFRE_EMPLOI`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (1, 'Senior Quality Engineer', 17.14, 70, '2025-08-08', NULL, 'ouverte', 'alternance', NULL, 1, 2);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (2, 'Help Desk Operator', 12.65, 70, '2025-05-13', '2025-09-19', 'fermée', 'stage', '2025-09-19', 2, 3);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (3, 'Desktop Support Technician', 24.48, 70, '2025-11-09', '2025-07-19', 'ouverte', 'alternance', NULL, 3, 1);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (4, 'Health Coach IV', 20.25, 152, '2026-02-15', NULL, 'fermée', 'alternance', '2025-09-07', 4, 3);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (5, 'Food Chemist', 40.9, 152, '2025-05-11', '2025-09-10', 'ouverte', 'CDD', NULL, 5, 4);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (6, 'Structural Engineer', 14.57, 70, '2025-11-19', NULL, 'ouverte', 'CDI', NULL, 1, 3);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (7, 'Compensation Analyst', 27.89, 160, '2025-11-10', NULL, 'fermée', 'CDI', '2025-11-10', 2, 5);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (8, 'Analog Circuit Design Manager', 35.72, 70, '2025-12-10', NULL, 'ouverte', 'CDI', NULL, 3, 4);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (9, 'Engineer I', 35.54, 70, '2025-09-12', '2025-04-29', 'fermée', 'alternance', '2025-04-29', 4, 4);
INSERT INTO `mydb`.`OFFRE_EMPLOI` VALUES (10, 'Nurse', 41.16, 152, '2026-01-09', NULL, 'ouverte', 'CDI', NULL, 5, 2);
COMMIT;